// assignment
x := 1

// string
str := "don't say \"no\""
str println

ostr := "do re mi" split(" ")
ostr println

// list
list("do", "re", "mi") join(" ")

// date
t := Date now
"year: " + t year asString println
"month: " + t month asString println
t day println
t hour println
t minute "minutes: " + println
t second "seconds: " + println

// array
nums := list(1,2,3,4)
nums size println
nums at(0) println

// map
d := Map with("t", 1, "f", 0)
