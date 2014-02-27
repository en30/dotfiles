# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew bundler gem git npm rails rake redis-cli vagrant zeus)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

BREW_PREFIX=`brew --prefix`
export _Z_CMD=j
. ${BREW_PREFIX}/etc/profile.d/z.sh

export EDITOR=${BREW_PREFIX}/bin/emacsclient
export PATH=${BREW_PREFIX}/bin:${PATH}
export PATH=${PATH}:~/pear/bin

alias e=${BREW_PREFIX}/bin/emacs
alias keytool='keytool -J-Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
alias jar='jar -J-Dfile.encoding=UTF-8'
alias plcat='plutil -convert xml1 -o -'

alias tm='tmux'
alias tma='tmux attach'
alias tms='tmux new-session -s'
alias tml='tmux list-sessions'

eval "$(rbenv init -)"
[[ -s ~/.tmuxinator ]] && source ~/.tmuxinator/tmuxinator.zsh
