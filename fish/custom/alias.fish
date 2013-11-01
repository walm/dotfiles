# Utility
alias e vim
alias h history
alias v vagrant
alias m more

# Processes
alias tu "top -o cpu"   # cpu
alias tm "top -o vsize" # memory

# Create a dir and cd it
function take
  mkdir -p $argv
  cd $argv
end

# Send a Growl notification
function growl
  growlnotify -m "$1" -t "Shell notify"
end

# ls
alias ls 'ls -F'
alias l 'ls -lAh'
alias ll 'ls -l'
alias la 'ls -A'

# Git
alias g git
alias gs "git st"
alias gr "git r"
alias ga "git aa"
alias gc "git ci -m"

# Ruby
alias r "rake"

# network
alias ips "ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip "dig +short myip.opendns.com @resolver1.opendns.com"
alias flush "dscacheutil -flushcache" # Flush DNS cache
alias ping "ping -c 5" # ping 5 times ‘by default’

# some utils
alias ql "qlmanage -p 2>/dev/null" # preview a file using QuickLook
