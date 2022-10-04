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
