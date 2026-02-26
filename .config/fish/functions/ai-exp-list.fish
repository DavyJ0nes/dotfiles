# ~/.config/fish/functions/ai-exp-list.fish
function ai-exp-list --description "List all AI experiment worktrees"
    # Handle --help flag
    if contains -- --help $argv
        echo "Usage: ai-exp-list [--help]"
        echo ""
        echo "List all active AI experiment worktrees across all repositories."
        echo ""
        echo "Options:"
        echo "  --help       Show this help message"
        echo ""
        echo "Output format:"
        echo "  ✓ repo/task -> branch-name    (has active tmux window)"
        echo "    repo/task -> branch-name    (no tmux window)"
        echo ""
        echo "Examples:"
        echo "  ai-exp-list                   # Show all experiments"
        echo ""
        echo "Related commands:"
        echo "  ai-exp        Start a new experiment"
        echo "  ai-exp-switch Switch to an existing experiment"
        echo "  ai-exp-clean  Clean up experiments"
        return 0
    end

    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$repo_root"
        echo "Error: Not in a git repository"
        return 1
    end

    set -l parent_dir (dirname $repo_root)
    set -l worktrees_base "$parent_dir/.worktrees"

    if not test -d "$worktrees_base"
        echo "No AI experiments found"
        return 0
    end

    echo "Active AI Experiments:"
    echo "====================="

    git worktree list | grep "\.worktrees" | while read -l line
        set -l path (echo $line | awk '{print $1}')
        set -l branch (git -C $path branch --show-current)
        set -l repo (basename (dirname $path))
        set -l task (basename $path)

        # Check if there's a tmux window for this
        set -l has_window ""
        if tmux has-session -t ai 2>/dev/null
            if tmux list-windows -t ai -F "#{window_name}" | grep -q "^$task\$"
                set has_window "✓"
            end
        end

        echo "$has_window $repo/$task -> $branch"
    end
end
