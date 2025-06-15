# mitofiles

![](https://images.microcms-assets.io/assets/5694fd90407444338a64d654e407cc0e/bd287ec9cfb8453da4a32161e4e76ce1/liver-face_Mito_Tsukino.png.webp?w=1200&h=630&fit=fill&fill=solid)

## Prerequisites

- macOS (Apple Silicon or Intel)
- Command Line Tools for Xcode
- Internet connection

## Quick Setup

```bash
cd ~
git clone https://github.com/kaisugi/mitofiles.git dotfiles
cd dotfiles
bash init.sh
bash mas.sh
```

After installation, restart your terminal or run:
```bash
exec fish
```

## What's Included

### Package Management
- **Homebrew** - Package manager for macOS
- **mas** - Mac App Store command line interface

### Development Tools
- **Git** with custom configuration
- **Neovim** with basic configuration
- **tmux** with custom prefix
- **Fish shell** with oh-my-fish and fisher
- **Node.js** via nvm.fish
- **Python** via pyenv (3.12.0)
- **Rust** via rustup
- **Go** development environment

### Applications
- Developer tools: GitHub Desktop, Postman, Visual Studio Code
- Browsers: Firefox, Chrome, Microsoft Edge
- Utilities: iTerm2, DeepL, Notion, Slack, Zoom
- Authentication: Authy
- Others: Spotify, Inkscape, The Unarchiver

## Manual Steps

Some configurations may require manual setup:
1. **Git**: Update user email in `git/.gitconfig`
2. **GPG**: Import your GPG keys if needed
3. **Fish shell**: May require manual shell change if script fails
4. **App Store**: Sign in to download apps via mas

## Troubleshooting

- If Homebrew installation fails, install Command Line Tools manually: `xcode-select --install`
- If shell change fails, run manually: `chsh -s /opt/homebrew/bin/fish`
- For permission issues, ensure the user has admin privileges
