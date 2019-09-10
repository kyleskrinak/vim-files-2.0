" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" run the current visual selection as a command
" from my stackexchange question, here: http://tinyurl.com/lfxeobh
function! RunCommands()
  echomsg system(getline('.'))
endfunction
command -range RunCommands <line1>,<line2>call RunCommands()
vmap ,r :RunCommands<CR>

map ,nt :NERDTreeToggle<CR> " nerdtree commands
