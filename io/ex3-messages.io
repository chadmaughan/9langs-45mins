o1 := Object clone
o1 test := method(for(n, 1, 3, n print; yield))
o2 := o1 clone

// @ means send an asynchronous message
o1 @test; o2 @test 

// here we pause the main coroutine
//  the process will exit after async messages are processed and there
// are no yielding coroutines to be switched to

Coroutine currentCoroutine pause
