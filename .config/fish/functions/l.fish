function l --wraps='ls -al' --wraps='eza $EZA_STANDARD_OPTIONS $EZA_L_OPTIONS' --wraps='eza $EXA_STANDARD_OPTIONS $EXA_L_OPTIONS' --description 'alias l eza $EXA_STANDARD_OPTIONS $EXA_L_OPTIONS'
  eza $EXA_STANDARD_OPTIONS $EXA_L_OPTIONS $argv
        
end
