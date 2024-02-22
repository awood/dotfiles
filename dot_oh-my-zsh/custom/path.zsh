path+=("$HOME/bin")
path+=("$HOME/.cargo/bin")
path+=("$HOME/.local/bin")
path+=('/sbin')
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Remove all path directories which don't exist
# See http://stackoverflow.com/questions/9347478/how-to-edit-path-variable-in-zsh#9352979
path=($^path(N))
# Remove duplicates on the path
typeset -U path
