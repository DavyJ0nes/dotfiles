# ~/.config/fish/functions/ai-exp-switch.fish
function ai-exp-switch --description "Switch to an existing AI experiment"
    # Handle --help flag
    if contains -- --help $argv
        echo "Usage: ai-exp-switch [search-term] [--help]"
        echo ""
        echo "Switch to an existing AI experiment in the 'ai' tmux session."
        echo ""
        echo "Arguments:"
        echo "  search-term  Optional. Filter experiments by name (partial match)"
        echo "               If omitted, shows interactive menu"
        echo ""
        echo "Options:"
        echo "  --help       Show this help message"
        echo ""
        echo "Examples:"
        echo "  ai-exp-switch                 # Shows menu of all experiments"
        echo "  ai-exp-switch endpoint        # Jumps to experiment matching 'endpoint'"
        echo "  ai-exp-switch feat_new        # Jumps to experiment matching 'feat_new'"
        echo ""
        echo "Behavior:"
        echo "  - Switches to 'ai' tmux session if not already in it"
        echo "  - Selects the matching window"
        echo "  - If multiple matches, shows first match"
        echo ""
        echo "Related commands:"
        echo "  ai-exp        Start a new experiment"
        echo "  ai-exp-list   List all experiments"
        return 0
    end

    if not tmux has-session -t ai 2>/dev/null
        echo "No 'ai' session found"
        echo "Start an experiment with: ai-exp <task-name>"
        return 1
    end

    # Get list of windows
    set -l windows (tmux list-windows -t ai -F "#{window_name}")

    if test (count $windows) -eq 0
        echo "No experiments in 'ai' session"
        return 1
    end

    # If argument provided, try to match
    if test (count $argv) -gt 0
        set -l search $argv[1]
        for win in $windows
            if string match -q "*$search*" $win
                if test -z "$TMUX"
                    tmux attach-session -t ai
                else
                    tmux switch-client -t ai
                end
                tmux select-window -t ai:$win
                return 0
            end
        end
        echo "No window matching '$search' found"
        echo "Available experiments:"
        for win in $windows
            echo "  - $win"
        end
        return 1
    end

    # Otherwise, show list
    echo "Active AI experiments:"
    for i in (seq (count $windows))
        echo "  $i) $windows[$i]"
    end

    read -l -P "Select experiment (1-"(count $windows)"): " choice

    if test -n "$choice" -a "$choice" -ge 1 -a "$choice" -le (count $windows)
        set -l window $windows[$choice]
        if test -z "$TMUX"
            tmux attach-session -t ai
        else
            tmux switch-client -t ai
        end
        tmux select-window -t ai:$window
    else
        echo "Invalid choice"
        return 1
    end
end
