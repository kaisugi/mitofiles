# change directory color
set -x LSCOLORS gxfxcxdxbxegedabagacad

# Node.js
set -x PATH (npm bin -g) $PATH

# Python
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

# Rust
set -x PATH $HOME/.cargo/bin $PATH

# use rlwrap
alias ocaml='rlwrap ocaml'
alias python='rlwrap python'

# VSCode
alias code="open -a Visual\ Studio\ Code.app"

# Vim
alias vim='nvim'

# various aliases
alias l='ls -al'
alias tarzip='tar czvf'
alias tarunzip='tar xzvf'
alias tarls='tar tzvf'

# Others
set -x GPG_TTY (tty)
function want
  curl -sd $argv https://want.now.sh | bash -s --
end
