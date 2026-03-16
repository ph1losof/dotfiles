function "??" --description "Ask AI a question from the terminal"
    if test (count $argv) -eq 0
        echo "Usage: ?? Your question here"
        return 1
    end

    if not command -q codex
        echo "codex command not found in PATH"
        return 1
    end

    set -l prompt (string join " " -- $argv)
    set -l msg_file (mktemp /tmp/ask_ai_msg.XXXXXX)
    set -l raw_file (mktemp /tmp/ask_ai_raw.XXXXXX)

    codex exec --skip-git-repo-check --output-last-message $msg_file "$prompt" >$raw_file 2>/dev/null
    set -l codex_status $status

    if test -s $msg_file
        cat $msg_file
    else if test $codex_status -ne 0
        echo "Failed to get response from Codex"
    end

    set -l tokens (awk 'BEGIN{found=0} /^tokens used[[:space:]]*$/ {found=1; next} found {gsub(/^[[:space:]]+|[[:space:]]+$/, "", $0); if (length($0)>0) {print $0; exit}}' $raw_file)
    if test -n "$tokens"
        echo
        echo "tokens used"
        echo $tokens
    end

    rm -f $msg_file $raw_file
    return $codex_status
end
