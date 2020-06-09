# change directory color
set -x LSCOLORS gxfxcxdxbxegedabagacad

# Python
set -Ux PYENV_ROOT $HOME/.pyenv
set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

# Rust
set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths

# OCaml
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

# Others
set -x GPG_TTY (tty)