-module(recursion).
-export([countdown/1]).

countdown(0) -> 0;
countdown(N) ->
  io:format("~B~n", [N]),
  countdown(N-1).
