# name: Walm

function _pwd_home
  echo (command pwd | sed "s,$HOME,~,g")
end

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
  #pwd
  printf '%s ' (_pwd_home)

  # user @ host
  set_color normal
  printf '['
  set_color cyan
  printf '%s' (whoami)
  set_color normal
  printf ' @ '
  set_color green
  printf '%s' (hostname|cut -d . -f 1)
  set_color normal
  printf ']'

  # git
  if [ (_git_branch_name) ]
    set_color magenta
    printf ' [git:%s]' (_git_branch_name)
    if [ (_is_git_dirty) ]
      set_color yellow
      printf ' ✗'
    end
  end

  # Line 2
  echo
  set_color red
  printf '▪  '
  set_color normal
end

