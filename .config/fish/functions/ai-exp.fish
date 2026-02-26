# ~/.config/fish/functions/ai-exp.fish
function ai-exp --description "Start AI experiment in worktree"
    # Handle --help flag
    if contains -- --help $argv
        echo "Usage: ai-exp <task-name> [ai-tool] [--help]"
        echo ""
        echo "Start an AI-assisted coding experiment in an isolated git worktree."
        echo ""
        echo "Arguments:"
        echo "  task-name    Name for the experiment/branch (e.g., feat/new-endpoint)"
        echo "               Special chars like / will be converted to _ for directory names"
        echo "  ai-tool      AI tool to use: claude, codex, or gemini (default: claude)"
        echo ""
        echo "Options:"
        echo "  --help       Show this help message"
        echo ""
        echo "Examples:"
        echo "  ai-exp feat/new-endpoint           # Uses claude by default"
        echo "  ai-exp bug-fix codex               # Uses codex for this experiment"
        echo "  ai-exp refactor/auth gemini        # Uses gemini"
        echo ""
        echo "Behavior:"
        echo "  - Creates a git worktree in .worktrees/<repo>/<sanitized-task-name>"
        echo "  - Creates/attaches to tmux session named 'ai'"
        echo "  - Sets up split panes: AI chat (left) and nvim (right)"
        echo "  - Branch name: ai-exp/<task-name>"
        echo ""
        echo "Related commands:"
        echo "  ai-exp-list       List all active experiments"
        echo "  ai-exp-switch     Switch between experiments"
        echo "  ai-exp-clean      Clean up experiment worktrees"
        return 0
    end

    set -l task_name $argv[1]
    set -l ai_tool $argv[2] # claude, codex, gemini

    if test -z "$task_name"
        echo "Usage: ai-exp <task-name> [ai-tool]"
        echo "Try 'ai-exp --help' for more information"
        return 1
    end

    set -l ai_tool (test -z "$ai_tool"; and echo "claude"; or echo $ai_tool)

    # Get current repo name
    set -l repo_name (basename (git rev-parse --show-toplevel))

    # Sanitize branch name: feat/ai/do-thing -> feat_ai_do-thing
    set -l sanitized_task (string replace -a / _ $task_name)
    set -l branch "ai-exp/$task_name"

    # Find the parent directory containing repos (e.g., ~/go/src/github.com/org)
    set -l repo_root (git rev-parse --show-toplevel)
    set -l parent_dir (dirname $repo_root)

    # Create .worktrees structure
    set -l worktrees_base "$parent_dir/.worktrees"
    set -l worktree_path "$worktrees_base/$repo_name/$sanitized_task"

    # Create .worktrees directory if it doesn't exist
    mkdir -p "$worktrees_base/$repo_name"

    # Create worktree
    if test -d "$worktree_path"
        echo "Worktree already exists at $worktree_path"
        set -l existing_branch (git -C $worktree_path branch --show-current)
        read -l -P "Use existing worktree with branch '$existing_branch'? [Y/n] " confirm
        if test "$confirm" = n
            return 1
        end
    else
        echo "Creating worktree: $worktree_path"
        git worktree add $worktree_path -b $branch
    end

    # Create or attach to 'ai' session
    if not tmux has-session -t ai 2>/dev/null
        tmux new-session -d -s ai -n $sanitized_task -c $worktree_path
    else
        # Check if window already exists
        if tmux list-windows -t ai -F "#{window_name}" | grep -q "^$sanitized_task\$"
            echo "Window '$sanitized_task' already exists in ai session"
            if test -z "$TMUX"
                tmux attach-session -t ai
            else
                tmux switch-client -t ai
            end
            tmux select-window -t ai:$sanitized_task
            return 0
        end
        tmux new-window -t ai -n $sanitized_task -c $worktree_path
    end

    # Setup panes (capture pane ids to avoid base-index assumptions)
    set -l left_pane (tmux display-message -t ai:$sanitized_task -p "#{pane_id}")
    set -l right_pane (tmux split-window -h -t ai:$sanitized_task -c $worktree_path -P -F "#{pane_id}")

    # Right pane: nvim
    tmux send-keys -t $right_pane "nvim" C-m

    # Attach or switch
    if test -z "$TMUX"
        # Run AI tool after attaching (non-neovim pane) and clear the hook.
        tmux set-hook -t ai client-attached "run-shell 'tmux send-keys -t $left_pane \"cd $worktree_path\" C-m; tmux send-keys -t $left_pane \"$ai_tool\" C-m; tmux select-pane -t $left_pane; tmux set-hook -t ai client-attached \"\"'"
        tmux attach-session -t ai
    else
        tmux switch-client -t ai
        tmux send-keys -t $left_pane "cd $worktree_path" C-m
        sleep 0.2  # Small delay to ensure cd completes
        tmux send-keys -t $left_pane "$ai_tool" C-m
        tmux select-pane -t $left_pane
    end
end
