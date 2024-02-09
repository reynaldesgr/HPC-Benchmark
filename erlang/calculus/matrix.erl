-module(matrix).
-export([multiply/2]).

multiply(MatrixA, MatrixB) ->
    lists:map(fun(RowA) ->
        lists:map(fun(ColumnB) ->
            lists:sum(lists:zipwith(fun(X, Y) -> X * Y end, RowA, ColumnB))
        end, transpose(MatrixB))
    end, MatrixA).

transpose(Matrix) -> lists:zip(Matrix).