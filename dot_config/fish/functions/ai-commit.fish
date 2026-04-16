function ai-commit --description "Generate a commit message with OpenCode"
    argparse d/direct h/help -- $argv
    or return 1

    if set -q _flag_help
        printf "Usage: ai-commit [--direct]\n"
        return 0
    end

    set -l direct false
    if set -q _flag_direct
        set direct true
    end

    if not command -q opencode
        printf "\e[31m✗ OpenCode command not found in PATH\e[0m\n"
        return 1
    end

    if not command -q jq
        printf "\e[31m✗ 'jq' is required for OpenCode mode\e[0m\n"
        return 1
    end

    set -l prompt "Generate a git commit message for these staged changes following the Conventional Commits spec. Format: <type>(<optional scope>): <description>. Types: feat, fix, refactor, perf, docs, style, test, build, ci, chore. Use ! before : for breaking changes. Keep the subject under 72 chars. Add a body only if the changes are complex enough to warrant explanation. Focus on WHY the change was made, not just what changed - a developer reading this in 6 months should understand the intent. Output ONLY the raw commit message, no markdown, no code blocks, no backticks."
    set -l msg_file (mktemp /tmp/commit_msg.XXXXXX)
    set -l diff_file (mktemp /tmp/commit_diff.XXXXXX)
    set -l opencode_model openai/gpt-5.3-codex-spark
    if set -q OPENCODE_COMMIT_MODEL
        set opencode_model $OPENCODE_COMMIT_MODEL
    else if set -q OPENCODE_MODEL
        set opencode_model $OPENCODE_MODEL
    end
    set -l opencode_config '{"mcp":{"context7":{"enabled":false}},"agent":{"quick-commit":{"mode":"primary","permission":"deny","tools":{"question":false,"bash":false,"read":false,"glob":false,"grep":false,"edit":false,"write":false,"task":false,"webfetch":false,"todowrite":false,"skill":false},"prompt":"You write Conventional Commit messages from a provided staged diff. Never call tools. Return only the raw commit message."}}}'

    # Stage all changes if nothing is staged
    if test -z "$(git diff --cached --name-only)"
        git add -A
    end

    git diff --staged >$diff_file

    set -l opencode_prompt "$prompt Use the attached file as the complete staged diff."
    env OPENCODE_CONFIG_CONTENT="$opencode_config" opencode run --format json --agent quick-commit --model $opencode_model --variant minimal --dir /tmp "$opencode_prompt" --file $diff_file 2>/dev/null | jq -rs -r '([ .[] | select(.type == "text" and (.part.metadata.openai.phase? == "final_answer")) | .part.text ] | last) // ([ .[] | select(.type == "text") | .part.text ] | last) // empty' >$msg_file &
    set pid (jobs -lp | tail -1)

    if test "$direct" = false
        set colors "\e[38;5;105m" "\e[38;5;141m" "\e[38;5;177m" "\e[38;5;213m" "\e[38;5;177m" "\e[38;5;141m"
        while kill -0 $pid 2>/dev/null
            for c in $colors
                printf "\r%b✦\e[0m \e[1mGenerating commit message with OPENCODE...\e[0m" "$c"
                sleep 0.12
            end
        end
        printf "\r\e[K"
    end

    wait $pid
    set -l generation_status $status

    if test $generation_status -eq 0; and test -s $msg_file
        if test "$direct" = true
            git commit -F $msg_file
        else
            printf "\e[32m✦ Commit message generated with OPENCODE\e[0m\n"
            sleep 0.5
            git commit -e -F $msg_file
        end
        set -l commit_status $status
        rm -f $msg_file $diff_file
        return $commit_status
    end

    if test "$direct" = false
        printf "\e[31m✗ Failed to generate commit message with OPENCODE\e[0m\n"
        sleep 1
    end
    rm -f $msg_file $diff_file
    return 1
end
