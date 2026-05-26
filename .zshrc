# =======================================
#         ОПТИМИЗИРОВАННЫЙ .ZSHRC
# =======================================
# Применяйте после сохранения:
#   mkdir -p ~/.zsh ~/.cache
#   brew shellenv > ~/.cache/brew-shellenv.zsh
#   kubectl completion zsh > ~/.zsh/_kubectl
#   volta completions zsh > ~/.zsh/_volta
#   bw completion --shell zsh > ~/.zsh/_bitwarden
#   glow completion zsh > ~/.zsh/_glow
#   # если не используете Starship, установите: brew install starship
# =======================================

# =======================================
#         DEBUGGING & PROFILING
# =======================================
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zmodload zsh/zprof
fi

# =======================================
#          ZSH-DEFER SETUP (ленивый загрузчик) с проверкой
# =======================================
if [[ -f ~/zsh-defer/zsh-defer.plugin.zsh ]]; then
  source ~/zsh-defer/zsh-defer.plugin.zsh
else
  echo "Warning: zsh-defer not found, loading will be synchronous"
  # Определяем пустую функцию, чтобы скрипт не падал
  function zsh-defer() { "$@"; }
fi

# =======================================
#       Oh-My-Zsh и ОСНОВНЫЕ ПЕРЕМЕННЫЕ
# =======================================
export ZSH="/Users/admakeye/.oh-my-zsh"

# Отключаем тему OMZ, чтобы не перезаписывать промпт Starship
ZSH_THEME=""

# ========== Performance tweaks ==========
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_COMPFIX="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# ========== Тема: Starship (быстрая) ==========
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
else
  # минимальный промпт (пользователь@хост:путь) на случай отсутствия starship
  PROMPT='%F{green}%n@%m %F{blue}%~%f %# '
fi

# =======================================
#     КЕШИРОВАНИЕ ПЕРЕМЕННЫХ ОКРУЖЕНИЯ (brew)
# =======================================
if [[ -f "$HOME/.cache/brew-shellenv.zsh" ]]; then
  source "$HOME/.cache/brew-shellenv.zsh"
else
  mkdir -p "$HOME/.cache"
  brew shellenv >"$HOME/.cache/brew-shellenv.zsh"
  source "$HOME/.cache/brew-shellenv.zsh"
fi

# =======================================
#          ЯЗЫКОВАЯ НАСТРОЙКА
# =======================================
export LANG=en_US.UTF-8
# export LANG=ru_RU.UTF-8

# =======================================
#       ПЕРЕДНАСТРОЙКА ПРИ ЛОКАЛЬНЫХ/SSH СЕССИЯХ
# =======================================
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export SSH_KEY_PATH="~/.ssh/rsa_id"

# =======================================
#            ПАТЧИ ДЛЯ PATH (без дублей)
# =======================================
export PATH="/usr/local/opt/curl/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export BUN_INSTALL="$HOME/.bun"
export PATH="$VOLTA_HOME/bin:$BUN_INSTALL/bin:$PATH"

# =======================================
#          FZF НАСТРОЙКИ (ленивая инициализация)
# =======================================
export FZF_DEFAULT_OPTS="--height 100% --border --preview 'bat --style=numbers --color=always {}'"
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

# =======================================
#          КОМПЛЕШЕНЫ (кешированные)
# =======================================
fpath=($HOME/.zsh/oc $HOME/.zsh/pure $HOME/.zsh $fpath)
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges true

ZSH_COMPDUMP="$HOME/.zcompdump"
autoload -Uz compinit
compinit -C -d "$ZSH_COMPDUMP" 2>/dev/null

# =======================================
#          ПОДКЛЮЧЕНИЕ ОСТАЛЬНЫХ ЧАСТЕЙ OH-MY-ZSH (лениво)
# =======================================
# Обратите внимание: ZSH_THEME уже пустая, PROMPT не будет перезаписан
zsh-defer -c '
#     plugins=(git)
    source "$ZSH/oh-my-zsh.sh"
'

# =======================================
#      ЛЕНИВОЕ ПОДКЛЮЧЕНИЕ ТЯЖЁЛЫХ КОМПЛЕШЕНОВ (из заранее созданных файлов)
# =======================================
zsh-defer -c '[ -f "$HOME/.zsh/_kubectl" ] && source "$HOME/.zsh/_kubectl"'
zsh-defer -c '[ -f "$HOME/.zsh/_volta" ] && source "$HOME/.zsh/_volta"'
zsh-defer -c '[ -f "$HOME/.zsh/_bitwarden" ] && source "$HOME/.zsh/_bitwarden"'
zsh-defer -c '[ -f "$HOME/.zsh/_glow" ] && source "$HOME/.zsh/_glow"'
zsh-defer -c '[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"'

# =======================================
#      ПРОЧИЕ ЛЕНИВЫЕ ЗАГРУЗКИ
# =======================================
zsh-defer source "$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
zsh-defer source "$HOME/.jfrog/jfrog_zsh_completion"
zsh-defer -c '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh'
zsh-defer -c '[[ -f "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"'
zsh-defer -c 'command -v fzf &> /dev/null && source <(fzf --zsh)'
zsh-defer -c 'autoload -U zmv'

# =======================================
#          ПОДДЕРЖКА BASH-КОМАНД (лениво)
# =======================================
zsh-defer -c '
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C /usr/local/bin/vault vault
'

# =======================================
#          НАСТРОЙКА КУРСОРА (закомментирована)
# =======================================
# zle_highlight=('default:cursor:blinkingblock')
# zle_highlight+=('overwrite:cursor:underline')

# =======================================
#               АЛИАСЫ (все, без defer)
# =======================================
alias proxy='export http_proxy="http://a.makeev%40mts.ai:${MTSAI_PASSWORD}@proxy-eurotunnel.mts.ai:3128"; export https_proxy=$http_proxy; export all_proxy=$http_proxy'
alias disproxy='unset http_proxy https_proxy all_proxy'

# =======================================
#          NO_PROXY ДЛЯ GITHUB
# =======================================
export NO_PROXY="github.com,api.github.com,uploads.github.com,objects.githubusercontent.com,ghcr.io,*.github.com,*.githubusercontent.com"
export no_proxy="$NO_PROXY"

# =======================================
#          ОТЛОЖЕННЫЙ ЗАПУСК eval (am, typo)
# =======================================
if command -v am &>/dev/null; then
  zsh-defer -c 'eval "$(am init zsh)"'
  zsh-defer -c 'eval "$(typo init zsh)"'
fi

# =======================================
#          DEBUGGING REPORT (if enabled)
# =======================================
if [[ -n "$ZSH_DEBUGRC" ]]; then
  zprof
fi
