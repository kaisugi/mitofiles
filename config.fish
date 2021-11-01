# change directory color
set -x LSCOLORS gxfxcxdxbxegedabagacad

# Node.js
set -x PATH (npm bin -g) $PATH

# Python
set -x PYENV_ROOT $HOME/.pyenv
set -x fish_user_paths $PYENV_ROOT/bin $fish_user_paths
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

# Rust
set -x PATH $HOME/.cargo/bin $PATH

# use rlwrap
alias ocaml='rlwrap ocaml'

# VSCode
alias code="open -a Visual\ Studio\ Code.app"

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
