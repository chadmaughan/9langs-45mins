slower := Object clone
faster := Object clone

slower start := method(wait(2); writeln("slowly"))
faster start := method(wait(1); writeln("quickly"))

// faster waits until slower finishes
slower start; faster start

// @@ tells each object to run in its own thread
slower @@start; faster @@start; wait(3)
