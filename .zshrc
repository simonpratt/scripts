# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="dogenpunk"
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
plugins=(mysql git colored-man-pages compleat history tmuxinator zsh-autosuggestions)


source $ZSH/oh-my-zsh.sh

# export AUTOSUGGESTION_HIGHLIGHT_CURSOR=0
# complete entire suggestion with right arrow
# export AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'
export HIST_IGNORE_ALL_DUPS

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias {ack,ak}='ack'
alias ack-grep='ack'


export ANSIBLE_HOST_KEY_CHECKING=False

## java stuff
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-9.0.1.jdk/Contents/Home
export JAVA_TOOL_OPTIONS="-Djava.net.preferIPv4Stack=false"
export PATH="$PATH:$JAVA_HOME/bin"

export GOPATH=~/go
export GOBIN=""
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
alias dc='docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")'
alias get_dns="cat ~/mywork/dnszones/netspot.com.au | sort -nd | grep AAAA | grep -v ';'"
alias get_hosts="cat ~/hosts/all-hosts.dyn"
alias updatedb='sudo gupdatedb'
alias locate='glocate'

##python force to v3
#alias python='python3'
alias py='python3'
export PATH=$PATH:~/Library/Python/3.6/bin

#add bin in home to path
export PATH=$PATH:~/bin

#postgres stuff
alias psql='PAGER="less -SF" psql'
## was causing a "bad option -t"
#source <(kubectl completion bash)

#git suff
export PATH=$PATH:/Applications/Araxis\ Merge.app/Contents/Utilities
export PATH="/usr/local/opt/php71/bin:$PATH"

if foo --version >/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

#ssh agent start
if [[ $(hostname -s) =~ dhcp-.* ]]; then
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dbinney/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/dbinney/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dbinney/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/dbinney/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

source scripts/.iterm2_shell_integration.zsh


