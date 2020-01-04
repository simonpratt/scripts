# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/scripts:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="dogenpunk"
#ZSH_THEME="xxf"
ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="edvardm"

## POWERLEVEL9K SETTINGS ##
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{white}%F{black} \UE12E `date +%T` %f%k%F{white}%f "
#POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
#POWERLEVEL9K_CUSTOM_INTERNET_SIGNAL="zsh_internet_signal"
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_internet_signal os_icon  dir vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status zsh_showStatus)
#POWERLEVEL9K_OS_ICON_BACKGROUND="white"
#POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
#POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
#POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MODE='nerdfont-complete'

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(postgres mysql git colored-man-pages compleat history kubernetes zsh-autosuggestions)


source $ZSH/oh-my-zsh.sh

# export AUTOSUGGESTION_HIGHLIGHT_CURSOR=0
# complete entire suggestion with right arrow
# export AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'
export HIST_IGNORE_ALL_DUPS




# ------------ end ohmyzsh stuff --------------------



#ssh agent start
#if [[ $(hostname -s) =~ .*david.* ]]; then
#	eval "$(ssh-agent -s)"
#	ssh-add ~/.ssh/id_rsa ~/.ssh/my_id_rsa ~/.ssh/*.pem
#fi



# generic aliases
alias lsn='find . -cmin -30'
alias myip='curl https://ipinfo.io/ip'
alias {ack,ak}='ack'
alias ack-grep='ack'
alias get_dns="cat ~/mywork/dnszones/netspot.com.au | sort -nd | grep AAAA | grep -v ';'"
alias get_hosts="cat ~/hosts/all-hosts.dyn"
alias updatedb='sudo gupdatedb'
alias dlt="find ~/Downloads -type f -newermt '2 day ago' -print0 | xargs -0  ls -oAHd"

# docker stuff 
alias dc='docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")'

# postgres stuff
alias psql='PAGER="less -SF" psql'

# ansible stuff
export ANSIBLE_HOST_KEY_CHECKING=False

# sqlite stuff
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/sqlite/lib"
export CPPFLAGS="-I/usr/local/opt/sqlite/include"

## For pkg-config to find sqlite you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"

# groovy stuff
export GROOVY_TURN_OFF_JAVA_WARNINGS=true

#node stuff
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm


## java stuff
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-10.0.1.jdk/Contents/Home
export JAVA_TOOL_OPTIONS="-Djava.net.preferIPv4Stack=false"
export PATH="$PATH:$JAVA_HOME/bin"
export JVM_ARGS="-Xms512m -Xmx512m"
export HEAP="-Xms1g -Xmx1g -XX:MaxMetaspaceSize=256m"



# kubes stuff
export KUBECONFIG=~/.kube/config:~/.kube/adl-rancher-01
alias ku="kubectl"
alias kup="kubectl get pods -o wide"
alias kua="kubectl get all --all-namespaces"

##python stuff
#alias python='python3'
alias py='python3'
export PATH=$PATH:~/Library/Python/3.7/bin
export PIPENV_VENV_IN_PROJECT=true


## homebrew recomendations
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# aws stuff


ack-ssm-env() {
  params=$(aws ssm get-parameters-by-path --with-decryption --recursive --path $1 | jq -r '.Parameters[] | (.Name + " " + .Value)' | sort -u)
  if [ -z "$2" ]
    then
      echo "filtering none"
      echo $params
  else
    echo "filtering $2"
    echo $params | ack $2
  fi
}

# google cloud stuff

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi

# mac specific stuff 

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


