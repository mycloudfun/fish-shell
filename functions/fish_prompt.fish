function fish_prompt --description 'Write out the prompt'
  # hack to disable xsel
  bind --erase \cx
  bind --erase \cv
  set -l color_cwd
  set -l suffix
  set -l pi
  if test (hostname) = "raspberrypi"
    set pi (set_color red)"π "(set_color normal)
  end
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
    set aws_profile [(set_color blue) $AWS_PROFILE (set_color normal)]" "
  end
  set -l git_branch
  set -l git_branch_raw (git branch 2> /dev/null | grep '^*' | colrm 1 2)
  if [ -n "$git_branch_raw" -a "$git_branch_raw" != "master" ]
    set git_branch "$git_branch_raw  "
  end
  set -l kubeconfig
  if test -n (echo $KUBECONFIG)
    set kubeconfig "{"(set_color green) (basename $KUBECONFIG) (set_color normal)"} "
  end
  echo -n -s $pi $git_branch $aws_profile $kubeconfig (set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "
end

