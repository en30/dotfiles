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

DISABLE_UPDATE_PROMPT="true"

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
plugins=(brew bundler gem git npm rails rake redis-cli vagrant)

source $ZSH/oh-my-zsh.sh

setopt histignorespace
unsetopt complete_aliases
alias __tig_main=_tig

# Customize to your needs...
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

BREW_PREFIX=$(brew --prefix)

export EDITOR=${BREW_PREFIX}/bin/emacsclient
export PATH=${BREW_PREFIX}/sbin:${BREW_PREFIX}/bin:${PATH}
export PATH=${PATH}:~/pear/bin

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export LESS='-i -M -R -S -W -x2'
# export RUBYGEMS_GEMDEPS=-

export _Z_CMD=z
. ${BREW_PREFIX}/etc/profile.d/z.sh

[[ -s ~/.tmuxinator ]] && source ~/.tmuxinator/tmuxinator.zsh

source $(brew --prefix nvm)/nvm.sh
export NVM_DIR=~/.nvm

fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

export NIPPO_DIRECTORY="$HOME/Documents/nippo"
mkdir -p $NIPPO_DIRECTORY

autoload -U compinit
compinit -U

eval "$(hub alias -s)"
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

function peco-chrome-tabs () {
    local tab_id="$(chrome-cli list tabs | peco --initial-matcher Migemo | sed -e s/.*:// -e s/].*//)"
    if [ -n "$tab_id" ]; then
        chrome-cli activate -t $tab_id
    fi
}

function peco-descbinds () {
    zle $(bindkey | peco | cut -d " " -f 2)
}
zle -N peco-descbinds

function peco-M-x () {
    $(print -l ${(ok)functions} | sed -e /^_/d | peco)
}
zle -N peco-M-x
bindkey '\ex' peco-M-x

function peco-books () {
    local book="$(find ~/Dropbox/books -type f | sed -e /.DS_Store/d | peco)"
    if [ -n "$book" ]; then
        open $book
    fi
}
zle -N peco-books

alias -g B='$(git branch | peco | sed -e "s/^\*[ ]*//g")'

function peco-pkill() {
    for pid in $(ps aux | peco | awk '{ print $2 }')
    do
        kill $pid
        echo "Killed ${pid}"
    done
}
zle -N peco-pkill

function peco-gitignore() {
    local boilerplates="$(gibo -l | tr '\t' '\n' | sed -e '/^$/d' -e '/=/d' | sort | peco)"
    if [ -n "$boilerplates" ]; then
        gibo ${=boilerplates}
    fi
}
zle -N peco-gitignore

function ghq() {
    if [ "$1" = "new" ]; then
        shift
        ghq-new "$@"
    else
        command ghq "$@"
    fi
}

function ghq-new() {
    local repo
    local -a split_repo
    split_repo=("${(@s|/|)1}")
    if [ -n "$split_repo[2]" ]; then
        repo="$1"
    else
        repo="$(git config user.name)/$split_repo[1]"
    fi
    mkdir -p "$(git config ghq.root)/github.com/$repo"
    cd $_
    git init
    peco-gitignore > .gitignore
    touch README.md
    git add .
}

function peco-agsed() {
    ag $1 | sed "s|$1|($1 => $2)|g" | peco | awk -F: '{print $2; print $1}' | parallel -N 2 sed -i "''" '"'{1} "s|$1|$2|g"'"' {2}
}

# added by travis gem
[ -f /Users/en30/.travis/travis.sh ] && source /Users/en30/.travis/travis.sh

export PATH="$HOME/.yarn/bin:$PATH"

function aws_account_info {
  [ "$AWS_ACCOUNT_NAME" ] && [ "$AWS_ACCOUNT_ROLE" ] && echo "%F{blue}aws:(%f%F{red}$AWS_ACCOUNT_NAME:$AWS_ACCOUNT_ROLE%f%F{blue})%F$reset_color"
}

# )ofni_tnuocca_swa($ is $(aws_account_info) backwards
PROMPT=`echo $PROMPT | rev | sed 's/ / )ofni_tnuocca_swa($ /'| rev`

function gcloud_account_info() {
    local account=$(cat ~/.config/gcloud/configurations/config_$(cat ~/.config/gcloud/active_config) | grep 'account = ' | awk -F' = ' '{print $2}')
    local project=$(cat ~/.config/gcloud/configurations/config_$(cat ~/.config/gcloud/active_config) | grep 'project = ' | awk -F' = ' '{print $2}')
    echo " %b%F{yellow}%K{blue} ⬣ ${project} %b%f%k"
}
PROMPT=$(echo $PROMPT | sed -e 's/%E/$(gcloud_account_info)%E/')

# The next line updates PATH for the Google Cloud SDK.
if [ -f "~/google-cloud-sdk/path.zsh.inc" ]; then . "~/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "~/google-cloud-sdk/completion.zsh.inc" ]; then . "~/google-cloud-sdk/completion.zsh.inc"; fi
