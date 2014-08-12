" Load vundle
set nocompatible
filetype off
set rtp+=~/scripts/.vim/bundle/vundle/
call vundle#rc()

" Load vundle bundles
Bundle 'gmarik/vundle'
Bundle 'airblade/vim-gitgutter'

" To add more
" git submodule add git@github.com:airblade/vim-gitgutter.git .vim/bundle/vim-gitgutter
" Then add Bundle call above
" After adding to above, in vim run :BundleInstall!

filetype on


" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

set number

set mouse=a

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set clipboard=unnamed

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

