function llid --wraps='eza_git $EZA_LID_OPTIONS' --wraps='exa_git $EXA_LID_OPTIONS' --description 'alias llid exa_git $EXA_LID_OPTIONS'
    exa_git $EXA_LID_OPTIONS $argv
end
