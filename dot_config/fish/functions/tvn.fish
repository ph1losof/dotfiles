function tvn --description "Find files with television and open in neovim"
    set -l selected (tv $argv)
    if test $status -ne 0 -o -z "$selected"
        return 0
    end
    nvim $selected
end
