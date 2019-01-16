function fish_prompt --description 'Write out the prompt'
  # hack to disable xsel
  bind --erase \cx
  bind --erase \cv
  set -l color_cwd
  set -l suffix
  switch $USER
    case root toor
      if set -q fish_color_cwd_root
         set color_cwd $fish_color_cwd_root
      else
         set color_cwd $fish_color_cwd
      end
      set suffix '#'
    case '*'
      set color_cwd $fish_color_cwd
      set suffix '>'
  end
  set -l aws_profile
  if test -n (echo $AWS_PROFILE)
    set aws_profile "[aws-profile "(set_color blue) $AWS_PROFILE (set_color normal)]" "
  end
  set -l git_branch
  set -l git_branch_raw (git branch 2> /dev/null | grep '^*' | colrm 1 2)
  if [ -n "$git_branch_raw" -a "$git_branch_raw" != "master" ]
    set git_branch "$git_branch_raw  "
  end
  set -l kubeconfig
  if test -n (echo $KUBECONFIG)
    set kubeconfig "{kubeconfig "(set_color red) (basename $KUBECONFIG) (set_color normal)"} "
  end
  echo -n -s $git_branch $aws_profile $kubeconfig (set_color $color_cwd) (set_color normal) (pwd)"$suffix "
end

