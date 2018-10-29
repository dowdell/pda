# name: ndowde
# ---------------
# Based on clearance Display the following bits on the left:
# - Virtualenv name (if applicable, see https://github.com/adambrenecki/virtualfish)
# - Current directory name

function fish_prompt
  set -l last_status $status
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)
  set -l cwd $blue(pwd | sed "s:^$HOME:~:")

  # Add a newline before new prompts
  echo -e ''

  # Display [venvname] if in a virtualenv
  if set -q VIRTUAL_ENV
      echo -n -s (set_color -b cyan black) '[' (basename "$VIRTUAL_ENV") ']' $normal ' '
  end

  set -l prompt_color $red
  if test $last_status = 0
    set prompt_color $normal
  end

  echo -n -s 'ⱶ '
  set prompt_color $normal

 # Print pwd or full path
  echo -n -s $cwd $normal

  # Terminate with a nice prompt char
  echo -e -n -s $prompt_color '  ' $normal
end
