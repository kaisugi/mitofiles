# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
sh brew.sh

# set symlink
sh symlink.sh

# set fish shell
echo "/usr/local/bin/fish" >> /etc/shells
chsh -s /usr/local/bin/fish
curl -L https://get.oh-my.fish | fish

# Node.js
nvm install node
nvm use node

# Yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

# Python
pyenv install 3.8.0
pyenv global 3.8.0
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
pip install jupyter numpy scipy matplotlib

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Others
echo "pinentry-program /usr/local/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
