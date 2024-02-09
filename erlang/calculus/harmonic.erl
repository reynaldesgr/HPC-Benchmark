-module(harmonic).
-export([harmonic_sum/1, benchmark/1]).

harmonic_sum(N) ->
    harmonic_sum(N, 0.0).

harmonic_sum(0, Sum) ->
    Sum;
harmonic_sum(N, Sum) ->
    harmonic_sum(N - 1, Sum + 1.0 / N).

benchmark(N) ->
    {Time, Result} = timer:tc(harmonic, harmonic_sum, [N]),
    io:format("Result: ~p~n", [Result]).
