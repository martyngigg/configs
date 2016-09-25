" My vimrc settings
" vim: fdm=indent

"==============="
"Native settings"
"==============="

if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
else
   let s:editor_root=expand("~/.vim")
    set nocompatible        "Don't bother with silly vi compatibility
    set clipboard=unnamed   "Enable yank to clipboard
endif

if has('unnamedplus') || has('nvim')
  set clipboard+=unnamedplus
else
  set clipboard+=unnamed
endif

set fileformat=unix             "Unix file endings
set encoding=utf-8              "Use utf-8 encoding
set undolevels=1000             "Undo up to 1000 times
set backspace=indent,eol,start  "Backspace can go back over anything
set mouse=a                     "Enable mouse support
set scroll=10                   "Set C-u/c-d scroll distance
set modeline                    "Allow files to set vim settings
set nowrap                      "Don't wrap lines
set viminfo=                    "Don't save viminfo
let mapleader = ","             "Set leader to ','

set wildignore=*.o,*.pyc,*.so,*.swp,*.zip "Ignore these extensions when expanding paths

"No pesky .swp files
set nobackup
set noswapfile

"Set up console colours
set t_Co=256

"Highlighting
syntax enable                         "Syntax highlighting
set showmatch                         "Highlight matching parenthesise
set hlsearch                          "Highlight search results
set cursorline                        "Highlight the line the cursor is on
set list                              "Show whitespace
set listchars=tab:→\                  "Show tabs as arrows, don't show eol
set colorcolumn=80                    "Highlight the 80th column

"Statusbar and line numbering
set laststatus=2                      "Statusbar should be double height
set showmode                          "Show current mode in status line
set showcmd                           "Show partial command in status line
set ruler                             "Show cursor position in status line
set nu                                "Enable line numbering...
set rnu                               " ...but make it relative

"Indentation
set expandtab                         "Tabs are spaces
set tabstop=2                         "Tab size
set softtabstop=2                     "How much to indent by when you hit tab.
set shiftwidth=2                      "Shift indentation amount (>> and <<)
set autoindent                        "Autoindent by default
set copyindent                        "Indent to same level as previous line by default
set shiftround                        "Use multiples of shiftwidth when using </> to indent

"=========================="
"Filetype specific settings
"=========================="
autocmd FileType make setlocal noexpandtab
autocmd Filetype go setlocal noexpandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype html setlocal ts=4 sts=4 sw=4 omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal ts=4 sts=4 sw=4
autocmd FileType python setlocal ts=4 sts=4 sw=4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
autocmd FileType css setlocal ts=4 noet sw=4 omnifunc=csscomplete#CompleteCSS
autocmd bufread *.coffee set ft=coffee
autocmd bufread *.less set ft=less
autocmd bufread *.md set ft=markdown
autocmd bufread Cakefile set ft=coffee
autocmd bufread *.pp set ft=ruby
autocmd bufread *.conf set ft=dosini
au BufRead,BufNewFile *.md setlocal filetype=markdown.pandoc spell spelllang=en_gb
au BufRead,BufNewFile *.txt setlocal spell spelllang=en_gb
au BufRead,BufNewFile *.tex setlocal spell spelllang=en_gb
au BufRead,BufNewFile *.fountain setlocal filetype=fountain linebreak spell spelllang=en_gb

"================="
"Install Plugins.
"================="
" Setting up Vundle - the vim plugin bundler
filetype off                            "Disable autodetection while installing plugins
let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/vundle/README.md'
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent call mkdir(s:editor_root . '/bundle', "p")
    silent execute "!git clone https://github.com/gmarik/vundle " . s:editor_root . "/bundle/vundle"
    let vundle_installed=0
endif
let &rtp = &rtp . ',' . s:editor_root . '/bundle/vundle/'
call vundle#rc(s:editor_root . '/bundle')

"Plugins
Plugin 'gmarik/vundle.vim'                "Required
Plugin 'altercation/vim-colors-solarized'
Plugin 'szw/vim-ctrlspace'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-eunuch'
Plugin 'airblade/vim-gitgutter'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'tpope/vim-markdown'
Plugin 'rhysd/vim-clang-format'

if vundle_installed == 0
    echo "Installing plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
" Setting up Vundle - the vim plugin bundler end

filetype plugin indent on                "Renable file-type detection

"================="
"Plugins Settings
"================="
"Solarized theme
set background=dark
colorscheme solarized
highlight SignColumn ctermbg=8

"Syntastic options
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map = {'mode' : 'passive'}
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_cpp_checkers = ['gcc', 'clang']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_args = ['--rcfile=~/.pylintrc']
nmap <silent> <leader>l :SyntasticCheck<CR>

"Ultisnip options
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

"Airline options
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_detect_spell = 0
let g:airline_detect_modified = 1
let g:airline_theme="solarized"
let g:airline_solarized_normal_green = 1
" Required for CtrlSpace integration
let g:airline_exclude_preview = 1
" End CtrlSpace integration
let g:airline#extensions#whitespace#enabled=0

"CtrlSpace
set hidden
let g:ctrlspace_project_root_markers = [".git", ".hg", ".svn", ".bzr", "_darcs", "CVS", "proj.sln"]

"NerdTree
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__']

"Git Gutter
let g:gitgutter_highlight_lines = 1
let g:gitgutter_sign_column_always = 1
