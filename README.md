# Vim Improove

Add to your .bash_profile or .bashrc following lines

    vim-init ()
    {
        [ -d ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim;
        [ -d ~/.vim/bundle/vim-colors-solarized ] || git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized;
        vim +PluginInstall +qall
    }

Then run `$ vim-init` to install plugins.

Also you should copy file .vimrc to your home directory

    $ cp .vimrc ~/.vimrc
