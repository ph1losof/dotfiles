function "??" --description "Ask AI a question from the terminal"
    if test (count $argv) -eq 0
        echo "Usage: ?? Your question here"
        return 1
    end

    if not command -q opencode
        echo "opencode command not found in PATH"
        return 1
    end

    if not command -q jq
        echo "jq command not found in PATH"
        return 1
    end

    set -l prompt (string join " " -- $argv)
    set -l opencode_model openai/gpt-5.4-fast
    if set -q OPENCODE_ASK_MODEL
        set opencode_model $OPENCODE_ASK_MODEL
    else if set -q OPENCODE_MODEL
        set opencode_model $OPENCODE_MODEL
    end
    set -l raw_file (mktemp /tmp/ask_ai_raw.XXXXXX)
    set -l opencode_config '{"mcp":{"context7":{"enabled":false}},"agent":{"quick-chat":{"mode":"primary","permission":"deny","tools":{"question":false,"bash":false,"read":false,"glob":false,"grep":false,"edit":false,"write":false,"task":false,"webfetch":false,"todowrite":false,"skill":false},"prompt":"Direct terminal Q&A mode. Never call tools. If live data is requested, say you cannot fetch live data and give a short best-effort answer. Never mention internal step limits or agent state."}}}'

    env OPENCODE_CONFIG_CONTENT="$opencode_config" opencode run --format json --agent quick-chat --model $opencode_model --variant minimal --dir /tmp "$prompt" >$raw_file 2>/dev/null
    set -l opencode_status $status
    set -l response (jq -rs -r 'map(select(.type == "text") | .part.text) | join("")' $raw_file 2>/dev/null)

    if test -n "$response"
        printf "%s\n" "$response"
    else if test $opencode_status -ne 0
        echo "Failed to get response from OpenCode"
    end

    set -l tokens (jq -rs -r 'map(select(.type == "step_finish") | .part.tokens.total) | last // empty' $raw_file 2>/dev/null)
    if test -n "$tokens"
        echo
        echo "tokens used"
        echo $tokens
    end

    rm -f $raw_file
    return $opencode_status
end
