#!sbcl --script

(require "asdf")

(defvar commands "+-<>,.[]"
  "Characters to preserve in minified files.
Basically, Brainfuck commands you use.")

(with-open-file (min-file #p"meta.r.min.bf"
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
  (loop for char across (uiop:read-file-string #p"meta.r.bf")
        when (find char commands)
          do (write-char char min-file)))

(with-open-file (min-file #p"meta.l.min.bf"
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
  (loop for char across (uiop:read-file-string #p"meta.l.bf")
        when (find char commands)
          do (write-char char min-file)))

(with-open-file (oneshot-file #p"meta.oneshot.bf"
                              :direction :output
                              :if-exists :supersede
                              :if-does-not-exist :create)
  (write-string ">>>----- ; set N to 254
>>>> ; instructions
,----- ----- [>,----------] ; read until a newline
<[+++++ +++++<] ; restore the values
<<< ; N" oneshot-file)
  (write-string (uiop:read-file-string #p"meta.r.bf") oneshot-file))

(with-open-file (min-file #p"meta.oneshot.min.bf"
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
  (loop for char across (uiop:read-file-string #p"meta.oneshot.bf")
        when (find char commands)
          do (write-char char min-file)))

(with-open-file (repl-file #p"meta.repl.bf"
                           :direction :output
                           :if-exists :supersede
                           :if-does-not-exist :create)
  (write-string ">>>----- ; set N to 254
>>>> ; instructions
,----- ----- [>,----------] ; read until a newline
<[+++++ +++++<] ; restore the values
>; move to instruction
[<<<< ; N
 " repl-file)
  (write-string (uiop:read-file-string #p"meta.r.bf") repl-file)
  (write-string "
 >>>>[>]<[[-]<]> ; Clear the previous input
 ,----- ----- [>,----- -----] <[+++++ +++++<]> ; read a new one
]" repl-file))

(with-open-file (min-file #p"meta.repl.min.bf"
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
  (loop for char across (uiop:read-file-string #p"meta.repl.bf")
        when (find char commands)
          do (write-char char min-file)))
