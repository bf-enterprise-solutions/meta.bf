[META.BF—EMBEDDABLE META-INTERPRETER FOR BRAINFUCK

 meta.bf follows Daniel Christofani's DBFI
 (https://github.com/maksimKorzh/dbfi) in being a Brainfuck interpreter
 written in Brainfuck... with a significant difference of being a
 meta-circular interpreter i.e., the interpreter using the constructs
 used to program the interpreter itself, for the interpreted
 language. Contrary to DBFI,

 - meta.bf reads input from the same places the Brainfuck
 interpreter/compiler running meta.bf does read it from.
 - Same for output.
 - meta.bf does not alter the memory layout of your program.
 -- Unless you make it run the code that does.
 --- N terminates at the value the interpreted code set it to.
 --- The code itself stays the same after meta.bf terminates.
 ---- Unless it modified itself.

 With these properties, you can embed meta.bf into your BF program and
 enable it to read and execute arbitrary BF code with the same
 privileges as the code of the program itself and in the same memory
 cells.

 meta.bf is already used in
 - ed.bf (https://github.com/bf-enterprise-solutions/ed.bf), UNIX ed
 re-implementation in Brainfuck, and in the OS.bf
 - os.bf (https://github.com/bf-enterprise-solutions/os.bf), a
 full-fledged Brainfuck OS.

 [1 GETTING STARTED

  Clone the code:
  [shell:
   git clone https://github.com/bf-enterprise-solutions/meta.bf.git]
  And build meta.bf:
  [shell:
   make all]

  Copy-paste it into your code and see the endless metacircularity of
  code fractals unfold before your very eyes!]

 [2 MEMORY LAYOUT

  As for any sufficiently complex copy-paste-able Brainfuck program,
  meta.bf requires a certain memory layout for the values it uses.

  [ 2.1 PRE-INTERPRETATION MEMORY LAYOUT.

   [0] [^N] [0] [0] [0] [F] [BF...] [0]

   Which means:

   - There should be at least one zero cell before the meaningful
   meta.bf cells.
   - N should be a non-zero cell containing the offset required to get
   to the memory segment in which to alter values while executing
   code via meta.bf.
   -- Which means, you can evaluate code at maximum 255 cells away from
   N for one byte implementations, or more on implementations with
   bigger cells.
   --- There might be a further modification that'd allow using 255
   beacons to mark the memory segment to act on. It's a work in
   progress with Q2 2025 ETA.
   - Three zeroed padding cells.
   - F should initially be set to zero.
   -- This cell, moving across the evaluated code, is referred to as
   case flag or instruction pointer in the code.
   - BF is a possibly empty null-terminated sequence of characters to evaluate.
   - Which means: you can theoretically use meta.bf to execute code
   that modifies itself while executing.
   -- What?
   --- Yes. Enjoy.

   Once you've put your data the way meta.bf requires, you can simply
   copy-paste the code of meta.bf version you need into your program and
   run it on your data. After meta.bf is done, the pointer stays at N and
   the code to interpret stays the way it was before evaluation, so you
   don't need to back anything up!]

  [2.2 INTERPRETATION MEMORY LAYOUT

   During the actual meta-interpretation of the code provided to
   meta.bf, the layout structure is:

   [N] [0] [P...] [0] [0] [F] [T...]

   Where:
   - N is the offset line.
   - It's followed by a single zero cell separating offset from the
   actual code.
   - Following this offset, there's P (processed sector) with
   instructions interpreted so far.
   - Then there are three mostly-zero cells, the last of which is the
   case flag (explained above).
   - And, finally, there's a T (to be processed) sector starting with
   the next character to interpret.

   After the character is evaluated, the layout shifts:
   [N] [0] [P...] [0]  [0] [F] [T1] [T...]
   to
   [N] [0] [P...] [PN] [0] [0] [F]  [T...]

   Thus, meta.bf uses a three byte long shifting evaluation window.]]

 [3 META.BF VERSIONS/FILES:

  meta.bf comes in two flavors: right-offsetting and left-offsetting,
  essentially based on which direction it goes for data sectors:
  - meta.r.bf: meta.bf right-offsetting. Offsets N cells to the right
  for the values.
  - meta.l.bf: meta.bf left-offsetting. Offsets N cells to the left
  for the values.

  And there are also auto-generated files that appear after you run 'make all':
  - meta.r.min.bf: Auto-generated (from meta.r.bf) file with all the
  non-BF characters stripped away.
  - meta.l.min.bf: Auto-generated (from meta.l.bf) file with all the
  non-BF characters stripped away.
  - meta.oneshot.r.bf and meta.oneshot.l.bf: Auto-generated (from
  meta.r.bf and meta.l.bf) executable that allows you to evaluate
  one piece of BF code and exit.
  - meta.oneshot.r.min.bf and meta.oneshot.l.min.bf: Auto-generated
  minified meta.oneshot.*.bf code.
  - meta.repl.r.bf and meta.repl.l.bf: Auto-generated (from meta.r.bf
  and meta.l.bf) script that allows you to evaluate Brainfuck code
  interactively.
  - meta.repl.r.min.bf and meta.repl.l.min.bf: Auto-generated (from
  meta.repl.*.bf) minified REPL code.]

 [4 TO DO:
  - Make it support nested loops.
  - Optimize layout and memory even more. Or revert all the
  optimizations for the sake of readability.]]
