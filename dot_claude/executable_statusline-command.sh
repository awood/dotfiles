#!/bin/bash

# tput requires info about the terminal to use
TERM=${TERM:-linux}
export TERM

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
effort=$(echo "$input" | jq -r '.effort.level // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

cwd="${cwd/#$HOME/\~}"

sep="|"

# Initialize tput color definitions (with fallback to empty string if tput fails)
RESET=$(tput sgr0 || echo '')
BOLD=$(tput bold || echo '')
BLACK=$(tput setaf 0 || echo '')
RED=$(tput setaf 1 || echo '')
GREEN=$(tput setaf 2 || echo '')
YELLOW=$(tput setaf 3 || echo '')
WHITE=$(tput setaf 7 || echo '')
GRAY=$(tput setaf 10 || echo '')
BG_RED=$(tput setab 1 || echo '')
BG_GREEN=$(tput setab 2 || echo '')
BG_YELLOW=$(tput setab 3 || echo '')
BG_WHITE=$(tput setab 7 || echo '')

# Build model + effort segment
model_text=" $model"
if [ -n "$effort" ]; then
  model_text="$model_text [$effort]"
fi
model_text="$model_text "

# Build context segment with color-coded progress bar using NerdFont glyphs
if [ -n "$used_pct" ]; then
  bar_width=10
  filled=$(printf "%.0f" "$(echo "$used_pct * $bar_width / 100" | bc -l)")
  empty=$((bar_width - filled))

  # Determine color based on usage percentage
  if (( $(echo "$used_pct < 50" | bc -l) )); then
    context_fg="${GREEN}"
  elif (( $(echo "$used_pct < 70" | bc -l) )); then
    context_fg="${YELLOW}"
  else
    context_fg="${RED}"
  fi

  if [ "$filled" -eq 0 ]; then
    bar="${context_fg}"
    empty=$((empty - 1))
  else
    bar="${context_fg}"
    filled=$((filled - 1))
  fi

  # -1 for the left hand side, -1 for the right hand side
  unfilled=$((bar_width - 2))
  for ((i=0; i<unfilled; i++)); do
    if [ "$filled" -eq 0 ]; then
      bar+=""
      empty=$((empty - 1))
    else
      bar+=""
      filled=$((filled - 1))
    fi
  done

  if [ "$filled" -ne 0 ]; then
    bar+="${RESET}"
  else
    bar+="${RESET}"
  fi

  context_text=$(printf " %s %3.0f%% " "$bar" "$used_pct")
else
  bar="${GRAY}${RESET}"
  context_text=$(printf " %s  0%% " "$bar")
fi

# If the prompt is too slow, consolidate all these statements to avoid the
# extra overhead.  But I like it broken into three statements for readability.

# Segment 1: Working directory (default colors)
printf "%s %s" "$cwd" "$sep"

# Segment 2: Model + Effort
printf "${GRAY}%s${RESET} %s" "$model_text" "$sep"

# Segment 3: Context bar (color-coded)
printf "%s${RESET} %s\n" "$context_text" "$sep"
