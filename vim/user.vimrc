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
set textwidth=80 " Set automatic word wrapping to 80 columns
set number " Show line numbers

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

" Highlight current line
set cursorline

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

" Select text in visual mode and press <leader>-r to write the replacement string with
" the selected text
vnoremap <leader>r <Esc>:%s/<c-r>=GetVisual()<cr>//gc<left><left><left>

" Toggle NERDTree
nnoremap <silent> <leader>nn :NERDTreeToggle<CR>
nnoremap <silent> <leader>nf :NERDTreeFind<CR>

" Binding for quit and save
nnoremap <silent> <leader>q <esc>:q<CR>
nnoremap <silent> <leader>w <esc>:w<CR>

" Bindings for tabs
" New tab
nnoremap <silent> <leader>tt <esc>:tabe<CR>
" Previous tab
nnoremap <silent> , <ESC>:tabp<CR>
" Next tab
nnoremap <silent> . <ESC>:tabn<CR>
" Open current buffer in a new tab
nnoremap <silent> <leader>tr :tabedit %<CR>

" Previous buffer
nnoremap <silent> <leader>[ <esc>:bp<CR>
" Next buffer
nnoremap <silent> <leader>] <esc>:bn<CR>

" Toggle hlsearch
nnoremap <silent> <expr> <leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Bindings for formatting
" Format xml file
nnoremap <silent> <leader>x ggvG:'<,'>!xmllint --format -<CR>

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

Plug '~/git_clones/vim_plugins/nerdtree'
Plug '~/git_clones/vim_plugins/ctrlp.vim'
Plug '~/git_clones/vim_plugins/lightline.vim'
Plug '~/git_clones/vim_plugins/vim-colors-solarized'

call plug#end()
" End of vim-plug section

"=======================\
" Plugins customization |
"=======================/

" For lighline
" To see available values for the bar, type :h g:lightline.component
set laststatus=2 " Always display status line
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \     'active': {
    \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
    \         'right': [['lineinfo'], ['percent'], ['bufnum', 'fileformat', 'fileencoding']]
    \     }
    \ }


" For vim-colors-solarized
syntax enable " Enable syntax highlitghting
set background=dark
colorscheme solarized
