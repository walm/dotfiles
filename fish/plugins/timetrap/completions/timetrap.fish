# fish completion for rake
function __fish_timetrap_sheets
  t s ^/dev/null | awk '{print $1"\t"}' | sed -e "s/*//"
end

# check if using sub option
function __fish_timetrap_using_opt
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    switch $cmd[2]
      case $argv[1]
        return 0
      case $argv[2]
        return 0
    end
  end
  return 1
end

### commands

complete -c t -f -a sheet   -n '__fish_is_first_token' -d "Switch to a timesheet creating it if necessary"
complete -c t -f -a display -n '__fish_is_first_token' -d "Display the current timesheet or a specific"
complete -c t -f -a today   -n '__fish_is_first_token' -d "Display with start date as the current day"
complete -c t -f -a week    -n '__fish_is_first_token' -d "Display with start date set to monday of this week"
complete -c t -f -a month   -n '__fish_is_first_token' -d "Display with start date set to the beginning this month"
complete -c t -f -a in      -n '__fish_is_first_token' -d "Start the timer for the current timesheet"
complete -c t -f -a resume  -n '__fish_is_first_token' -d "Resume last timer for the current time sheet"
complete -c t -f -a out     -n '__fish_is_first_token' -d "Stop the timer for the a timesheet"
complete -c t -f -a now     -n '__fish_is_first_token' -d "Show all running entries"
complete -c t -f -a edit    -n '__fish_is_first_token' -d "Alter an entry note, start, or end time"

# display sub options
complete -c t -f -n '__fish_timetrap_using_opt display d' -a 'all' -d 'Display for all sheets'
complete -c t -f -n '__fish_timetrap_using_opt display d' -s 'v' -l 'ids' -d 'Show entry ID'

# today sub options
complete -c t -f -n '__fish_timetrap_using_opt today t' -a 'all' -d 'Display for all sheets'
complete -c t -f -n '__fish_timetrap_using_opt today t' -s 'v' -l 'ids' -d 'Show entry ID'

# week sub options
complete -c t -f -n '__fish_timetrap_using_opt week w' -a 'all' -d 'Display for all sheets'
complete -c t -f -n '__fish_timetrap_using_opt week w' -s 'v' -l 'ids' -d 'Show entry ID'

# month sub options
complete -c t -f -n '__fish_timetrap_using_opt month m' -a 'all' -d 'Display for all sheets'
complete -c t -f -n '__fish_timetrap_using_opt month m' -s 'v' -l 'ids' -d 'Show entry ID'

# sheets sub options
complete -c t -f -n '__fish_timetrap_using_opt sheet s' -a '(__fish_timetrap_sheets)'

# in/resume sub options
complete -c t -f -n '__fish_timetrap_using_opt in i' -s 'a' -l 'at' -d 'Use this time insted of now'
complete -c t -f -n '__fish_timetrap_using_opt resume r' -s 'a' -l 'at' -d 'Use this time insted of now'

# out sub options
complete -c t -f -n '__fish_timetrap_using_opt out o' -s 'a' -l 'at' -d 'Use this time insted of now'

# edit sub options
complete -c t -f -n '__fish_timetrap_using_opt edit e' -s 'i' -l 'id'     -d 'Entry ID'
complete -c t -f -n '__fish_timetrap_using_opt edit e' -s 's' -l 'start'  -d 'Change start time'
complete -c t -f -n '__fish_timetrap_using_opt edit e' -s 'e' -l 'end'    -d 'Change end time'
complete -c t -f -n '__fish_timetrap_using_opt edit e' -s 'm' -l 'move'   -d 'Move to another sheet'
complete -c t -f -n '__fish_timetrap_using_opt edit e' -s 'z' -l 'append' -d 'Append to current note'

