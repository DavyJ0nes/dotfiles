if status is-interactive
    # Commands to run in interactive sessions can go here
end

source ~/.config/fish/conf.d/variables.fish
source ~/.config/fish/conf.d/paths.fish
source ~/.config/fish/conf.d/exports.fish
# source ~/.config/fish/conf.d/bindings.fish
nothelp completion fish | source
epghelper completion fish | source

direnv hook fish | source
set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
carapace _carapace | source

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/davyjones/.opam/opam-init/init.fish' && source '/Users/davyjones/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

starship init fish | source
