# ~/.config/fish/functions/ai-review.fish
function ai-review --description "Review a branch in worktree with AI assistance"
    # Handle --help flag
    if contains -- --help $argv
        echo "Usage: ai-review <branch-or-pr> [ai-tool] [--help]"
        echo ""
        echo "Review a colleague's branch with AI assistance in an isolated worktree."
        echo ""
        echo "Arguments:"
        echo "  branch-or-pr Branch name, remote branch, or PR number"
        echo "               Examples: feature/new-api, origin/bugfix, PR-123"
        echo "  ai-tool      AI tool to use: claude, codex, or gemini (default: claude)"
        echo ""
        echo "Options:"
        echo "  --help       Show this help message"
        echo ""
        echo "Examples:"
        echo "  ai-review feature/new-endpoint        # Review a branch"
        echo "  ai-review origin/colleague-branch     # Review remote branch"
        echo "  ai-review PR-123                      # Review a GitHub PR"
        echo "  ai-review bugfix codex                # Use codex for review"
        echo ""
        echo "Behavior:"
        echo "  - Fetches latest changes from remote"
        echo "  - Creates worktree in .worktrees/<repo>/review_<branch>"
        echo "  - Sets up tmux session 'ai' with review window"
        echo "  - Left pane: AI chat with review context"
        echo "  - Right pane: Shell in worktree for navigation"
        echo "  - AI receives full diff and file list for context"
        echo ""
        echo "Related commands:"
        echo "  ai-exp        Start an experiment"
        echo "  ai-exp-clean  Clean up worktrees"
        return 0
    end

    set -l branch_or_pr $argv[1]
    set -l ai_tool $argv[2]

    if test -z "$branch_or_pr"
        echo "Usage: ai-review <branch-or-pr> [ai-tool]"
        echo "Try 'ai-review --help' for more information"
        return 1
    end

    set -l ai_tool (test -z "$ai_tool"; and echo "claude"; or echo $ai_tool)

    # Fetch latest changes
    echo "Fetching latest changes..."
    git fetch --all

    # Determine branch name
    set -l branch_name
    if string match -qr "^PR-[0-9]+" $branch_or_pr
        # Handle PR number - requires gh cli
        set -l pr_num (string replace "PR-" "" $branch_or_pr)
        if not command -v gh >/dev/null
            echo "Error: 'gh' CLI required for PR reviews"
            echo "Install with: brew install gh"
            return 1
        end
        set branch_name (gh pr view $pr_num --json headRefName -q .headRefName)
        if test -z "$branch_name"
            echo "Error: Could not find PR #$pr_num"
            return 1
        end
        echo "Reviewing PR #$pr_num: $branch_name"
    else
        set branch_name $branch_or_pr
    end

    # Get current repo name
    set -l repo_name (basename (git rev-parse --show-toplevel))

    # Sanitize branch name for directory
    set -l sanitized_branch (string replace -a / _ $branch_name)
    set -l sanitized_branch (string replace -a origin_ "" $sanitized_branch)

    # Find parent directory
    set -l repo_root (git rev-parse --show-toplevel)
    set -l parent_dir (dirname $repo_root)

    # Create .worktrees structure
    set -l worktrees_base "$parent_dir/.worktrees"
    set -l worktree_path "$worktrees_base/$repo_name/review_$sanitized_branch"

    # Create .worktrees directory
    mkdir -p "$worktrees_base/$repo_name"

    # Create worktree
    if test -d "$worktree_path"
        echo "Review worktree already exists at $worktree_path"
        read -l -P "Use existing worktree? [Y/n] " confirm
        if test "$confirm" = n
            return 1
        end
    else
        echo "Creating review worktree: $worktree_path"
        # Use --detach for remote branches
        if string match -q "origin/*" $branch_name
            git worktree add $worktree_path $branch_name
        else
            git worktree add $worktree_path -b review-$sanitized_branch $branch_name
        end
    end

    # Generate diff and context
    set -l base_branch (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    set -l diff_file "$worktree_path/.ai-review-diff.txt"
    set -l context_file "$worktree_path/.ai-review-context.md"

    echo "Generating review context..."

    # Create diff
    git -C $worktree_path diff $base_branch..HEAD > $diff_file

    # Create context file
    echo "# Code Review Context" > $context_file
    echo "" >> $context_file
    echo "**Branch:** $branch_name" >> $context_file
    echo "**Base:** $base_branch" >> $context_file
    echo "**Repo:** $repo_name" >> $context_file
    echo "" >> $context_file

    # Add commit messages
    echo "## Recent Commits" >> $context_file
    git -C $worktree_path log $base_branch..HEAD --pretty=format:"- %h %s (%an)" >> $context_file
    echo "" >> $context_file
    echo "" >> $context_file

    # Add files changed
    echo "## Files Changed" >> $context_file
    git -C $worktree_path diff --name-status $base_branch..HEAD >> $context_file
    echo "" >> $context_file
    echo "" >> $context_file

    # Add stats
    echo "## Stats" >> $context_file
    git -C $worktree_path diff --stat $base_branch..HEAD >> $context_file
    echo "" >> $context_file

    # Prepare AI prompt
    set -l review_prompt "$worktree_path/.ai-review-prompt.md"
    echo "# Code Review Instructions" > $review_prompt
    echo "" >> $review_prompt
    echo "Please review this code change. Focus on:" >> $review_prompt
    echo "" >> $review_prompt
    echo "1. **Bugs & Logic Errors**: Potential bugs, edge cases, logic errors" >> $review_prompt
    echo "2. **Security**: Security vulnerabilities, input validation, data exposure" >> $review_prompt
    echo "3. **Performance**: Inefficient algorithms, unnecessary queries, memory leaks" >> $review_prompt
    echo "4. **Code Quality**: Readability, maintainability, Go/Elixir best practices" >> $review_prompt
    echo "5. **Tests**: Missing test coverage, test quality" >> $review_prompt
    echo "6. **Questions**: Things that need clarification from the author" >> $review_prompt
    echo "" >> $review_prompt
    echo "The diff is in: .ai-review-diff.txt" >> $review_prompt
    echo "Context is in: .ai-review-context.md" >> $review_prompt
    echo "" >> $review_prompt
    echo "Please provide:" >> $review_prompt
    echo "- Critical issues (must fix)" >> $review_prompt
    echo "- Suggestions (nice to have)" >> $review_prompt
    echo "- Questions for the author" >> $review_prompt
    echo "- Overall assessment" >> $review_prompt

    # Create initial prompt that will be sent to AI
    set -l initial_prompt "$worktree_path/.ai-initial-prompt.txt"
    echo "I need you to review this code change. First, read the review instructions and context:" > $initial_prompt
    echo "" >> $initial_prompt
    cat $review_prompt >> $initial_prompt
    echo "" >> $initial_prompt
    echo "---" >> $initial_prompt
    echo "" >> $initial_prompt
    cat $context_file >> $initial_prompt
    echo "" >> $initial_prompt
    echo "Now please review the diff in .ai-review-diff.txt and provide your analysis." >> $initial_prompt

    # Create or attach to 'ai' session
    set -l window_name "review_$sanitized_branch"

    if not tmux has-session -t ai 2>/dev/null
        tmux new-session -d -s ai -n $window_name -c $worktree_path
    else
        if tmux list-windows -t ai -F "#{window_name}" | grep -q "^$window_name\$"
            echo "Window '$window_name' already exists in ai session"
            if test -z "$TMUX"
                tmux attach-session -t ai
            else
                tmux switch-client -t ai
            end
            tmux select-window -t ai:$window_name
            return 0
        end
        tmux new-window -t ai -n $window_name -c $worktree_path
    end

    # Setup panes (capture pane ids to avoid base-index assumptions)
    set -l left_pane (tmux display-message -t ai:$window_name -p "#{pane_id}")
    set -l right_pane (tmux split-window -h -t ai:$window_name -c $worktree_path -P -F "#{pane_id}")

    # Print helpful info
    echo ""
    echo "Review environment ready!"
    echo "========================="
    echo "Worktree: $worktree_path"
    echo "Base branch: $base_branch"
    echo "Reviewing: $branch_name"
    echo ""
    echo "Files created:"
    echo "  .ai-review-diff.txt     - Full diff"
    echo "  .ai-review-context.md   - Commits, files, stats"
    echo "  .ai-review-prompt.md    - Review instructions"
    echo ""
    echo "AI will receive the context automatically on startup."
    echo ""

    # Attach or switch
    if test -z "$TMUX"
        # Run AI tool after attaching with the initial prompt
        tmux set-hook -t ai client-attached "run-shell 'tmux send-keys -t $left_pane \"cd $worktree_path\" C-m; sleep 0.3; tmux send-keys -t $left_pane \"cat .ai-initial-prompt.txt | $ai_tool\" C-m; tmux select-pane -t $left_pane; tmux set-hook -t ai client-attached \"\"'"
        tmux attach-session -t ai
    else
        tmux switch-client -t ai
        tmux send-keys -t $left_pane "cd $worktree_path" C-m
        sleep 0.3  # Ensure cd completes
        tmux send-keys -t $left_pane "cat .ai-initial-prompt.txt | $ai_tool" C-m
        tmux select-pane -t $left_pane
    end
end
