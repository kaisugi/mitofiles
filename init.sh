#!/bin/bash
set -e

echo "Starting dotfiles setup..."

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This script is designed for macOS only."
    exit 1
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo "Error: This script should not be run as root"
   exit 1
fi

# Check for required commands
for cmd in curl git; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd is required but not installed."
        exit 1
    fi
done

# homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
        echo "Error: Failed to install Homebrew"
        exit 1
    }
else
    echo "Homebrew already installed"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
brew upgrade
brew bundle --file="${HOME}/dotfiles/Brewfile" || {
    echo "Error: Failed to install packages from Brewfile"
    exit 1
}

# set fish shell
FISH_PATH="/opt/homebrew/bin/fish"
if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "Adding fish to /etc/shells..."
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != "$FISH_PATH" ]]; then
    echo "Changing default shell to fish..."
    chsh -s "$FISH_PATH" || {
        echo "Warning: Failed to change shell. You may need to do this manually."
    }
fi

echo "Installing oh-my-fish..."
curl -L https://get.oh-my.fish | fish || {
    echo "Warning: Failed to install oh-my-fish"
}

echo "Installing fisher..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher || {
    echo "Warning: Failed to install fisher"
}

# Node.js
echo "Installing Node.js via nvm..."
fisher install jorgebucaran/nvm.fish || {
    echo "Warning: Failed to install nvm.fish"
}
nvm install latest || {
    echo "Warning: Failed to install latest Node.js"
}
nvm use latest || {
    echo "Warning: Failed to use latest Node.js"
}

# Yarn
echo "Installing Yarn..."
npm install -g yarn || {
    echo "Warning: Failed to install Yarn"
}

# Python
echo "Installing Python 3.12.0..."
if ! pyenv versions | grep -q "3.12.0"; then
    pyenv install 3.12.0 || {
        echo "Warning: Failed to install Python 3.12.0"
    }
fi
pyenv global 3.12.0 || {
    echo "Warning: Failed to set Python 3.12.0 as global"
}

echo "uv is installed via Homebrew (see Brewfile)"

# Rust
echo "Installing Rust..."
if ! command -v rustc &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || {
        echo "Warning: Failed to install Rust"
    }
fi

# GPG configuration
echo "Configuring GPG..."
mkdir -p ~/.gnupg
echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent || {
    echo "Warning: Failed to restart gpg-agent"
}

# Git configuration
echo "Git configuration already set in .gitconfig"

# set symlink
echo "Creating symbolic links..."
mkdir -p ~/.config/fish ~/.config/nvim ~/.config/claude
bash "${HOME}/dotfiles/symlink.sh" || {
    echo "Error: Failed to create symbolic links"
    exit 1
}

# check language versions
echo "-----Checking language versions-----"
echo "Compiler versions:"
gcc --version 2>/dev/null || echo "gcc: not installed"
g++ --version 2>/dev/null || echo "g++: not installed"
go version 2>/dev/null || echo "go: not installed"

echo "Runtime versions:"
node -v 2>/dev/null || echo "node: not installed"
npm -v 2>/dev/null || echo "npm: not installed"
yarn --version 2>/dev/null || echo "yarn: not installed"
python --version 2>/dev/null || echo "python: not installed"
rustc --version 2>/dev/null || echo "rustc: not installed"

echo "Setup completed successfully!"