function update -d "update brew, fish, fisher, gh and mac app store"
    echo 'start updating ...'

    echo "========================"
    set TO_UPDATE $(brew outdated -v)

    echo 'updating homebrew'
    brew update
    brew upgrade --greedy
    brew cleanup --prune=all

    echo "========================"
    echo 'updating fish shell'
    fisher update
    fish_update_completions

    echo "========================"
    echo 'updating GH extensions'
    gh extension upgrade --all

    echo "========================"
    echo 'checking Apple Updates'
    /usr/sbin/softwareupdate -ia

    echo "========================"
    echo "updated brew packages:"
    echo -e "$TO_UPDATE"
end
