function ai-commit --description "Generate a commit message with AI (default: Codex CLI)"
    argparse d/direct p/provider= codex claude h/help -- $argv
    or return 1

    if set -q _flag_help
        printf "Usage: ai-commit [--direct] [--provider codex|claude] [--codex|--claude]\n"
        return 0
    end

    if set -q _flag_codex; and set -q _flag_claude
        printf "\e[31m✗ Choose either --codex or --claude, not both\e[0m\n"
        return 1
    end

    set -l direct false
    if set -q _flag_direct
        set direct true
    end

    set -l provider codex
    if set -q AI_COMMIT_PROVIDER
        set provider (string lower -- $AI_COMMIT_PROVIDER)
    end
    if set -q _flag_provider
        set provider (string lower -- $_flag_provider[1])
    end
    if set -q _flag_codex
        set provider codex
    else if set -q _flag_claude
        set provider claude
    end

    if not contains -- $provider codex claude
        printf "\e[31m✗ Invalid provider '%s'. Use codex or claude\e[0m\n" "$provider"
        return 1
    end

    if not command -q $provider
        printf "\e[31m✗ Provider command '%s' not found in PATH\e[0m\n" "$provider"
        return 1
    end

    set -l prompt "Generate a git commit message for these staged changes following the Conventional Commits spec. Format: <type>(<optional scope>): <description>. Types: feat, fix, refactor, perf, docs, style, test, build, ci, chore. Use ! before : for breaking changes. Keep the subject under 72 chars. Add a body only if the changes are complex enough to warrant explanation. Focus on WHY the change was made, not just what changed - a developer reading this in 6 months should understand the intent. Output ONLY the raw commit message, no markdown, no code blocks, no backticks."
    set -l msg_file (mktemp /tmp/commit_msg.XXXXXX)

    # Stage all changes if nothing is staged
    if test -z "$(git diff --cached --name-only)"
        git add -A
    end

    if test "$provider" = codex
        begin
            printf "%s\n\n" "$prompt"
            printf "Staged diff:\n"
            git diff --staged
        end | codex exec --output-last-message $msg_file - >/dev/null 2>/dev/null &
    else
        git diff --staged | claude -p "$prompt" --model haiku --output-format text >$msg_file 2>/dev/null &
    end
    set pid (jobs -lp | tail -1)

    if test "$direct" = false
        set colors "\e[38;5;105m" "\e[38;5;141m" "\e[38;5;177m" "\e[38;5;213m" "\e[38;5;177m" "\e[38;5;141m"
        while kill -0 $pid 2>/dev/null
            for c in $colors
                printf "\r%b✦\e[0m \e[1mGenerating commit message with %s...\e[0m" "$c" (string upper -- $provider)
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
            printf "\e[32m✦ Commit message generated with %s\e[0m\n" (string upper -- $provider)
            sleep 0.5
            git commit -e -F $msg_file
        end
        set -l commit_status $status
        rm -f $msg_file
        return $commit_status
    end

    if test "$direct" = false
        printf "\e[31m✗ Failed to generate commit message with %s\e[0m\n" (string upper -- $provider)
        sleep 1
    end
    rm -f $msg_file
    return 1
end
