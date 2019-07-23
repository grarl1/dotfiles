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


"=============\
" Custom maps |
"=============/

" Select text in visual mode and press C-r to write the replacement string with
" the selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>


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

Plug 'scrooloose/nerdtree'

call plug#end()
" End of vim-plug section

