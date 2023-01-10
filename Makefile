.PHONY: all min clean

min-files = meta.r.min.bf meta.l.min.bf meta.oneshot.min.bf meta.repl.min.bf

min: $(min-files)

all: meta.oneshot.bf meta.repl.bf min

clean:
	rm meta.oneshot.bf meta.repl.bf $(min-files)

%.bf: %.in
	m4 meta.m4 $^ >> $@

%.min.bf: %.bf
	echo "minclude($^)" | m4 meta.m4 - >> $@
