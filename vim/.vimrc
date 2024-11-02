" Vim mode instead Vi compatible mode (must be first because of side effects)
set nocompatible

set encoding=utf-8

" Filetype based config
filetype plugin indent on
syntax on

" Indentation
set autoindent
set smartindent

" Tabstops
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Relative and absolute line numbers combined
set number
set relativenumber

" More context around the cursor when it moves outside window viewport
set scrolloff=5

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Text wrapping
set wrap
set breakindent

" Window splitting
set splitright
set splitbelow

" Allow unsaved work in hidden buffers
set hidden

