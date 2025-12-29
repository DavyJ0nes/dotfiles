function lld --wraps='eza_git $EZA_LD_OPTIONS' --wraps='exa_git $EXA_LD_OPTIONS' --description 'alias lld exa_git $EXA_LD_OPTIONS'
    exa_git $EXA_LD_OPTIONS $argv
end
