# ~/.config/fish/functions/ai-chat-claude.fish
function ai-chat-claude --description "Claude CLI with tmux notifications"
    # Set pane title
    printf '\033]2;AI: Claude\033\\'

    # Enable tmux monitoring for this pane
    # Will trigger bell when pane is idle (no output)
    tmux set-window-option -t $TMUX_PANE monitor-silence 3  # 3 seconds of silence
    tmux set-window-option -t $TMUX_PANE monitor-activity on

    # Start claude
    claude

    # Cleanup
    tmux set-window-option -t $TMUX_PANE monitor-silence 0
    printf '\033]2;AI: Closed\033\\'
end
