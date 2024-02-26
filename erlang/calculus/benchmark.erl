-module(benchmark).
-export([benchmark_operations/0]).

benchmark_operations() ->
    Iterations = 100000000,
    F1 = 1.234567,
    F2 = 7.890123,
    
    io:format("Benchmarking float (actually double in Erlang) operations:~n"),
    
    StartTimeFloatMult = erlang:monotonic_time(),
    benchmark_float_multiplication(F1, F2, Iterations),
    EndTimeFloatMult = erlang:monotonic_time(),
    ElapsedFloatMult = erlang:convert_time_unit(EndTimeFloatMult - StartTimeFloatMult, native, millisecond),
    io:format("Float multiplication: Time = ~p milliseconds~n", [ElapsedFloatMult]),
    
    StartTimeFloatAdd = erlang:monotonic_time(),
    benchmark_float_addition(F1, F2, Iterations),
    EndTimeFloatAdd = erlang:monotonic_time(),
    ElapsedFloatAdd = erlang:convert_time_unit(EndTimeFloatAdd - StartTimeFloatAdd, native, millisecond),
    io:format("Float addition: Time = ~p milliseconds~n", [ElapsedFloatAdd]),
    
    StartTimeFloatDiv = erlang:monotonic_time(),
    benchmark_float_division(F1, F2, Iterations),
    EndTimeFloatDiv = erlang:monotonic_time(),
    ElapsedFloatDiv = erlang:convert_time_unit(EndTimeFloatDiv - StartTimeFloatDiv, native, millisecond),
    io:format("Float division: Time = ~p ms~n", [ElapsedFloatDiv]).

benchmark_float_multiplication(F1, F2, 0) -> F1 * F2;
benchmark_float_multiplication(F1, F2, N) ->
    F1 * F2,
    benchmark_float_multiplication(F1, F2, N - 1).

benchmark_float_addition(F1, F2, 0) -> F1 + F2;
benchmark_float_addition(F1, F2, N) ->
    F1 + F2,
    benchmark_float_addition(F1, F2, N - 1).

benchmark_float_division(F1, F2, 0) -> F1 / F2;
benchmark_float_division(F1, F2, N) ->
    F1 / F2,
    benchmark_float_division(F1, F2, N - 1).

% Benchmarking float (actually double in Erlang) operations:
% Float multiplication: Time = 74 ms
% Float addition: Time = 66 ms
% Float division: Time = 67 ms