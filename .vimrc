set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=utf-8

" set the runtime path to include Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-surround'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Chiel92/vim-autoformat'
Plugin 'mattn/emmet-vim'
Plugin 'timcharper/textile.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'evidens/vim-twig'
Plugin 'falstro/ghost-text-vim'
Plugin 'vim-scripts/diffchar.vim'
Plugin 'shime/vim-livedown'
Plugin 'vimoutliner/vimoutliner'
Plugin 'bufexplorer.zip'
Plugin 'HTML5-Syntax-File'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup    " do not keep a backup file, use version instead
set nowritebackup       " write buffer to original file

set history=50    " keep 50 lines of command line history
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set incsearch   " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

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

  autocmd BufRead,BufNewFile *.md,*.markdown setlocal spell
  set complete+=kspell

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

  augroup END " vimrcEx group

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

set background=dark

colorscheme solarized

au BufRead,BufNewFile *.scss set filetype=scss

autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"
autocmd BufRead *.safari setfiletype html

" make editing text files more like a GUI editor
set lbr
set cursorline

set guifont=Hack:h14:cANSI:qDRAFT

" Configuration specific to the HTML.vim plugin
" let g:html_tag_case="l"          " html.vim: use lower case html tags

" Set the first GUI window like this
if has("gui_running")
  " GUI is running or is about to start. Maximize gvim window.
  set lines=50 columns=120
endif

map ,nt :NERDTreeToggle<CR> " nerdtree commands

" set base coding format
set ts=2
set sw=2
set expandtab

" run the current visual selection as a command
" from my stackexchange question, here: http://tinyurl.com/lfxeobh
function! RunCommands()
  echomsg system(getline('.'))
endfunction
command -range RunCommands <line1>,<line2>call RunCommands()
vmap ,r :RunCommands<CR>

" Disable the F1 built-in help key
:map <F1> <Esc>
:imap <F1> <Esc>

:iab <expr> dts strftime("%m/%d")
