# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="awood"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colorize rvm gitfast)

source $ZSH/oh-my-zsh.sh

fpath=( ~/.zfunc "${fpath[@]}" )

function () {
    local zfuncs
    zfuncs=()
    for f in ~/.zfunc/*(.); do
        zfuncs+=$(basename $f)
    done
    autoload -Uz "$zfuncs[@]"
}

zle -N after-first-word
bindkey "^X^Z" after-first-word

# See the zshcontrib man page. Best used with 'noglob'. Use -n for dry-run.
autoload -Uz zmv

# Customize to your needs...
HISTSIZE=10000
SAVEHIST=10000
export EDITOR="vim"
export VISUAL="vim"
export LESS="-M --jump-target=5 --shift 4"
export PROJECT_HOME="$HOME/devel"
export WORKON_HOME="$HOME/.virtualenvs"
export VAGRANT_DEFAULT_PROVIDER="libvirt"

unsetopt correct_all
unsetopt correct
unsetopt share_history
setopt inc_append_history
setopt extended_glob

# Don't bother caching the list of command completions; just
# regenerate every time so I don't get a stale cache. See
# http://unix.stackexchange.com/a/2180 (If you comment out
# this option then "rehash" can refresh the cache.
zstyle ":completion:*:commands" rehash 1

alias tomtail="tmux new-session -s logging -n candlepin.log 'less /var/log/candlepin/candlepin.log' \; neww -n catalina.out 'less /var/log/tomcat/catalina.out' \; selectw -t 1"
alias docker-kill-containers="docker ps -a -q | xargs docker rm"
alias rpmbuild-local='rpmbuild --define "_sourcedir ." --define "_specdir ."'
alias npm-exec='PATH=$(npm bin):$PATH'

if [ -f ~/.less_colors ]; then
    source ~/.less_colors
fi

path+=("$HOME/bin")
path+=('/sbin')
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Remove all path directories which don't exist
# See http://stackoverflow.com/questions/9347478/how-to-edit-path-variable-in-zsh#9352979
path=($^path(N))
# Remove duplicates on the path
typeset -U path
