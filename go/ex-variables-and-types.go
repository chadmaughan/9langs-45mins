package main

import "fmt"
import "math/cmplx"

/*
 * BASIC TYPES
 *
 * bool
 * string
 * int  int8  int16  int32  int64
 * uint uint8 uint16 uint32 uint64 uintptr
 * byte 	// alias for uint8
 * rune 	// alias for int32
 *      	// represents a Unicode code point
 * float32 float64
 * complex64 complex128
 */

// var declars a list of variables
// 	variables of the same type can list the type at the end once
var x, y, z int          // ints
var c, python, java bool // bools

// you can also initialize variables,
//	if you do, you don't need to specify the type (takes type of initializer)
var ox, oy, oz int = 1, 2, 3
var oc, opython, ojava = true, false, "no!"

// declared like variables but with the 'const' keyword
const Pi = 3.14

var a complex128 = cmplx.Sqrt(-5+12i)

func main() {

	// a := is a 'short assignment', you don't need to use the var declaration with an implicity type
	pc, ppython, pjava := true, false, "no!"

	fmt.Println(x, y, z, c, python, java)
	fmt.Println(ox, oy, oz, oc, opython, ojava)
	fmt.Println(pc, ppython, pjava)

	// another constant example
	const Truth = true

	const f = "%T(%v)\n"
	fmt.Printf(f, a, a)

}
