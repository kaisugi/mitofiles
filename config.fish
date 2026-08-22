# change directory color
set -x LSCOLORS gxfxcxdxbxegedabagacad

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

# Node.js
# conf.d/nvm.fish は対話シェルでしか default を有効化しないので、ここで補う
set -q nvm_default_version; or set -g nvm_default_version v24.18.0
set -q nvm_current_version; or nvm use --silent $nvm_default_version

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

set -x PATH /opt/homebrew/bin $PATH
set -x PATH $HOME/.local/bin $PATH
alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"
eval (/opt/homebrew/bin/brew shellenv)
# gcloud は未指定だと PATH 上の python3（= pyenv の shim）を使うので、
# pyenv 側の Python が壊れると巻き込まれる。system python に固定しておく
set -x CLOUDSDK_PYTHON /usr/bin/python3
set -x CLOUDSDK_PYTHON_SITEPACKAGES 1

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "$HOME/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# opencode
fish_add_path /Users/kaisugi/.opencode/bin
