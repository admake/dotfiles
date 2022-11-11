# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/admakeye/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# SPACESHIP PROMPT

SPACESHIP_GIT_STATUS_SHOW="true"
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_GIT_STATUS_UNTRACKED="?"
SPACESHIP_GIT_STATUS_MODIFIED="*"
SPACESHIP_GIT_STATUS_UNMERGED="!"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  oc
  git
  colored-man-pages
  npm
  httpie
  docker
  docker-compose
  jq-zsh-plugin
)

# Uncomment this line to enable ohmyzsh
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
# export LANG=ru_RU.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias gs="git status "
alias gsb="git status -sb "
alias go="git checkout "
alias go-="git checkout -"
alias ga="git add "
alias gap="git add -p "
alias gai="git add -i "
alias gc="git commit -v "
alias gc!="git commit --amend -v"
alias gca="git commit -av "
alias gca!="git commit -av --amend "
alias gcf="git commit --fixup=$1 "
alias gh="git hist "
alias gha="git hist --all "
alias gd="git diff "
alias gdw="git diff --word-diff "
alias gds="git diff --staged "
alias gdc="git diff --cached "
alias gdsw="git diff --staged --word-diff "
alias gdh="git diff @ "
alias gdt="git difftool "
alias gtags="git tag --sort='v:refname' "
alias gb="git branch "
alias gba="git branch --all "
alias gbas="git branch --all --sort=-committerdate "
alias gm="git merge "
alias gmf="git merge --ff-only "
alias gfa="git fetch --all "
alias grb="git rebase "
alias gri="git rebase -i --autosquash "
alias gp="git push "
alias gpf="git push --force-with-lease "
alias gpmr="git push -o merge_request.create -o merge_request.target=$1"
alias gpmr_="git push -o merge_request.create -o merge_request.target=$1 -o merge_request.merge_when_pipeline_succeeds"
alias gpmr!="git push -o merge_request.create -o merge_request.target=$1 -o merge_request.merge_when_pipeline_succeeds -o merge_request.remove_source_branch"
alias gpr="git pull --rebase --autostash "
alias gpp="git pull --rebase --autostash $1 $2 && git push $1 $2 --tags"
alias gr="git reset "
alias grs="git reset --soft "
alias grh="git reset --hard "
alias gk="gitk --all& "
alias gx="gitx --all "

alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"
alias oni="oni2"

# add pure theme to path
fpath+=$HOME/.zsh/pure

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
# prompt pure
prompt spaceship

export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'
export PATH="/usr/local/opt/curl/bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source "${HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "${HOME}/.jfrog/jfrog_zsh_completion"
# eval "$(kubectl completion zsh); compdef _kubectl kubectl;"
# eval "$(volta completions zsh); compdef _volta volta;"
# eval "$(bw completion --shell zsh); compdef _bw bw;"
# kubectl completion zsh > "${HOME}/.zsh/.kubectl_completions.zsh"
# volta completions zsh > "${HOME}/.zsh/.volta_completions.zsh"
# bw completion --shell zsh > "${HOME}/.zsh/.bitwarden_completions.zsh"
fpath+=$HOME/.zsh

autoload -Uz compinit
compinit

typeset -U fpath  # Optinal for oh-my-zsh users
fpath=(~/.zsh/oc $fpath)
autoload -U compinit
compinit -i

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
