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

# Claude Code (native install, auto-updates enabled)
echo "Installing Claude Code..."
if ! command -v claude &> /dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash || {
        echo "Warning: Failed to install Claude Code"
    }
else
    echo "Claude Code already installed"
fi

# OpenCode
echo "Installing OpenCode..."
if ! command -v opencode &> /dev/null; then
    curl -fsSL https://opencode.ai/install | bash || {
        echo "Warning: Failed to install OpenCode"
    }
else
    echo "OpenCode already installed"
fi

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
fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher' || {
    echo "Warning: Failed to install fisher"
}

# Node.js
echo "Installing Node.js via nvm..."
fish -c 'fisher install jorgebucaran/nvm.fish' || {
    echo "Warning: Failed to install nvm.fish"
}
# nvm install は入れたバージョンを有効化するので、それをそのまま default として永続化する
fish -c 'nvm install latest; and set --universal nvm_default_version $nvm_current_version' || {
    echo "Warning: Failed to install latest Node.js"
}

# Yarn
echo "Installing Yarn..."
# この時点ではまだ symlink.sh 前で config.fish が無いため、nvm を明示的に有効化する
fish -c 'nvm use --silent $nvm_default_version; and npm install -g yarn' || {
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
mkdir -p ~/.config/fish ~/.config/nvim ~/.claude ~/.config/ghostty
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
fish -c 'node -v' 2>/dev/null || echo "node: not installed"
fish -c 'npm -v' 2>/dev/null || echo "npm: not installed"
fish -c 'yarn --version' 2>/dev/null || echo "yarn: not installed"
python --version 2>/dev/null || echo "python: not installed"
rustc --version 2>/dev/null || echo "rustc: not installed"

echo "Setup completed successfully!"