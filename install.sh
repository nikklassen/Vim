#!/bin/sh

FORCE=''
if [[ $1 == '-f' ]]; then
    FORCE=-f
fi

symlink() {
    ln -s $FORCE $@
}
export symlink

git submodule update --recursive --init

# Setup oh-my-zsh
OMZ_MODULE=.git/modules/zsh/oh-my-zsh-sparse
symlink $PWD/.omz.sparse-checkout $OMZ_MODULE/info/sparse-checkout
git config -f $OMZ_MODULE/config core.sparsecheckout true

# Clean up each subdirectory's working tree to only use the sparse checkout
git submodule foreach 'git read-tree -m -u HEAD'

git clone https://github.com/rupa/z.git /usr/local/opt/z

link_home() {
    if [[ ! -L $HOME/.$1 || -n $FORCE ]]; then
        symlink $PWD/$1 $HOME/.$1
    fi
}

link_home zshrc
link_home zshenv
link_home zsh
link_home vim
link_home tmux.conf

if [[ $(uname) == 'Darwin' ]]; then
    link_home osx
    source install_osx.sh
fi

curl https://raw.githubusercontent.com/whiteinge/dotfiles/master/bin/diffconflicts > /usr/local/bin/diffconflicts
git config --global merge.tool diffconflicts
git config --global mergetool.diffconflicts.cmd 'diffconflicts "vim -u NONE" $BASE $LOCAL $REMOTE $MERGED'
git config --global mergetool.diffconflictstrustExitCode true
git config --global mergetool.keepBackup false

# If this is a login shell source the changes immediately
if [[ $- == *i* ]]; then
    source ~/.zshrc
fi
