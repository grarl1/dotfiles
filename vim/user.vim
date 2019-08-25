"=================\
" Custom behavior |
"=================/

" Filetype options
filetype plugin indent on " Turn on filetype detection and loading of plugin and indent files.

" Identation
set expandtab " On pressing <TAB>, insert 'softtabstop' spaces
set softtabstop=4 " Width of <TAB> character in spaces
set shiftwidth=4 " Width of indentation when indenting with >>, << or with automatic indentation.
set autoindent " Always set autoindenting on
set copyindent " Copy the previous indentation on autoindenting
set smarttab " Insert <TAB> according to how it's done in other places in the file

" Searching
set hlsearch " Highlight search matches
set incsearch " Highlight while typing
set ignorecase " Ignore case when searching
set smartcase " Ignore case only if search string is lowercase. Needs ignorecase to be set.

" Rows and columns
set number " Show line numbers
set cursorline " Highlight current line
set colorcolumn=100 " Highlight column <colorcolumn>
set textwidth=100 " Set automatic word wrapping to <textwidth> columns

" Allow backspacing over autoindent, line breaks, start of insert
set backspace=indent,eol,start

" Buffers
set hidden " Hide buffers instead of closing them. Allow to switch buffers without saving.

" Highlighting
autocmd ColorScheme * " Avoid having highlight cleared by ColorScheme
        \ highlight Tabs ctermbg=green |
        \ highlight TrailingWhitespace ctermbg=yellow
" Match tabs in green and trailing whitespaces in yellow
highlight Tabs ctermbg=green
highlight TrailingWhitespace ctermbg=yellow
match Tabs /\t/
2match TrailingWhitespace /\s\+$/

" Have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

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


"========================\
" Custom maps / bindings |
"========================/

" Enter key will simply select the highlighted menu item
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"

" Previous buffer
nnoremap <silent> <leader>[ <esc>:bp<cr>
" Next buffer
nnoremap <silent> <leader>] <esc>:bn<cr>

" Previous tab
nnoremap <silent> <leader>, <esc>:tabp<cr>
" Next tab
nnoremap <silent> <leader>. <esc>:tabn<cr>

" Show buffers
nnoremap <silent> <leader>bb :buffers<cr>
" Close buffer but not window
nnoremap <silent> <leader>bd :bp<cr>:bd #<cr>
" Open current buffer in a new tab
nnoremap <silent> <leader>bt :tabedit %<cr>

" Format xml file
nnoremap <silent> <leader>fx ggvG:'<,'>!xmllint --format -<cr>
" Format c code
nnoremap <silent> <leader>fc :ClangFormat<cr>
vnoremap <silent> <leader>fc :ClangFormat<cr>

nnoremap <silent> <leader>fjp ggvG:'<,'>!jq .<cr>
nnoremap <silent> <leader>fjm ggvG:'<,'>!jq -c .<cr>

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
vnoremap <leader>r <esc>:%s/<c-r>=GetVisual()<cr>//gc<left><left><left>

" New tab
nnoremap <silent> <leader>t <esc>:tabe<cr>

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
Plug 'rhysd/vim-clang-format'
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

