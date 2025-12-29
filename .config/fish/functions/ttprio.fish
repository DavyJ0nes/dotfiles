function ttprio -d "Set Taskwarrior today_order (manual ordering for Today report)"
    if test (count $argv) -ne 2
        echo "Usage: ttrprio <id> <order>" >&2
        return 1
    end

    set -l id $argv[1]
    set -l ord $argv[2]

    if not string match -qr '^[0-9]+$' -- $id
        echo "ttrprio: <id> must be a number (got '$id')" >&2
        return 1
    end

    if not string match -qr '^-?[0-9]+$' -- $ord
        echo "ttrprio: <order> must be an integer (got '$ord')" >&2
        return 1
    end

    command task $id modify todayorder:$ord
end
