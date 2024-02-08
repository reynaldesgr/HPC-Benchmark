-module(binary_tree).
-export([main/0, make_tree/1, check_tree/1]).

-record(tree, {left, right}).

make_tree(0) ->
    null;
make_tree(Depth) ->
    DepthMinusOne = Depth - 1,
    #tree{left = make_tree(DepthMinusOne),
          right = make_tree(DepthMinusOne)}.

check_tree(null) ->
    0;
check_tree(#tree{left = Left, right = Right}) ->
    1 + check_tree(Left) + check_tree(Right).

main() ->
    N = 21,
    Depth = 22,
    lists:foreach(
        fun(_) ->
            Tree = make_tree(Depth),
            TotalNodes = check_tree(Tree),
            io:format("Tree of depth ~p has ~p nodes.~n", [Depth, TotalNodes])
        end,
        lists:seq(1, N)).
