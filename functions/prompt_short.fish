function prompt_short
    set -q fish_prompt_pwd_dir_length
    or set -l fish_prompt_pwd_dir_length 1
    set realhome ~
    set -l tmp (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)

    if [ $fish_prompt_pwd_dir_length -eq 0 ]
        echo $tmp
    else
        echo (pwd)
    end
end
