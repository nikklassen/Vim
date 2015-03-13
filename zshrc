# Path to your oh-my-zsh installation.
export ZSH=/Users/Nik/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dpoggi"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump brew cabal osx sudo)

# User configuration

export PATH="/Users/Nik/.rbenv/shims:/usr/local/bin:/usr/local/sbin:/Users/Nik/.rbenv/versions/2.0.0-p195/bin/gem:/Users/Nik/.rbenv/bin:.:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/usr/texbin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Users/Nik/node_modules/.bin:./node_modules/.bin:/Users/Nik/Library/Haskell/bin:/Users/Nik/.cabal/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
autoload -U add-zsh-hook 

eval "$(rbenv init -)"

alias ls="ls -FG"
alias lls="ls -lah"
alias xgit="xcrun git"
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
alias rsync="rsync -h --progress"
mkcd () {
    mkdir -p "$*"
    cd "$*"
}

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
setopt AUTO_CD

setopt correct
setopt correctall
alias sudo="nocorrect sudo"

setopt globdots
setopt extendedglob
setopt automenu
setopt autoparamslash
setopt completealiases

autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "\e[A" up-line-or-beginning-search
bindkey "\e[B" down-line-or-beginning-search
bindkey "\e[1~" beginning-of-line # ⌘ <-
bindkey "\e[4~" end-of-line # ⌘ ->
bindkey "\e[3~" delete-char # fn delete

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

auto-ls-after-cd() {
    emulate -L zsh
    ls
}
add-zsh-hook chpwd auto-ls-after-cd

proxy_toggle() {
    proxy_info="$(sudo networksetup -getsocksfirewallproxy Wi-Fi)"

    if [[ $proxy_info =~ "Enabled: No" ]]; then
        echo "Turning on"
        sudo networksetup -setsocksfirewallproxystate Wi-Fi on
    else
        echo "Turning off"
        sudo networksetup -setsocksfirewallproxystate Wi-Fi off
    fi
}

firewall_toggle() {

    firewall_state="$(sudo defaults read /Library/Preferences/com.apple.alf globalstate)"

    new_state=1
    if [[ $firewall_state == 0 ]]; then
        echo "Turning on"
    else
        echo "Turning off"
        new_state=0
    fi

    sudo defaults write /Library/Preferences/com.apple.alf globalstate -int $new_state

    sudo launchctl unload /System/Library/LaunchDaemons/com.apple.alf.agent.plist
    sudo launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist
}
