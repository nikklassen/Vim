autoload -U promptinit compinit
compinit -u

promptinit
prompt suse

EDITOR=/opt/local/bin/vim

# Setting PATH for Python 2.7
PATH="${PATH}:/Library/Frameworks/Python.framework/Versions/2.7/bin"

# Setup rbenv
PATH="$HOME/.rbenv/bin:$PATH"

# Gems path
PATH="$HOME/.rbenv/versions/2.0.0-p195/bin/gem:$PATH"

# Node modules
PATH="$PATH:$HOME/node_modules/.bin"

eval "$(rbenv init -)"

# MacPorts Installer addition on 2012-11-19_at_19:38:15: adding an appropriate PATH variable for use with MacPorts.
PATH="/opt/local/bin:/opt/local/sbin:$PATH"

PATH="$PATH:$HOME/Library/Haskell/bin:$HOME/.cabal/bin"

alias ls="ls -FG"
alias xgit="xcrun git"
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

# Git
alias gst="git status"
alias gdiff="git diff --cached"

export CLASSPATH="$HOME/Programming/Java/classes/"

HISTFILE=$HOME/.zhistory
HISTSIZE=SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

setopt correct
setopt correctall
alias sudo="nocorrect sudo"

setopt globdots
setopt automenu
setopt autoparamslash
setopt completealiases

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "\e[A" up-line-or-beginning-search
bindkey "\e[B" down-line-or-beginning-search

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

trash () {
    if [ -f $1 ]
    then
        mv $1 ~/.Trash
    else
        mv -r $1 ~/.Trash
    fi
}

function auto-ls-after-cd() {
    emulate -L zsh
    ls
}
add-zsh-hook chpwd auto-ls-after-cd

function proxy_toggle() {
    proxy_info="$(sudo networksetup -getsocksfirewallproxy Wi-Fi)"

    if [[ $proxy_info =~ "Enabled: No" ]]; then
        echo "Turning on"
        sudo networksetup -setsocksfirewallproxystate Wi-Fi on
    else
        echo "Turning off"
        sudo networksetup -setsocksfirewallproxystate Wi-Fi off
    fi
}
