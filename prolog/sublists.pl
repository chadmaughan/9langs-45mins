
size([], 0).
size([First|Rest], N) :- size(Rest, N1), N is N1+1.

sum([], 0).
sum([First|Rest], N) :- sum(Rest, N1), N is N1 + First.

sublistOf(List, Sub) :- 
  append(_, SubStarts, List), 
  append(Sub, _, SubStarts).

average(List, Avg) :- 
  size(List, Num), 
  sum(List, Sum), 
  Num =\= 0,
  Avg is (Sum/Num).

subseqWithAverage(Avg, List, Sub) :- 
  sublistOf(List, Sub), 
  average(Sub, Avg).
