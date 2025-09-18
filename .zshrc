# =======================================
#         DEBUGGING & PROFILING
# =======================================
if [[ -n "$ZSH_DEBUGRC" ]]; then
    zmodload zsh/zprof # включение профилировщика для анализа времени загрузки
fi

# =======================================
#          ZSH-DEFER SETUP
# =======================================
source ~/zsh-defer/zsh-defer.plugin.zsh # ленивый загрузчик для ускорения старта

# =======================================
#       Oh-My-Zsh и ОСНОВНЫЕ ПЕРЕМЕННЫЕ
# =======================================
export ZSH="/Users/admakeye/.oh-my-zsh"

# ========== Performance tweaks ==========
DISABLE_AUTO_TITLE="true"            # отключаем изменение заголовка терминала
DISABLE_AUTO_UPDATE="true"           # отключаем автообновления oh-my-zsh
DISABLE_COMPFIX="true"               # отключаем исправление проблем авто-дополнения (комплешены кешим сами)
DISABLE_MAGIC_FUNCTIONS="true"       # отключаем магические функции (ускорение)
DISABLE_UNTRACKED_FILES_DIRTY="true" # ускоряем работу интеграции git

# ========== Тема и настройка prompt ==========
ZSH_THEME="spaceship" # тема Spaceship — при необходимости смените на более легкую

SPACESHIP_GIT_STATUS_SHOW="true"
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_GIT_STATUS_UNTRACKED="?"
SPACESHIP_GIT_STATUS_MODIFIED="*"
SPACESHIP_GIT_STATUS_UNMERGED="!"

# =======================================
#               ПЛАГИНЫ
# =======================================
plugins=(
    oc
    git
    colored-man-pages
    npm
    httpie
    docker
    docker-compose
    jq
)

# =======================================
#          Подключение fpath и кеш комплешенов
# =======================================
fpath+=$HOME/.zsh/pure
fpath+=$HOME/.zsh
fpath=(~/.zsh/oc $fpath) # дополнительные директории с функциями

# Включение кеширования автодополнений:
ZSH_COMPDUMP="$HOME/.zcompdump"
autoload -Uz compinit
compinit -C -d "$ZSH_COMPDUMP" 2>/dev/null # с кешем и подавлением предупреждений

# Настройки автодополнения
zstyle ':completion:*' menu select                    # меню выбора при автодополнении (Tab Tab)
zstyle ':completion::complete:*' gain-privileges true # разрешить sudo автодополнение

# =======================================
#       Подключение Oh-My-Zsh
# =======================================
source $ZSH/oh-my-zsh.sh

# =======================================
#          ЯЗЫКОВАЯ НАСТРОЙКА
# =======================================
export LANG=en_US.UTF-8
# export LANG=ru_RU.UTF-8  # раскомментируйте при необходимости

# =======================================
#       ПЕРЕДНАСТРОЙКА ПРИ ЛОКАЛЬНЫХ/SSH СЕССИЯХ
# =======================================
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# SSH ключ по умолчанию
export SSH_KEY_PATH="~/.ssh/rsa_id"

# =======================================
#               АЛИАСЫ
# =======================================
alias ga="git add "
alias gai="git add -i "
alias gap="git add -p "
alias gb="git branch "
alias gba="git branch --all "
alias gbas="git branch --all --sort=-committerdate "
alias gc!="git commit --amend -v"
alias gc="git commit -v "
alias gca!="git commit -av --amend "
alias gca="git commit -av "
alias gcf="git commit --fixup=$1 "
alias gd="git diff "
alias gdc="git diff --cached "
alias gdh="git diff @ "
alias gds="git diff --staged "
alias gdsw="git diff --staged --word-diff "
alias gdt="git difftool "
alias gdw="git diff --word-diff "
alias gfa="git fetch --all "
alias gh="git hist "
alias gha="git hist --all "
alias gk="gitk --all& "
alias gm="git merge "
alias gmf="git merge --ff-only "
alias go-="git checkout -"
alias go="git checkout "
alias gp="git push "
alias gpf="git push --force-with-lease "
alias gpr="git pull --rebase --autostash "
alias gr="git reset "
alias grb="git rebase "
alias grh="git reset --hard "
alias gri="git rebase -i --autosquash "
alias grs="git reset --soft "
alias gs="git status "
alias gsb="git status -sb "
alias gtags="git tag --sort='v:refname' "
alias gx="gitx --all "

alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"
alias oni="oni2"

# =======================================
#            ПАТЧИ ДЛЯ PATH
# =======================================
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'
export PATH="/usr/local/opt/curl/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PATH="/usr/local/opt/curl/bin:$PATH"

# For compilers to find curl you may need to set:
export LDFLAGS="-L/usr/local/opt/curl/lib"
export CPPFLAGS="-I/usr/local/opt/curl/include"

# For pkg-config to find curl you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# =======================================
#      Ленивое подключение heavy completions
# =======================================
zsh-defer -c 'test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"'

zsh-defer source "${HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
zsh-defer source "${HOME}/.jfrog/jfrog_zsh_completion"
zsh-defer -c '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh'

# Отложенная генерация completion файлов
zsh-defer -c 'kubectl completion zsh >"${HOME}/.zsh/_kubectl_completions.zsh"'
zsh-defer -c 'volta completions zsh >"${HOME}/.zsh/_volta_completions.zsh"'
zsh-defer -c 'bw completion --shell zsh >"${HOME}/.zsh/_bitwarden_completions.zsh"'
zsh-defer -c 'glow completion zsh >"${HOME}/.zsh/_glow_completions.zsh"'

zsh-defer -c '[ -s "/Users/admakeye/.bun/_bun" ] && source "/Users/admakeye/.bun/_bun"'
zsh-defer -c '[ -s "/usr/local/Cellar/bun/0.3.0/share/zsh/site-functions/_bun" ] && source "/usr/local/Cellar/bun/0.3.0/share/zsh/site-functions/_bun"'

# =======================================
#          Поддержка bash-команд в zsh
# =======================================
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

# Загрузка zmv для удобного переименования файлов
autoload zmv

# =======================================
#          DEBUGGING REPORT (if enabled)
# =======================================
if [[ -n "$ZSH_DEBUGRC" ]]; then
    zprof # вывод профиля запуска
fi
