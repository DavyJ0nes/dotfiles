# ~/.config/fish/functions/ai-exp-clean.fish
function ai-exp-clean --description "Clean up AI experiment worktrees"
    # Handle --help flag
    if contains -- --help $argv
        echo "Usage: ai-exp-clean [--help]"
        echo ""
        echo "Clean up AI experiment worktrees and their associated git branches."
        echo ""
        echo "Options:"
        echo "  --help       Show this help message"
        echo ""
        echo "Cleanup modes:"
        echo "  all          Remove all experiment worktrees in .worktrees/"
        echo "  current      Remove only worktrees for the current repository"
        echo "  select       Interactively choose which worktrees to remove"
        echo "  cancel       Exit without making changes"
        echo ""
        echo "Examples:"
        echo "  ai-exp-clean                  # Interactive mode"
        echo ""
        echo "Warning:"
        echo "  This command will:"
        echo "  - Remove worktree directories"
        echo "  - Delete associated git branches (ai-exp/*)"
        echo "  - Clean up empty directories"
        echo ""
        echo "  Make sure you've committed or stashed any changes first!"
        echo ""
        echo "Related commands:"
        echo "  ai-exp-list   See what will be cleaned"
        echo "  git worktree list   See all worktrees"
        return 0
    end

    # Find the parent directory containing repos
    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$repo_root"
        echo "Error: Not in a git repository"
        return 1
    end

    set -l parent_dir (dirname $repo_root)
    set -l worktrees_base "$parent_dir/.worktrees"

    if not test -d "$worktrees_base"
        echo "No .worktrees directory found"
        return 0
    end

    echo "AI Experiment Worktrees:"
    git worktree list | grep "\.worktrees"

    echo ""
    read -l -P "Remove which worktrees? [all/current/select/cancel] " choice

    switch $choice
        case all
            # Remove all worktrees under .worktrees
            git worktree list | grep "\.worktrees" | awk '{print $1}' | while read -l path
                set -l branch (git -C $path branch --show-current)
                set -l window_name (basename $path)
                echo "Removing: $path (branch: $branch)"
                if tmux has-session -t ai 2>/dev/null
                    tmux kill-window -t ai:$window_name 2>/dev/null
                end
                git worktree remove $path
                git branch -D $branch 2>/dev/null
            end
            # Clean up empty directories
            find $worktrees_base -type d -empty -delete
            echo "Cleaned up all AI experiment worktrees"

        case current
            # Remove current repo's worktrees only
            set -l repo_name (basename (git rev-parse --show-toplevel))
            set -l repo_worktrees "$worktrees_base/$repo_name"

            if test -d "$repo_worktrees"
                git worktree list | grep "$repo_worktrees" | awk '{print $1}' | while read -l path
                    set -l branch (git -C $path branch --show-current)
                    set -l window_name (basename $path)
                    echo "Removing: $path (branch: $branch)"
                    if tmux has-session -t ai 2>/dev/null
                        tmux kill-window -t ai:$window_name 2>/dev/null
                    end
                    git worktree remove $path
                    git branch -D $branch 2>/dev/null
                end
                rmdir $repo_worktrees 2>/dev/null
                echo "Cleaned up worktrees for $repo_name"
            else
                echo "No worktrees found for $repo_name"
            end

        case select
            # Interactive selection
            set -l worktrees (git worktree list | grep "\.worktrees" | awk '{print $1}')
            for path in $worktrees
                set -l branch (git -C $path branch --show-current)
                set -l window_name (basename $path)
                read -l -P "Remove $path (branch: $branch)? [y/N] " confirm
                if test "$confirm" = y
                    if tmux has-session -t ai 2>/dev/null
                        tmux kill-window -t ai:$window_name 2>/dev/null
                    end
                    git worktree remove $path
                    git branch -D $branch 2>/dev/null
                    echo "Removed: $path"
                end
            end
            find $worktrees_base -type d -empty -delete

        case cancel
            echo "Cancelled"
            return 0

        case '*'
            echo "Invalid choice. Use: all, current, select, or cancel"
            return 1
    end
end
