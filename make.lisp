#!sbcl --script

(require "asdf")

(defvar commands "+-<>,.[]"
  "Characters to preserve in minified files.
Basically, Brainfuck commands you use.")

(with-open-file (min-file #p"mbfr.min.bf"
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
  (loop for char across (uiop:read-file-string #p"mbfr.bf")
        when (find char commands)
          do (write-char char min-file)))

(with-open-file (min-file #p"mbfl.min.bf"
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
  (loop for char across (uiop:read-file-string #p"mbfl.bf")
        when (find char commands)
          do (write-char char min-file)))

(with-open-file (repl-file #p"repl.bf"
                           :direction :output
                           :if-exists :supersede
                           :if-does-not-exist :create)
  (write-string "- ; set N to 255
>>>> ; instructions
,----- ----- [>,----------] ; read until a newline
<[+++++ +++++<] ; restore the values
>; move to instruction
[<<<< ; N
 " repl-file)
  (write-string (uiop:read-file-string #p"mbfl.bf") repl-file)
  (write-string "
 >>>>[>]<[[-]<]> ; Clear the previous input
 ,----- ----- [>,----- -----] <[+++++ +++++<]> ; read a new one
]" repl-file))

(with-open-file (min-file #p"repl.min.bf"
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
  (loop for char across (uiop:read-file-string #p"repl.bf")
        when (find char commands)
          do (write-char char min-file)))
