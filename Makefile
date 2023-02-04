.PHONY: all min clean

min-files = meta.r.min.bf meta.l.min.bf meta.oneshot.r.min.bf meta.oneshot.l.min.bf meta.repl.r.min.bf meta.repl.l.min.bf
min: $(min-files)

derivative-files = meta.r.bf meta.l.bf meta.oneshot.r.bf meta.oneshot.l.bf meta.repl.r.bf meta.repl.l.bf
deriv: $(derivative-files)

all: deriv min

clean:
	rm $(derivative-files) $(min-files)

meta.r.bf: meta.in
	m4 meta.m4 right.m4 $^ >> $@

meta.l.bf: meta.in
	m4 meta.m4 left.m4 $^ >> $@

%.bf: %.in
	m4 meta.m4 $^ >> $@

%.min.bf: %.bf
	echo "minclude($^)" | m4 meta.m4 - >> $@
