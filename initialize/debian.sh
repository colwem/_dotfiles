cd ~
sudo apt install stow neovim zsh zsh-antigen

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# curl -L git.io/antigen > antigen.zsh

cd ~/_dotfiles
stow vim
stow zsh
stow tmux

