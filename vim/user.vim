"=================\
" Custom behavior |
"=================/

" Turn on detection, plugin and indent.
" Detection: Detect filetype every time a file is edited.
" Plugin: Load the corresponding plugin file every time a file is edited.
" Indent: Load the corresponding indent file every time a file is edited.
"
" This is the equivalent of setting:
"
" filetype on
" filetype plugin on
" filetype indent on
filetype plugin indent on

" Identation WITHOUT hard tabs (\t)
set expandtab " On pressing <TAB>, insert 'softtabstop' spaces
set softtabstop=4 " Width of <TAB> character
set shiftwidth=4 " Width of indentation when indenting with >>, << or with
                 " automatic indentation.

" Formatting
set number " Show line numbers
set hlsearch " Highlight search matches
set cursorline " Highlight current line
set colorcolumn=100 " Highlight column <colorcolumn>
set textwidth=100 " Set automatic word wrapping to <textwidth> columns

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Influences the working of `<BS>`, `<Del>`, `CTRL-W` and `CTRL-U` in Insert
" mode.  This is a list of items, separated by commas.  Each item allows
" a way to backspace over something:
" 
" value     effect
" indent    allow backspacing over autoindent
" eol       allow backspacing over line breaks (join lines)
" start     allow backspacing over the start of insert; CTRL-W and CTRL-U
"           stop once at the start of insert.
set backspace=indent,eol,start

" Autocompletion
" Enter key will simply select the highlighted menu item
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"

" Omnicompletion
" General
set omnifunc=syntaxcomplete#Complete
" Python
autocmd Filetype python set omnifunc=syntaxcomplete#Complete
" OmniCppComplete
autocmd Filetype cpp set omnifunc=omni#cpp#complete#Main
let OmniCpp_NamespaceSearch = 1 " search namespaces in the current file
let OmniCpp_GlobalScopeSearch = 1 " Enable global scope search
let OmniCpp_ShowAccess = 1 " Show the access (+,#,-) 
let OmniCpp_ShowPrototypeInAbbr = 1 " Set if the function prototype is displayed in the abbr column of the popup
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
set tags+=~/.vim/tags/cpp

"==================\
" Custom functions |
"==================/

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - https://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

"========================\
" Custom maps / bindings |
"========================/

" Previous buffer
nnoremap <silent> <leader>[ <esc>:bp<cr>
" Next buffer
nnoremap <silent> <leader>] <esc>:bn<cr>

" Previous tab
nnoremap <silent> <leader>, <esc>:tabp<cr>
" Next tab
nnoremap <silent> <leader>. <esc>:tabn<cr>

" Show buffers
nnoremap <silent> <leader>b :buffers<cr>
" Close buffer but not window
nnoremap <silent> <leader>bd :bp<cr>:bd #<cr>

" Format xml file
nnoremap <silent> <leader>fx ggvG:'<,'>!xmllint --format -<cr>

" Toggle hlsearch
nnoremap <silent> <expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Toggle NERDTree
nnoremap <silent> <leader>nn :NERDTreeToggle<cr>
nnoremap <silent> <leader>nf :NERDTreeFind<cr>

" PASTE mode
nnoremap <silent> <leader>p :set paste<cr>

" Quit
nnoremap <silent> <leader>q <esc>:q<cr>

" Select text in visual mode and press <leader>-r to write the replacement string
vnoremap <leader>r <Esc>:%s/<c-r>=GetVisual()<cr>//gc<left><left><left>

" Search nocase
nnoremap <leader>s /\c

" New tab
nnoremap <silent> <leader>tt <esc>:tabe<cr>
" Open current buffer in a new tab
nnoremap <silent> <leader>tr :tabedit %<cr>

" Write
nnoremap <silent> <leader>w <esc>:w<cr>

"=========\
" Plugins |
"=========/
" Plugins are managed with vim-plug (https://github.com/junegunn/vim-plug)

" Note that --sync flag is used to block the execution until the installer
" finishes. If you're behind an HTTP proxy, you may need to add --insecure
" option to the curl command. In that case, you also need to set
" $GIT_SSL_NO_VERIFY to true.
if empty(glob('~/.vim/autoload/plug.vim')) " <- vim-plug will be installed here
    silent !echo "First usage on current host. 
        \ Downloading and installing vim-plug..."
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    silent !echo "Done\!"
    silent !echo "Launching vim..."
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC " <- This will 
      " install all plugins below
endif

" Start of vim-plug section
call plug#begin('~/.vim/plugged') " <- Plugins will be installed here

Plug 'vim-airline/vim-airline'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'kien/ctrlp.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'lifepillar/vim-mucomplete'
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-signify'
Plug 'lifepillar/vim-solarized8'

call plug#end()
" End of vim-plug section

"=======================\
" Plugins customization |
"=======================/

" For vim-airline
" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" For vim-solarized8
syntax enable " Enable syntax highlitghting
set background=dark
colorscheme solarized8

" For vim-mucomplete
" completeopt available options: 
"   - menuone: Normal mode
"   - noselect: autocomplete with no selection
"   - noinsert: autocomplete with no insertion
set completeopt-=preview
set completeopt+=menuone
set completeopt+=noselect
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 500

" For NERDTree
" Opening file in a new tab keeps NERDTree open
autocmd BufWinEnter * NERDTreeMirror
