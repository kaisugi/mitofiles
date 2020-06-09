# change directory color
set -x LSCOLORS gxfxcxdxbxegedabagacad

# Python
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

# OCaml
alias ocaml='rlwrap ocaml'

# various aliases
alias l='ls -al'
alias tarzip='tar czvf'
alias tarunzip='tar xzvf'
alias tarls='tar tzvf'

# Others
set -x GPG_TTY (tty)