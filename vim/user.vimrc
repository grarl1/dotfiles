" Vundle plugins
so ~/.vim/plugins.vim

" Make lightline work
set laststatus=2

" Search and replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
