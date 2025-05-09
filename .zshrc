# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
ulimit -n 10240

# Custom
if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
	alias vim8='/Applications/MacVim.app/Contents/MacOS/Vim'
	# alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
	alias vim='nvim'
fi
alias dc='docker-compose'
alias docker-nuke='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker system prune -a -f --volumes'
alias docker-rm='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias alma='docker run --rm -it --privileged -v /dev:/dev -v /Volumes:/Volumes -v /run:/run -v pacman-cache:/var/cache/pacman -v $(pwd):/work darwish/alma alma'
alias docker-preview='docker -H 52.178.221.208:2376 --tlsverify --tlscacert ~/certs/gryphon-preview/ca.pem --tlscert ~/certs/gryphon-preview/cert.pem --tlskey ~/certs/gryphon-preview/key.pem'
alias gclean='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias o="~/scripts/open-project.sh"
alias ol="ls ~/Development/work"
alias nu="nvm use"
alias nd="nvm use default"
alias v='NVIM_APPNAME="nvim-overtune" nvim'
export HOMEBREW_GITHUB_API_TOKEN=""
export DOCS_PATH=/Users/johrun/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Docs/

# if [ -f /etc/profile ]; then
#     PATH=""
#     source /etc/profile
# fi
#
#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# export PATH=/usr/local/opt/python/libexec/bin:$PATH
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  fzf
  docker-compose
  tmux
  asdf
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(thefuck --alias)
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# alias python=/opt/homebrew/bin/python3

# pnpm
export PNPM_HOME="/Users/johrun/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# see: https://superuser.com/a/1611283
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


