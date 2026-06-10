#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Get current git branch
git_branch=$(git -c core.fileMode=false -c gc.autodetach=false symbolic-ref --short HEAD 2>/dev/null || git -c core.fileMode=false -c gc.autodetach=false rev-parse --short HEAD 2>/dev/null)

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

# Build status line
status=""

# Git branch in light blue
if [ -n "$git_branch" ]; then
  status=$(printf "\033[96m%s\033[0m" "$git_branch")
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
  status="${status}$(color_usage "$seven_d" "7d")"
fi

# Model in dim/italic
if [ -n "$model_short" ]; then
  [ -n "$status" ] && status="$status | "
  status="${status}$(printf "\033[2m%s\033[0m" "$model_short")"
fi

echo "$status"
