-module(fibonacci).
-export([fibonacci/1, main/0]).

fibonacci(0) -> 0;
fibonacci(1) -> 1;
fibonacci(N) when N > 1 -> fibonacci(N-1) + fibonacci(N-2).

main() ->
    Res = fibonacci(45),
    io:format("Erlang result : ~p~n", [Res]).