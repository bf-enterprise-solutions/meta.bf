>>>[-] ; move to case flag/instruction pointer and empty it
> ; to the instructions
;; interpreter switch/loop
[<+> ; set case flag
 [; plus
  ----- ----- ----- -----
  ----- ----- ----- ----- ---
  [- ; comma
   [- ; minus
    [- ; period
     [; less than
      ----- ----- ----
      [-- ; greater than
       [; opening bracket
        ----- -----
        ----- -----
        ----- ----
        [-- ; closing bracket
         [; default case
          ;; restore and move the original value
          +++++ +++++ +++++ +++++ +++++ +++++
          +++++ +++++ +++++ +++++ +++++ +++++
          +++++ +++++ +++++ +++++ +++++ +++++ +++
          [<<+>>-]
          <->] ; kill the case flag and exit
         ;; case closing bracket
         <[- ; kill the flag
          ;; restore the value (93 or closing bracket)
          < +++ +++++ +++++ +++++ +++++ +++++ +++++
          +++++ +++++ +++++ +++++ +++++ +++++
          +++++ +++++ +++++ +++++ +++++ +++++
          ;; move to the pointed cell (will appear uncommented further on)
          ;BEGIN=============================================
          [<]< ; N
          [<<[>>>+<<<-] ; copy the value cell three cells to the right
           >[<+>-] ; copy N copy cell
           >[<+>-] ; copy N
           <<+ ; add to N copy
           >-] ; subtract from N and iterate
          ;=============================================END
          ;; If the cell is not zero then move the instruction pointer
          ;; to the opening bracket
          << ; value cell
          [;; move back (will appear uncommented further on)
           ;BEGIN=============================================
           > ; N copy
           [>[>+<-] ; copy N
            <[>+<-] ; copy N copy
            >>>[<<<+>>>-] ; copy the value cell three cells to the right
            <+ ; add to N
            <-] ; subtract from N copy and iterate
           >>>[>]  ; back to the case flag (0)
           ;=============================================END
           < ; move to the last instruction
           ;; Check it for being an opening bracket
           ----- ----- ----- ----- ----- -----
           ----- ----- ----- ----- ----- -----
           ----- ----- ----- ----- ----- ----- -
           [; restore the value if it is not
            +++++ +++++ +++++ +++++ +++++ +++++
            +++++ +++++ +++++ +++++ +++++ +++++
            +++++ +++++ +++++ +++++ +++++ +++++ +
            [>>+<<-] ; copy it to the sector for further evaluation
            ;; subtract 91 from the next value
            < -   ----- ----- ----- ----- -----
            ----- ----- ----- ----- ----- -----
            ----- ----- ----- ----- ----- ----- -----] ; until opening bracket
           ;; restore the bracket in place once hit
           +++++ +++++ +++++ +++++ +++++ +++++
           +++++ +++++ +++++ +++++ +++++ +++++
           +++++ +++++ +++++ +++++ +++++ +++++ +
           ;; move to the value cell
           [<]<[<<[>>>+<<<-]>[<+>-]>[<+>-]<<+>-]
           <<[>>+<<-]] ; backup the value cell to N and exit
          >>[<<+>>-]<< ; copy the value if it was backed up
          ;; move back
          >[>[>+<-]<[>+<-]>>>[<<<+>>>-]<+<-]>>>[>]
         ]>]
        < ; case opening bracket
        [- ; kill the flag
         ;; restore 91 (opening bracket)
         < +   +++++ +++++ +++++ +++++ +++++
         +++++ +++++ +++++ +++++ +++++ +++++
         +++++ +++++ +++++ +++++ +++++ +++++ +++++
         ;; Check next instruction for being a closing bracket
         >>> ---
         ----- ----- ----- ----- ----- -----
         ----- ----- ----- ----- ----- -----
         ----- ----- ----- ----- ----- -----
         [; restore the value if it is not
          +++++ +++++ +++++ +++++ +++++ +++++
          +++++ +++++ +++++ +++++ +++++ +++++
          +++++ +++++ +++++ +++++ +++++ +++++ +++
          [<<+>>-] ; copy it to the processed sector
          ;; subtract 93 from the next value
          > --- ----- ----- ----- ----- -----
          ----- ----- ----- ----- ----- -----
          ----- ----- ----- ----- ----- ----- -----]
         ; restore the closing bracket in place to be processed next
         +++++ +++++ +++++ +++++ +++++ +++++
         +++++ +++++ +++++ +++++ +++++ +++++
         +++++ +++++ +++++ +++++ +++++ +++++ +++
         <<]>]
       < ; case greater than
       [- ; kill the flag
        ;; restore the value (62 or greater than)
        < ++  +++++ +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++ +++++
        ;; add one to N
        [<]<+
        ;; back to the killed flag
        >>[>]]>]
      < ; case less than
      [- ; kill the flag
       ;; restore the value (60 or less than)
       <+++++ +++++ +++++ +++++ +++++ +++++
       +++++ +++++ +++++ +++++ +++++ +++++
       ;; subtract one from N
       [<]<-
       ;; back to the killed flag
       >>[>]]>]
     < ; case period
     [- ; kill the flag
      ;; restore the value (46 or period)
      <+++++ +++++ +++++ +++++ +++++
      +++++ +++++ +++++ +++++ +
      ;; move to the pointed cell
      [<]<[<<[>>>+<<<-]>[<+>-]>[<+>-]<<+>-]
      <<. ; print the value cell
      ;; move back
      >[>[>+<-]<[>+<-]>>>[<<<+>>>-]<+<-]>>>[>]
     ]>]
    < ; case minus
    [- ; kill the flag
     ;; restore the value (45 or minus)
     <+++++ +++++ +++++ +++++ +++++
     +++++ +++++ +++++ +++++
     ;; move to the pointed cell
     [<]<[<<[>>>+<<<-]>[<+>-]>[<+>-]<<+>-]
     <<- ; decrease it
     ;; move back
     >[>[>+<-]<[>+<-]>>>[<<<+>>>-]<+<-]>>>[>]
    ]>]
   < ; case comma
   [- ; kill the flag
    ;; restore the value (44 or comma)
    <+++++ +++++ +++++ +++++ +++++
    +++++ +++++ +++++ ++++
    ;; move to the pointed cell
    [<]<[<<[>>>+<<<-]>[<+>-]>[<+>-]<<+>-]
    <<, ; read to it
    ;; move back
    >[>[>+<-]<[>+<-]>>>[<<<+>>>-]<+<-]>>>[>]
   ]>]
  < ; case plus
  [- ; kill the flag
   ;; restore the value (43 or plus)
   <+++++ +++++ +++++ +++++ +++++
   +++++ +++++ +++++ +++
   ;; move to the pointed cell
   [<]<[<<[>>>+<<<-]>[<+>-]>[<+>-]<<+>-]
   <<+ ; increase it
   ;; move back
   >[>[>+<-]<[>+<-]>>>[<<<+>>>-]<+<-]>>>[>]
  ]>]
 >] ; next instruction
; restore and move instructions to where they've been initially
<<<[[>>+<<-]<]
< ; N
