define(`minimize', `ifelse($#, `0', ``$0'', `translit(`$1', ` -*/0-9:;=?@A-Z\\^-ab-z{-~
')')')dnl
define(`minclude', `ifelse($#, `0', ``$0'', `minimize(include(`$1'))')')dnl
