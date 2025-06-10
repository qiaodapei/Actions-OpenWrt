let mapleader="\<Space>"
set nocompatible                     " use vim defaults
set showcmd                          " display incomplete commands
set showmatch                        " jump to matchs when entering parenthes
set matchtime=1                      " tenths of a secend to show the matching parenthes
set backspace=indent,eol,start       " make that backspace key work the way it should
set textwidth=0                      " don't wrap lines by default
set ruler                            " show the current row and column
set number                           " show line numbers
set wildmenu                         " show list instead of just completing
set splitright                       " put new split window in right
set nobackup                         " don't keep a backup file
set fillchars=vert:│                 " change vertsplit character
set ttimeoutlen=100                  " set <esc> reponse time
set path+=**                         " searches current directory recursively.

filetype plugin on
set modeline                         " for specify filetype

syntax on                            " turn syntax highlighting on by defautl
set mouse=a                          " turn mouse support on

set nowrap                           " line exceed screen don't wrap
"set breakindent                     " set indent in wrap
"set breakindentopt=shift:1          " wrap line additional indent
"set list                            " show nontext
"set listchars=extends:>,precedes:<  " show at line left/right if wrap is off
"set sidescroll=1                    " line exceed screen cursor smooth scrolling
set laststatus=2                     " always show statusline
"set numberwidth=5                   " line number width configure 
"set cursorline                      " highlight current line
set scrolloff=2                      " keep <n> lines when scrolling

set novisualbell                     " turn off visualbell
set noerrorbells                     " turn off errorbell

set hlsearch                         " highlight searchs
set incsearch                        " do incremental searching
set ignorecase                       " ignore case when searching
set smartcase                        " no ignorecase if Uppercase char present

set autoindent                       " always set autoindenting on
set smartindent                      " indent works for c-like
set tabstop=4                        " <Tab> width look for
set expandtab                        " expand <Tab> as spaces
set softtabstop=4                    " spaces number when insert <Tab>
set shiftround                       " indent not to multiple of 'shiftwidth'
set shiftwidth=4                     " number of spaces to use for (auto)indent

set swapfile                         "enable swap file
set directory=~/.vim/swap//          "set swp file directory.
if !isdirectory(&directory)          " Create folder if not exists
    silent! call mkdir(&directory, 'p')
endif
set updatecount=20                   "save swp file every amount of characters
set updatetime=4000                  "save swap file every amount of ms

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" adjust split sizes easier
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize -3<CR>
nnoremap <silent> <C-Down> :resize +3<CR>

" Close buffer
nnoremap <silent> <Leader>bd :bd<CR> 

" remap split navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Leader>wc <C-w>c

" switch tab
nnoremap H gT
nnoremap L gt
nnoremap T H
nnoremap B L

" change split windows from vertical to horizontal or vice versa
nnoremap <leader>th <C-w>t<C-w>H
nnoremap <leader>tk <C-w>t<C-w>K

" filetree
let g:netrw_banner=0
"let g:netrw_winsize=30
"let g:netrw_liststyle=3
"let g:netrw_altv=1
"let g:netrw_browse_split=4
nnoremap <silent> <leader>e :Ex<CR>
"autocmd filetype netrw nnoremap <buffer> <C-l> <C-w>l

" User Interface
set t_Co=256
set background=dark
hi TabLine term=underline cterm=NONE ctermfg=15 ctermbg=242 guibg=DarkGrey
hi TabLineFill term=underline cterm=NONE ctermfg=15 ctermbg=242 guibg=DarkGrey
hi LineNr term=underline ctermfg=242 guifg=DarkGrey
