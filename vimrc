set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize

let dotvimdir=split(&rtp,',')[0]
let &rtp.=','.dotvimdir.'/bundle/Vundle.vim'
call vundle#begin(dotvimdir.'/bundle')

" FIX: PluginUpdate => git pull: git-sh-setup: No such file or directory in MacVim (OK in non-GUI version of Vim)
if has("gui_macvim")
    set shell=/bin/bash\ -l
endif
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
" 
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
if !has("win32")
Plugin 'vimoutliner/vimoutliner'
" Plugin 'HTML.zip'
endif
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
Plugin 'xoria256.vim'
Plugin 'bufexplorer.zip'
Plugin 'HTML5-Syntax-File'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use version instead
set nowritebackup       " write buffer to original file

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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
  filetype plugin indent on

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

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" colorscheme xoria256
if has('gui_running')
    set background=dark
else
    set background=dark
endif
colorscheme solarized

au BufRead,BufNewFile *.scss set filetype=scss

autocmd BufReadPre *.doc set ro
autocmd BufReadPre *.doc set hlsearch!
autocmd BufReadPost *.doc %!antiword "%"
autocmd BufRead *.safari setfiletype html

" make editing text files more like a GUI editor
set lbr
set cursorline

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
  elseif has("gui_photon")
    set guifont=Bitstream\ Vera\ Sans\ Mono:h14
  elseif has("gui_kde")
    set guifont=Bitstream\ Vera\ Sans\ Mono\14/-1/5/50/0/0/0/1/0
  elseif has("x11")
    set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
  elseif has("gui_macvim")
    set guifont=Bitstream\ Vera\ Sans\ Mono:h14
  else
    set guifont=Bitstream\ Vera\ Sans\ Mono:h14:cDEFAULT
  endif
endif

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

" a handy function for formatting clipboard text
" to a more text-to-speach friendly format
function! FormatTTS()
  % s/\n/\r\r/g
  % s/\n\n\n\n/\r\r/g
  % s/[^[:alnum:][:punct:][:space:]]//ge
  % s/\n\n/\r[[slnc 2000]]\r/ge
endfunction

nmap \F :call FormatTTS()<CR>

" prep html-tagged code into plain text
function! StripHTML()
  % ! html2textpy.py --ignore-links --ignore-images
  % s/|/ /g
  % s/\W\{2,\}/ /g
  % s/^\W*//g
  % s/\n\{2,\}/[break]/g
  % s/\n/ /g
  % s/\[break\]/\r\r/g
  g/If this email is difficult to read view it on the web/d
  g/View this email in your browser/d
endfunction

nmap \G :call StripHTML()<CR>

" The contents of this file are mostly from a Gist by Tim Pope
" (https://gist.github.com/287147) with minor adjustments.

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
