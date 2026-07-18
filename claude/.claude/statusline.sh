#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Get current git branch
git_branch=$(git -c core.fileMode=false -c gc.autodetach=false symbolic-ref --short HEAD 2>/dev/null || git -c core.fileMode=false -c gc.autodetach=false rev-parse --short HEAD 2>/dev/null)

# Get the pull request for the current branch. Cache it because the status line
# refreshes often and `gh pr view` may make a network request.
session_id=$(echo "$input" | jq -r '.session_id // "default"' | tr -cd '[:alnum:]-')
pr_cache="${TMPDIR:-/tmp}/claude-statusline-pr-${session_id}"
pr_cache_max_age=15
pr_cache_mtime=$(stat -f %m "$pr_cache" 2>/dev/null || echo 0)

if [ ! -f "$pr_cache" ] || [ $(( $(date +%s) - pr_cache_mtime )) -gt "$pr_cache_max_age" ]; then
  pr_tmp="${pr_cache}.tmp"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    gh pr view --json number,url --jq '"PR #\(.number)|\(.url)"' >"$pr_tmp" 2>/dev/null || : >"$pr_tmp"
  else
    : >"$pr_tmp"
  fi
  mv "$pr_tmp" "$pr_cache"
fi
pr=$(cat "$pr_cache")
pr_label=""
pr_url=""
if [ -n "$pr" ]; then
  IFS='|' read -r pr_label pr_url <<< "$pr"
fi

# Get total token usage
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
total_tokens=$((total_input + total_output))

# Format total as K or M
if [ $total_tokens -ge 1000000 ]; then
  total_formatted=$(awk "BEGIN {printf \"%.1fM\", $total_tokens/1000000}")
elif [ $total_tokens -ge 1000 ]; then
  total_formatted=$(awk "BEGIN {printf \"%.1fK\", $total_tokens/1000}")
else
  total_formatted="$total_tokens"
fi

# Get rate limit usage (only present for Pro/Max subscribers)
five_h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
seven_d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# Get model
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Shorten model name (strip "claude-" prefix and date suffix)
if [ -n "$model" ]; then
  model_short=$(echo "$model" | sed 's/^claude-//' | sed 's/-[0-9]*$//')
fi

# Color-code a usage percentage: green <50, yellow 50-80, red >=80
color_usage() {
  local pct=$1
  local label=$2
  local int_pct=$(printf "%.0f" "$pct")
  if [ "$int_pct" -ge 80 ]; then
    printf "\033[91m%s %.0f%%\033[0m" "$label" "$pct"   # bright red
  elif [ "$int_pct" -ge 50 ]; then
    printf "\033[93m%s %.0f%%\033[0m" "$label" "$pct"   # bright yellow
  else
    printf "\033[92m%s %.0f%%\033[0m" "$label" "$pct"   # bright green
  fi
}

# Render an OSC 8 hyperlink. Unsupported terminals still display its label.
link() {
  printf '\033]8;;%s\033\\%s\033]8;;\033\\' "$1" "$2"
}

# Build status line
status=""

# Git branch in light blue
if [ -n "$git_branch" ]; then
  status=$(printf "\033[96m%s\033[0m" "$git_branch")
fi

# Pull request for the current branch
if [ -n "$pr_label" ] && [ -n "$pr_url" ]; then
  [ -n "$status" ] && status="$status | "
  status="${status}$(printf "\033[95m")$(link "$pr_url" "$pr_label")$(printf "\033[0m")"
fi

# Token usage
if [ $total_tokens -gt 0 ]; then
  [ -n "$status" ] && status="$status | "
  status="${status}${total_formatted} tokens"
fi

# Rate limit usage (only shown when data is available)
if [ -n "$five_h" ]; then
  [ -n "$status" ] && status="$status | "
  status="${status}$(color_usage "$five_h" "5h")"
fi

if [ -n "$seven_d" ]; then
  [ -n "$status" ] && status="$status "
  status="${status}$(color_usage "$seven_d" "weekly")"
fi

# Model in dim/italic
if [ -n "$model_short" ]; then
  [ -n "$status" ] && status="$status | "
  status="${status}$(printf "\033[2m%s\033[0m" "$model_short")"
fi

echo "$status"
