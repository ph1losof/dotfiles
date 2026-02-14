function '??' --description "Ask Claude a question from the terminal"
    if test (count $argv) -eq 0
        echo "Usage: ?? Your question here"
        return 1
    end
    claude -p "$argv"
end
