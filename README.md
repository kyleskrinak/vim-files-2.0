This is my vim configuration. My goal is for this to be cross platform, as per this question: http://stackoverflow.com/questions/11576646/can-i-version-a-path-in-git-whose-name-is-operating-system-dependent

This revision marks my change from pathogen to [Vundle.](https://github.com/gmarik/Vundle.vim) Vundle allows me to configure my plugins in my vimrc file. So I only need vundle, which loads with the git submodule init/update command. Afterwards, Vundle will retrieve the necessary plugins.

### Installation process:  
1. Replace the existing $HOME/.vim with `git clone https://github.com/kyleskrinak/vim-files-2.0 .vim`
    1. On Windows, with mingw, use "vimfiles" instead of .vim
1. The only submodule tracked is Vundle.vim — which will load all plugins after installation, as per the vimrc
1. Create a $HOME/.vimrc with the contents `runtime vimrc`
    1. On Windows, use "_vimrc" instead of ".vimrc"
1. `cd .vim` (or `cd vimfiles` on Windows)
1. `git submodule init`
1. `git submodule update`
1. Launch vim — with an xoria error
1. Run the PluginInstall function to load all plugins
