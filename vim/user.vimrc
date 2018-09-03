"-----------
" Pluggins |
"-----------

" Vundle plugins
so ~/.vim/plugins.vim

" Make lightline plugin work
set laststatus=2

" NERDTree Toggle
nnoremap <C-n> :NERDTreeToggle<CR>
" NERDTree auto open when starting with no args
autocmd StdinReadPre * let s:std_in:1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NERDTree auto open when starting on directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" NERDTree close tab if the remaining window is NerdTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTree auto close when file is open
let NERDTreeQuitOnOpen = 1
" NERDTree delete buffer if filed deleted
let NERDTreeAutoDeleteBuffer = 1
" NERDTree UI enhancement
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"------------------
" Custom behavior |
"------------------

" Set filetype plugin and indent on
filetype plugin indent on

" When indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

"--------------
" Custom maps |
"--------------

" Search and replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
