function ld --wraps='eza $EZA_STANDARD_OPTIONS $EZA_LD_OPTIONS $EZA_L_OPTIONS' --wraps='eza $EXA_STANDARD_OPTIONS $EXA_LD_OPTIONS $EXA_L_OPTIONS' --description 'alias ld eza $EXA_STANDARD_OPTIONS $EXA_LD_OPTIONS $EXA_L_OPTIONS'
  eza $EXA_STANDARD_OPTIONS $EXA_LD_OPTIONS $EXA_L_OPTIONS $argv
        
end
