-module(matrix).
-export([multiply/2]).

multiply(A, B) ->
    lists:map(fun(Row) -> multiply_row(Row, B) end, A).

multiply_row(Row, B) ->
    lists:map(fun(BCol) -> dot_product(Row, BCol) end, transpose(B)).

dot_product(Row, Col) ->
    lists:sum([X*Y || {X, Y} <- lists:zip(Row, Col)]).

transpose([H|T]) ->
    transpose(H, T, []).

transpose([], _, Transposed) ->
    Transposed;
transpose([_|Rest], Matrix, Acc) ->
    {Heads, Tails} = lists:unzip([lists:split(1, Row) || Row <- Matrix]),
    transpose(Rest, Tails, [Heads|Acc]).
