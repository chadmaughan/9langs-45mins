package main

import (
	"fmt"
	"sort"
)

func main() {
	// arrays example
	var buffer [20]byte
	var grid1 [3][3]int
	grid1[1][0], grid1[1][1], grid1[1][2] = 8, 6, 2
	grid2 := [3][3]int{{4, 3}, {8, 6, 2}}
	cities := [...]string{"Shanghai", "Mumbai", "Istanbul", "Beijing"}
	cities[len(cities)-1] = "Karachi"
	fmt.Println("Type     Len Contents")
	fmt.Printf("%-8T %2d %v\n", buffer, len(buffer), buffer)
	fmt.Printf("%-8T %2d %q\n", cities, len(cities), cities)
	fmt.Printf("%-8T %2d %v\n", grid1, len(grid1), grid1)
	fmt.Printf("%-8T %2d %v\n", grid2, len(grid2), grid2)

	// slices example
	s := []string{"A", "B", "C", "D", "E", "F", "G"}
	t := s[:5]           // [A B C D E]
	u := s[3 : len(s)-1] // [D E F]
	fmt.Println(s, t, u)
	u[1] = "x"
	fmt.Println(s, t, u)

	// iterate slices
	amounts := []float64{237.81, 261.87, 273.93, 279.99, 281.07, 303.17, 231.47, 227.33, 209.23, 197.09}
	sum := 0.0
	for _, amount := range amounts {
		sum += amount
	}
	fmt.Printf("Σ %.1f → %.1f\n", amounts, sum)

	// sorting collections
	files := []string{"Test.conf", "util.go", "Makefile", "misc.go", "main.go"}
	fmt.Printf("Unsorted:         %q\n", files)

	// Standard library sort function
	sort.Strings(files)
	fmt.Printf("Underlying bytes: %q\n", files)

	// maps example
	massForPlanet := make(map[string]float64)
	// Same as: map[string]float64{}

	massForPlanet["Mercury"] = 0.06
	massForPlanet["Venus"] = 0.82
	massForPlanet["Earth"] = 1.00
	massForPlanet["Mars"] = 0.11

	fmt.Println(massForPlanet)
}
