" encoding=utf-8, incsearch, hlsearch, backspace=indent,eol,start は
" Neovim のデフォルトなので書いていない

" インデント関連
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" 行数表示
set number

" 検索
set ignorecase
set smartcase

" カーソルハイライト
set whichwrap=b,s,h,l,<,>,[,],~
set cursorline

" かっこ表示
set showmatch
" matchit is built in to Neovim and enabled by default; no need to source it
