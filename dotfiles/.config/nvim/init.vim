" Personal Nvim config
" vim: fdm=indent

filetype off                    "Disable autodetection while plugins are setup
set nocompatible                "Disable compatabilty with ancient vi

" Begin plugin setup
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'

" End plugin setup
call plug#end()

" General configuration
filetype plugin indent on       "Load plugin files for file types and load indent.vim
set fileformat=unix             "Unix file endings
set encoding=utf-8              "Use utf-8 encoding
set undolevels=1000             "Undo up to 1000 times
set backspace=indent,eol,start  "Backspace can go back over anything
set mouse=a                     "Enable mouse support
set scroll=10                   "Set C-u/c-d scroll distance
set modeline                    "Allow files to set vim settings
set nowrap                      "Don't wrap lines
set viminfo=                    "Don't save viminfo
let mapleader = ","             "Set prefix key for mapping key sequences

set wildignore=*.o,*.pyc,*.so,*.swp,*.zip "Ignore these extensions when expanding paths

" No pesky .swp files
set nobackup
set noswapfile

" Highlighting
syntax enable                         "Syntax highlighting
set showmatch                         "Highlight matching parenthesise
set hlsearch                          "Highlight search results
set cursorline                        "Highlight the line the cursor is on
set list                              "Show whitespace
set listchars=tab:→\                  "Show tabs as arrows, don't show eol
set colorcolumn=80                    "Highlight the 80th column

" Statusbar and line numbering
set laststatus=2                      "Statusbar should be double height
set showmode                          "Show current mode in status line
set showcmd                           "Show partial command in status line
set ruler                             "Show cursor position in status line
set nu                                "Enable line numbering...
set rnu                               " ...but make it relative

" Indentation
set autoindent                        "Autoindent by default
set copyindent                        "Indent to same level as previous line by default
set expandtab                         "Tabs are spaces
set tabstop=2                         "Tab size
set softtabstop=2                     "How much to indent by when you hit tab.
set shiftwidth=2                      "Shift indentation amount (>> and <<)
set shiftround                        "Use multiples of shiftwidth when using </> to indent

" File-type specific settings
autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
autocmd bufread *.md set ft=markdown


