" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use version instead

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if &t_Co == 256
   colorscheme xoria256
endif

colorscheme koehler

au FileType html compiler tidy
au BufRead,BufNewFile *.scss set filetype=scss
au FileType asp compiler tidy
au BufNewFile,BufRead *.asp set filetype=xhtml

setlocal equalprg=tidy\ --output-xhtml\ y\ -utf8\ --wrap-attributes\ 1\ --vertical-space\ 1\ --indent\ auto\ --wrap\ 0\ --show-body-only\ auto\ --preserve-entities\ 1\ -q\ -f\ /tmp/err
autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"
autocmd BufRead *.safari setfiletype html

set lbr
set cursorline

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Bitstream\ Vera\ Sans\ Mono \14
  elseif has("gui_photon")
    set guifont=Bitstream\ Vera\ Sans\ Mono:h14
  elseif has("gui_kde")
    set guifont=Bitstream\ Vera\ Sans\ Mono\14/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  else
    set guifont=Bitstream\ Vera\ Sans\ Mono:h14:cDEFAULT
  endif
endif



let g:html_tag_case="l"          " html.vim: use lower case html tags
" let g:no_html_toolbar="no"       " html.vim: don't use toolbar
" let g:no_html_menu = 'yes'

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=50 columns=120
endif

map ,nt :NERDTreeToggle<CR>
map ,in :set ts=8<CR>1G=G:set ts=2<CR>`.
set sw=2

function! RunCommands()
	echomsg system(getline('.'))
endfunction
command -range RunCommands <line1>,<line2>call RunCommands()
vmap ,r :RunCommands<CR>
