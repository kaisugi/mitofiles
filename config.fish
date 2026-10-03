# change directory color
set -x LSCOLORS gxfxcxdxbxegedabagacad

# PATH は後に追加したものほど優先される。--move で既存の位置からも先頭に寄せるので、
# 親シェルから PATH を引き継いでも順序が崩れず、重複もしない

# Homebrew
/opt/homebrew/bin/brew shellenv fish | source

# Google Cloud CLI (cask)
# gcloud / bq / gsutil は brew がリンクするが、gke-gcloud-auth-plugin など
# gcloud components で追加したコマンドはここにしか置かれない
fish_add_path --global --move --path /opt/homebrew/share/google-cloud-sdk/bin

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "$HOME/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Rust
fish_add_path --global --move --path $HOME/.cargo/bin

# Go
set -x GOPATH $HOME/go
fish_add_path --global --move --path $GOPATH/bin

# opencode
fish_add_path --global --move --path $HOME/.opencode/bin

# uv (Python, uv tool), Claude Code, Codex CLI
fish_add_path --global --move --path $HOME/.local/bin

# Node.js
# conf.d/nvm.fish は対話シェルでしか default を有効化しないので、ここで補う
set -q nvm_default_version; or set -g nvm_default_version lts
set -q nvm_current_version; or nvm use --silent $nvm_default_version

# Vim
alias vim='nvim'

# various aliases
alias l='ls -al'
alias tarzip='tar czvf'
alias tarunzip='tar xzvf'
alias tarls='tar tzvf'
alias diff='colordiff'
