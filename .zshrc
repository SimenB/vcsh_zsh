# Source zplug
if [ "$(uname)" = "Darwin" ]; then
  export ZPLUG_HOME=/usr/local/opt/zplug
  export CHROME_BIN="/usr/local/Caskroom/google-chrome/latest/Google Chrome.app/Contents/MacOS/Google Chrome"
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  # Check if zplug is installed
  if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self
  fi

  export ZPLUG_HOME=~/.zplug
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
  # Do something under Windows NT platform¬
fi

source $ZPLUG_HOME/init.zsh

source $HOME/.local.zshrc
source $HOME/.zshalias

# Plugins

## zsh
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"

## oh-my-zsh

### git
zplug "plugins/git", from:oh-my-zsh, if:"which git", nice:10
zplug "plugins/git-extras", from:oh-my-zsh, if:"which git", nice:10

## Other
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh, nice:10
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/mvn", from:oh-my-zsh, if:"which mvn"
zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]", nice:10
zplug "plugins/brew", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "rupa/z"
zplug "johnhamelink/rvm-zsh", if:"which rvm"

zplug "themes/agnoster", from:oh-my-zsh

# Automatically start a tmux session on login
ZSH_TMUX_AUTOSTART="true"

export NVM_DIR=~/.nvm

# If a space is added before the command, don't add it to history
# Useful if you enter your password in a command
setopt HIST_IGNORE_SPACE

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

