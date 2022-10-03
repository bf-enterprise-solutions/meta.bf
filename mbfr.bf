[mbfr.bf -- right-offseting embeddable meta-interpreter for brainfuck.

 Simply copy-paste the code below this commentary into your program,
 making sure that the memory looks like this:

 [N] [0] [0] [F] [BF code to interpret...] [0]
  ^ pointer here

 - where N is the number of cells to offset starting from N to the
   right.

 - and F is the case flag/instruction pointer that should be initially
   set to zero.

  ASCII:   93  91  62  60  46  45  44  43
  char:    ]   [   >   <   .   -   ,   +

 Code starts here:]
>>>[-] ; move to case flag/instruction pointer and empty it
> ; to the instruction
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
          <[-]>] ; kill the case flag and exit
         ;; case closing bracket
         <[[-] ; kill the flag
          ;; restore the value (93 or closing bracket)
          > +++ +++++ +++++ +++++ +++++ +++++ +++++
          +++++ +++++ +++++ +++++ +++++ +++++
          +++++ +++++ +++++ +++++ +++++ +++++
          [<]<[>>[<<<+>>>-]<[>+<-]<[>+<-]>>+<-]
          ;; If the cell is not zero then move the instruction pointer
          ;; to the opening bracket
          >> ; value cell
          [ ; move back to N
           <<[<[<+>-]>[<+>-]<<<[>>>+<<<-]>+>-]>>[>]
           >>>[>]< ; move to the last instruction
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
            < - ----- ----- ----- ----- ----- -----
            ----- ----- ----- ----- ----- -----
            ----- ----- ----- ----- ----- -----] ; until opening bracket
           ;; restore the bracket in place once hit
           +++++ +++++ +++++ +++++ +++++ +++++
           +++++ +++++ +++++ +++++ +++++ +++++
           +++++ +++++ +++++ +++++ +++++ +++++ +
           ;; move to the value cell
           [<]<[>>[<<<+>>>-]<[>+<-]<[>+<-]>>+<-]
           >>[<+>-]] ; backup the value cell to N copy and exit
          <[>+<-]> ; copy the value if it was backed up
          ;; move back
          <[<[<+>-]>[<+>-]<<<[>>>+<<<-]>+>-]>>[>]
         ]>]
        < ; case opening bracket
        [[-] ; kill the flag
         ;; Check next instruction for being a closing bracket
         > --- ----- ----- ----- ----- -----
         ----- ----- ----- ----- ----- -----
         ----- ----- ----- ----- ----- ----- -----
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
        ]>]
       < ; case greater than
       [[-] ; kill the flag
        ;; restore the value (62 or greater than)
        < ++  +++++ +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++ +++++
        ;; add one to N
        [<]<+
        ;; back to the killed flag
        >>[>]]>]
      < ; case less than
      [[-] ; kill the flag
       ;; restore the value (60 or less than)
       <+++++ +++++ +++++ +++++ +++++ +++++
       +++++ +++++ +++++ +++++ +++++ +++++
       ;; subtract one from N
       [<]<-
       ;; back to the killed flag
       >>[>]]>]
     < ; case period
     [[-] ; kill the flag
      ;; restore the value (46 or period)
      <+++++ +++++ +++++ +++++ +++++
      +++++ +++++ +++++ +++++ +
      ;; move to the pointed cell (will appear uncommented further on)
      [<]< ; N
      [>>[<<<+>>>-] ; copy the value cell three cells to the left
       <[>+<-] ; copy N copy cell
       <[>+<-] ; copy N
       >>+ ; add to N copy
       <-] ; subtract from N and iterate
      >>. ; print the value cell
      ;; move back (will appear uncommented further on)
      < ; N copy
      [<[<+>-] ; copy N
       >[<+>-] ; copy N copy
       <<<[>>>+<<<-] ; copy the value cell three cells to the right
       >+ ; add to N
       >-] ; subtract from N copy and iterate
      >>[>]  ; back to the case flag (0)
     ]>]
    < ; case minus
    [[-] ; kill the flag
     ;; restore the value (45 or minus)
     <+++++ +++++ +++++ +++++ +++++
     +++++ +++++ +++++ +++++
     ;; move to the pointed cell
     [<]<[>>[<<<+>>>-]<[>+<-]<[>+<-]>>+<-]
     >>- ; decrease it
     ;; move back
     <[<[<+>-]>[<+>-]<<<[>>>+<<<-]>+>-]>>[>]
    ]>]
   < ; case comma
   [[-] ; kill the flag
    ;; restore the value (44 or comma)
    <+++++ +++++ +++++ +++++ +++++
    +++++ +++++ +++++ ++++
    ;; move to the pointed cell
    [<]<[>>[<<<+>>>-]<[>+<-]<[>+<-]>>+<-]
    >>, ; read to it
    ;; move back
    <[<[<+>-]>[<+>-]<<<[>>>+<<<-]>+>-]>>[>]
   ]>]
  < ; case plus
  [[-] ; kill the flag
   ;; restore the value (43 or plus)
   <+++++ +++++ +++++ +++++ +++++
   +++++ +++++ +++++ ++++
   ;; move to the pointed cell
   [<]<[>>[<<<+>>>-]<[>+<-]<[>+<-]>>+<-]
   >>+ ; increase it
   ;; move back
   <[<[<+>-]>[<+>-]<<<[>>>+<<<-]>+>-]>>[>]
  ]>]
 >] ; next instruction
