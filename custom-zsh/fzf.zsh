# Fedora installs the FZF completions in ZSH's site-functions which is
# not where Oh My ZSH's FZF plugin expects to source it from

# Auto-completion
if [[ -o interactive && "$DISABLE_FZF_AUTO_COMPLETION" != "true" ]]; then
    source "/usr/share/zsh/site-functions/fzf" 2> /dev/null
fi

_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"
  # Uncomment for truecolor, if your terminal supports it.
  # local base03="#002b36"
  # local base02="#073642"
  # local base01="#586e75"
  # local base00="#657b83"
  # local base0="#839496"
  # local base1="#93a1a1"
  # local base2="#eee8d5"
  # local base3="#fdf6e3"
  # local yellow="#b58900"
  # local orange="#cb4b16"
  # local red="#dc322f"
  # local magenta="#d33682"
  # local violet="#6c71c4"
  # local blue="#268bd2"
  # local cyan="#2aa198"
  # local green="#859900"

  # Comment and uncomment below for the light theme.

  # Solarized Dark color scheme for fzf
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:$base02,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
  "
  ## Solarized Light color scheme for fzf
  #export FZF_DEFAULT_OPTS="
  #  --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
  #  --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  #"
}
_gen_fzf_default_opts

export FZF_CTRL_R_OPTS="--layout reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --header='Press ? to preview / CTRL-R for chrono order'"

# CTRL-T will trigger context-aware fuzzy completion
# See https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion#dedicated-completion-key and
# https://github.com/junegunn/fzf#fuzzy-completion-for-bash-and-zsh
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview 'bat --style=numbers --color=always --line-range :500 {}'))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0 --select-1) &&  tmux $change -t "$session" || echo "No sessions found."
}

# vg - fuzzy grep open via rg with line number
vg() {
  local file
  local line

  # The preview window bit is described in the man page section for the --preview-window option but basically: ~2 is
  # the top 2 lines as a fixed header, +{2} is the base scroll offset extracted from the second field, +2 is an extra
  # 2 line offset to account for the header, /2 is put in the middle of the preview area
  read -r file line <<<"$(rg -n --no-heading $@ | fzf --exit-0 --select-1 --layout reverse --delimiter : --preview-window '~2,+{2}+2/2' --bind '?:toggle-preview' --header='Press ? to toggle preview' --preview 'bat --style=full --color=always --highlight-line {2} {1}' | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# podrmi - Select a podman image or images to remove. Use TAB for making selections
podrmi() {
  podman images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r podman rmi
}
