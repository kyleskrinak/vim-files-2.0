set encoding=utf-8

filetype plugin indent on    " required

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup      " do not keep a backup file, use version instead
set nowritebackup " write buffer to original file
set history=50    " keep 50 lines of command line history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set lbr
set cursorline
"
" set base coding format
set ts=2
set sw=2
set expandtab

syntax on
set hlsearch

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.

  autocmd BufRead,BufNewFile *.md,*.markdown setlocal spell
  au BufRead,BufNewFile *.scss set filetype=scss

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
