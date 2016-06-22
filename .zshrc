# Path to your oh-my-zsh installation.
export ZSH=/Users/binneyd/.oh-my-zsh
#export LANG=en_AU.utf8

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="agnoster"
ZSH_THEME="amuse"
ZSH_THEME="ys"

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
# COMPLETION_WAITING_DOTS="true"

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
plugins=(cake git sublime osx git-flow git-extras npm node theme web-search battery brew osx sublime)
# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
source ~/.creds

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export TERM=xterm-256color
export PATH=$PATH

alias pgp="/usr/local/Cellar/postgresql/9.4.4/bin/pg_ctl -m fast -D /usr/local/var/postgres stop"
alias pgs="/usr/local/Cellar/postgresql/9.4.4/bin/pg_ctl -D /usr/local/var/postgres start"
alias pgr="/usr/local/Cellar/postgresql/9.4.4/bin/pg_ctl -m fast -D /usr/local/var/postgres restart"

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
alias updatedb='sudo /usr/libexec/locate.updatedb'
export PATH=$PATH:/Applications/Araxis\ Merge.app/Contents/Utilities

export PATH=$PATH:/opt/chefdk/bin
export PATH=$PATH:/usr/local/Cellar/php56/5.6.19/bin
export HISTCONTROL=ignoredups

export AWS_CREDENTIAL_FILE="/Users/binneyd/.aws/credentials"
export EC2_URL=https://ec2.ap-southeast-2.amazonaws.com

source /usr/local/share/zsh/site-functions/_aws
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh


###docker stuff
export DOCKER_CERT_PATH=/Users/binneyd/.docker/machine/machines/default
export DOCKER_HOST=tcp://192.168.99.100:2376
export DOCKER_TLS_VERIFY=1
export RESOURCES_PATH="/Applications/Docker/Kitematic (Beta).app/Contents/Resources/resources"
export PWD=/Users/binneyd/mywork/docker/apache
export NODE_PATH="/Applications/Docker/Kitematic (Beta).app/Contents/Resources/app.asar/node_modules"
export OLDPWD=/Users/binneyd/mywork/docker/apache


alias mdl-data='. real-mdl-data'
alias mdl-code='. real-mdl-code'
alias mdl-open='. real-mdl-open'


alias l='ls -CFa'

alias o='xdg-open'

alias grep='grep --color=auto'

export PATH="$PATH:$HOME/scripts/"
export PATH="$PATH:$HOME/moosh/bin"
eval "$(/home/brendan/moosh/bin/moosh init -)"

export DEBFULLNAME='Brendan Heywood'
export DEBEMAIL='brendan@catalyst.net.nz'

# This add magic, like cd'ing to a remote dir on login :)
alias ssh='~/scripts/ssh'

# I always seem to type this!
alias cd..='cd ..'

export LESS="-riMSx4 -FX --shift .1"
# -r  show raw control chars (so colors work)
# -i  ignore case
# -M  verbose prompt
# -S  chop long lines
# -x4 tabs stop at 4
# -F  quit if one screen
# -X  disable screen clear
# --shift .1 left and right move 10% of screen
#

# If a command you run returns a fail, it isn't available when you press 'up' which is real pain
# in the arse when you are re-running things consstantly that fail, like a unit test. This fixes
# that so all commands go into the history
# HISTCONTROL=ignoreboth

# This is pure gold! (actually I thought it was, but it turns out to fairly impractical and I keep on
# accidentally cd'ing to some random place, or worse I tab auto complete when I know there is a single
# directory, and it doesn't autocomplete because it's searching other directories. So I've commented out
# but left in as a cautionary tale:
# Add your 'projects' or whatever folder to CDPATH enables you to 'cd <tab-autocomplete>' to it from anywhere
#   export CDPATH=".:/var/www/"
export CDPATH="."


# Disable globbing on the remote path.
alias scp='noglob scp_wrap'
function scp_wrap {
  local -a args
  local i
  for i in "$@"; do case $i in
    (*:*) args+=($i) ;;
    (*) args+=(${~i}) ;;
  esac; done
  command scp "${(@)args}"
}


