Installation

    git clone git@github.com:zjyExcelsior/dotfiles.git

Create required directories:

    mkdir -p ~/.config/yapf
    mkdir -p /var/tmp/.vimundo
    mkdir -p /var/tmp/.vimswp
    mkdir -p /var/tmp/.vimbak

Create symlinks:

    ln -s ~/dotfiles/zshrc ~/.zshrc
    ln -s ~/dotfiles/zshenv ~/.zshenv
    ln -s ~/dotfiles/vimrc ~/.vimrc
    ln -s ~/dotfiles/vim ~/.vim
    ln -s ~/dotfiles/style ~/.config/yapf/style
