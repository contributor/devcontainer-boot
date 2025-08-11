gh-issue-do ISSUE_NUMBER:
    gh issue view {{ISSUE_NUMBER}}

gh-pr-create:
    git push
    gh pr create --fill

gh-pr-check-code-review:
    pr-comment-processor

gh-pr-status *ARGS:
    @gh pr view --json url,comments --jq '.url, .comments[-1].body'
    @pr-comment-processor --list {{ARGS}}

alias pr := gh-pr-status

gh-pr-mark-comment-processed COMMENT_URL:
    pr-comment-processor --mark-processed {{COMMENT_URL}}

gh-pr-comment-reply PR_ID FILE='.gemini/tmp_reply_text.txt':
    gh pr comment {{PR_ID}} --body-file {{FILE}}

gh-pr-comment-triage *ARGS:
    pr-comment-processor --triage {{ARGS}}
alias pr-triage := gh-pr-comment-triage

# Watch for new comments on a pull request
# Usage: just gh-pr-watch-comments https://github.com/owner/repo/pull/123
gh-pr-watch-comments PR_URL = "":
    #!/usr/bin/env bash
    set -euo pipefail

    LAST_COUNT=$(gh pr view {{PR_URL}} --json comments --jq '.comments | length' 2>/dev/null || echo 0)

    while true; do
        COMMENTS_JSON=$(gh pr view {{PR_URL}} --json comments --jq '.comments' || echo "[]")
        NEW_COUNT=$(echo "$COMMENTS_JSON" | jq '. | length')

        if [[ "$NEW_COUNT" -gt "$LAST_COUNT" ]]; then
            echo "🔔 New comment(s) detected:"
            echo "$COMMENTS_JSON" | jq -r --argjson slice_start "$LAST_COUNT" '.[$slice_start:] | .[] | .body'
            powershell -c '[console]::beep(210, 300)'
            LAST_COUNT="$NEW_COUNT"
        fi

        sleep 10
    done

alias pr-watch := gh-pr-watch-comments

find-commits-with-comments *ARGS:
    GITHUB_TOKEN=$(gh auth token) find-commits-with-comments {{ARGS}}
