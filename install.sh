sudo apt update
sudo apt upgrade

# add neovim repo
sudo add-apt-repository ppa:neovim-ppa/unstable

# add ripgrep repo
sudo add-apt-repository ppa:x4121/ripgrep

# apt installs packages
sudo apt install neovim \
                 fzf \
                 bat \
                 tmux \
                 stow \
                 ripgrep \
                 clangd-12
# install node and nvm
# install npm
# update node to latest version
# get dot files from github
# stow the dot files
# install pyrighht using npm
# install nerd fonts

mkdir -p $HOME/nerd-fonts
git clone https://github.com/ryanoasis/nerd-fonts $HOME/nerd-fonts
cd $HOME/nerd-fonts
sudo ./install.sh

# pip installs
python3 -m pip install --upgrade pip

sudo apt autoremove
