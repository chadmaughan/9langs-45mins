package main

import (
	"fmt"
	"runtime"
)

func main() {

	fmt.Printf("number of cpus: %d \n", runtime.NumCPU())
	fmt.Printf("number of goroutines: %d\n", runtime.NumGoroutine())

	counterA := createCounterChannel(2)
	counterB := createCounterChannel(102)

	for i := 0; i < 20; i++ {
		a := <-counterA
		fmt.Printf("(A:%d, B:%d) - goroutines count: %d \n", a, <-counterB, runtime.NumGoroutine())
	}

	fmt.Println()
}

func createCounterChannel(start int) chan int {
	next := make(chan int)
	go func(i int) {
		for {
			next <- i
			i++
		}
	}(start)
	return next
}
