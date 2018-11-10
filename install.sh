#!/bin/bash
# Install awesomevim
if [ -d "$HOME/.vim_runtime" ];then
  echo "$HOME/.vim_runtime exists."
  echo "Skipping cloning Git repo."
else
  echo "$HOME/.vim_runtime does not exist."
  echo "Cloning Git repo."
  GITHUB_URL=https://github.com/amix/vimrc.git
  git clone --depth=1 $GITHUB_URL $HOME/.vim_runtime
  if [ -d "$HOME/.vim_runtime" ];then
    echo "$HOME/.vim_runtime successfully created from $GITHUB_URL repository."
    echo "Installing awesome vim."
    sh $HOME/.vim_runtime/install_awesome_vimrc.sh
  else
    exit 1
  fi
fi
VIM_HOME=$HOME/.vim_runtime
# Done with install awesomevim
# Add Airline plugin
AIRLINE_PATH="$VIM_HOME/my_plugins/vim-airline"
GITHUB_URL=https://github.com/vim-airline/vim-airline
if [ -d "$AIRLINE_PATH" ];then
  echo "$AIRLINE_PATH found, skipping clone."
else
  echo "$AIRLINE_PATH not found, cloning from $GITHUB_URL"
  git clone $GITHUB_URL $AIRLINE_PATH
  if [ -d "$AIRLINE_PATH" ];then
    echo "Successfully cloned $GITHUB_URL into $AIRLINE_PATH"
  else
    exit 1
  fi
fi
# Done with add Airline plugin
# Add custom my_configs.vim
MY_CONFIGS_PATH=$VIM_HOME/my_configs.vim
if [ -f "$MY_CONFIGS_PATH" ];then
  echo "$MY_CONFIGS_PATH found, skipping file creation."
else
  echo "$MY_CONFIGS_PATH not found, creating file"
  touch $MY_CONFIGS_PATH
  echo "Turning line numbers on, setting tab to two spaces, setting foldmethod to indent, enabling autoindent."
  cat <<- EOF | perl -ne "s/^\s+//;print" > $MY_CONFIGS_PATH
    " line numbers
    set nu
    " end of line numbers
    " two space tab
    set expandtab
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
    " end of two space tab
    " foldmethod indent
    set foldmethod=indent
    " end of foldmethod indent
    " autoindent
    set autoindent
    set smartindent
    imap <C-Return> <CR><CR><C-o>k<Tab>
    " end of autoindent
    " nerdtree settings
    autocmd VimEnter * NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " end of nerdtree settings
EOF
  if [ -f "$MY_CONFIGS_PATH" ];then
    echo "Successfully created $MY_CONFIGS_PATH"
  else
    exit 1
  fi
fi
# Done with add custom my_configs.vim
# Get colorschemes
COLORSCHEMES_PATH=$VIM_HOME/my_plugins/colorschemes
GITHUB_URL=https://github.com/flazz/vim-colorschemes.git
if [ -d "$COLORSCHEMES_PATH" ];then
  echo "Found colorschemes at $COLORSCHEMES_PATH, skipping clone operation."
else
  echo "Didn't find colorschemes. Cloning $GITHUB_URL into $COLORSCHEMES_PATH"
  git clone $GITHUB_URL $COLORSCHEMES_PATH
  if [ -d "$COLORSCHEMES_PATH" ];then
    echo "Successfully cloned $GITHUB_URL into $COLORSCHEMES_PATH"
  else
    exit 1
  fi
  echo "adding preferred colorscheme to $MY_CONFIGS_PATH"
  echo "colorscheme spacegray" >> $MY_CONFIGS_PATH
fi
# Done with get colorschemes
echo "Done setting up Josue's vim setup. Enjoy! :)"
