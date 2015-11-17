# Path to your oh-my-zsh installation.
export ZSH=/Users/pierre/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="tonotdo"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
plugins=(git docker)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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
export LANG="en_US"
export LC_ALL=$LANG.UTF-8
eval "$(plenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export ANDROID_HOME=/usr/local/Cellar/android-sdk/24.3.3/
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH="/usr/local/sbin:$PATH"

function perl_v {
    if type plenv &>/dev/null; then
        if [ -n "$PERL_LOCAL_LIB_ROOT" ]; then
            echo "[perl:${PERL_LOCAL_LIB_ROOT##*/}]"
        else
            version=`plenv version`
            echo "[perl:${version%% *}]"
        fi
    fi
}
export display_prompt_perl="on";
function prompt_perl_toggle {
    if [ -z "$display_prompt_perl" ] ; then
        export display_prompt_perl="on"
    else
        unset display_prompt_perl
    fi
}
function prompt_perl {
    if [ -n "$display_prompt_perl" ] ; then
        perl_v;
    fi
}
export PS1="\$(prompt_perl)$PS1"
eval "$(/Users/pierre/.rakudobrew/bin/rakudobrew init -)"

#docker machine helper
my_docker_machine="default"
function dockon {
    don=`docker-machine status $my_docker_machine`
    if [ $don != "Running" ] ; then
        echo "docker-machine $my_docker_machine is not running, turn it on"
        docker-machine start $my_docker_machine
        echo "docker-machine $my_docker_machine is up"
    else
        echo "docker-machine $my_docker_machine is up"
    fi
    #export env
    eval "$(docker-machine env $my_docker_machine)"
    docker-machine ip $my_docker_machine
}
function dockip {
    docker-machine ip $my_docker_machine
}