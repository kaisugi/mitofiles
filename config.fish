# change directory color
set -x LSCOLORS gxfxcxdxbxegedabagacad

# Node.js (nvm will handle PATH automatically)

# Python
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

# Rust
set -x PATH $HOME/.cargo/bin $PATH

# Go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH


# Vim
alias vim='nvim'

# various aliases
alias l='ls -al'
alias tarzip='tar czvf'
alias tarunzip='tar xzvf'
alias tarls='tar tzvf'
alias diff='colordiff'

# Others
set -x GPG_TTY (tty)
function want
  curl -sd $argv https://want.now.sh | bash -s --
end
function rewifi
  networksetup -setairportpower en0 off
  networksetup -setairportpower en0 on
end

alias hex2dec="printf '%d\n'"
alias dec2hex="printf '%x\n'"

set -x PATH /opt/homebrew/bin $PATH
set -x PATH $HOME/.local/bin $PATH
alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"
eval (/opt/homebrew/bin/brew shellenv)
set -x CLOUDSDK_PYTHON_SITEPACKAGES 1

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "$HOME/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
