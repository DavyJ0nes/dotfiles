function whoseport
    if test (count $argv) -ne 1
        echo "Usage: whoseport PORT"
        return 1
    end

    set port $argv[1]

    # Prefer lsof if available (common on macOS & Linux)
    if type -q lsof
        # TCP listeners
        echo "== TCP =="
        sudo lsof -nP -iTCP:$port -sTCP:LISTEN 2>/dev/null

        # UDP (no LISTEN state)
        echo "== UDP =="
        sudo lsof -nP -iUDP:$port 2>/dev/null

    # Fallback to ss if lsof isn't available
    else if type -q ss
        echo "== TCP/UDP =="
        ss -lntup "( sport = :$port )"

    # Fallback to netstat as a last resort
    else if type -q netstat
        echo "== Matches in netstat =="
        netstat -tunlp 2>/dev/null | grep ":$port "
    else
        echo "No suitable tool found (need lsof, ss, or netstat)."
        return 1
    end
end
