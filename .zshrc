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
setopt hist_ignore_all_dups

BREW_PREFIX=$(brew --prefix)

export EDITOR=${BREW_PREFIX}/bin/emacsclient
export PATH=${BREW_PREFIX}/bin:${PATH}
export PATH=${PATH}:~/pear/bin

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

export _Z_CMD=z
. ${BREW_PREFIX}/etc/profile.d/z.sh

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -s ~/.tmuxinator ]] && source ~/.tmuxinator/tmuxinator.zsh

source $(brew --prefix nvm)/nvm.sh
export NVM_DIR=~/.nvm

alias keytool='keytool -J-Dfile.encoding=UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'
alias jar='jar -J-Dfile.encoding=UTF-8'
alias plcat='plutil -convert xml1 -o -'

function copy-line-as-kill() {
    zle kill-line
    print -rn $CUTBUFFER | pbcopy
}
zle -N copy-line-as-kill
bindkey '^k' copy-line-as-kill

function paste-as-yank() {
    CUTBUFFER=$(pbpaste)
    zle yank
}
zle -N paste-as-yank
bindkey "^y" paste-as-yank

function peco-recent-directory(){
    local selected_dir=$(z | tail -r | awk '{print $2}' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-recent-directory
bindkey '^]^f' peco-recent-directory

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]^r' peco-src

function peco-tmuxinator() {
    local project_name=$(ls ~/.tmuxinator | sed -e s/.yml// -e /tmuxinator.zsh/d | peco)
    if [ -n "$project_name" ]; then
	mux $project_name
    fi
    zle clear-screen
}
zle -N peco-tmuxinator
bindkey '^]^t' peco-tmuxinator

function peco-multi-ssh() {
    local hosts="$(grep -iE '^host[[:space:]]+[^*]' ~/.ssh/config | awk '{print $2}' | peco)"
    if [ -n "$hosts" ]; then
	multi_ssh ${=hosts}
    fi
    zle clear-screen
}
zle -N peco-multi-ssh
bindkey '^]^h' peco-multi-ssh
