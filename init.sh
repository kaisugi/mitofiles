# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
brew upgrade
brew bundle

# set fish shell
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s `which fish`
curl -L https://get.oh-my.fish | fish
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Node.js
fisher add jorgebucaran/nvm.fish
nvm use latest

# Yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

# Python
pyenv install 3.8.0
pyenv global 3.8.0
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Others
echo "pinentry-program /usr/local/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent


# set symlink
touch ~/.config/fish/config.fish
touch ~/.config/nvim/init.vim
sh symlink.sh

# check language versions
echo "-----check language versions-----"
gcc --version
g++ --version
go version
ocaml --version

node -v
npm -v
yarn versions
python --version
rustc --version