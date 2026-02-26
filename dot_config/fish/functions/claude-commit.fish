function claude-commit --description "Generate a commit message with Claude Code"
    set -l direct false
    if contains -- --direct $argv
        set direct true
    end

    # Stage all changes if nothing is staged
    if test -z "$(git diff --cached --name-only)"
        git add -A
    end

    git diff --staged | /opt/homebrew/bin/claude -p \
        "Generate a git commit message for these staged changes following the Conventional Commits spec. Format: <type>(<optional scope>): <description>. Types: feat, fix, refactor, perf, docs, style, test, build, ci, chore. Use ! before : for breaking changes. Keep the subject under 72 chars. Add a body only if the changes are complex enough to warrant explanation. Focus on WHY the change was made, not just what changed — a developer reading this in 6 months should understand the intent. Output ONLY the raw commit message, no markdown, no code blocks, no backticks." \
        --model haiku --output-format text >/tmp/commit_msg 2>/dev/null &
    set pid (jobs -lp | tail -1)

    if test "$direct" = false
        set colors "\e[38;5;105m" "\e[38;5;141m" "\e[38;5;177m" "\e[38;5;213m" "\e[38;5;177m" "\e[38;5;141m"
        while kill -0 $pid 2>/dev/null
            for c in $colors
                printf "\r%b✦\e[0m \e[1mGenerating commit message...\e[0m" "$c"
                sleep 0.12
            end
        end
        printf "\r\e[K"
    end
    wait $pid

    if test -s /tmp/commit_msg
        if test "$direct" = true
            git commit -F /tmp/commit_msg
        else
            printf "\e[32m✦ Commit message generated\e[0m\n"
            sleep 0.5
            git commit -e -F /tmp/commit_msg
        end
    else
        if test "$direct" = false
            printf "\e[31m✗ Failed to generate commit message\e[0m\n"
            sleep 1
        end
        return 1
    end
end
