-module(fannkuch).
-export([fannkuch_redux/1, main/0]).

% Entry function that calculates the fannkuch redux value for n.
fannkuch_redux(N) ->
    Permutations = perms(lists:seq(1, N)),
    FannkuchValues = [fannkuch(P) || P <- Permutations],
    lists:max(FannkuchValues).

% Calculates the fannkuch value for a single permutation.
fannkuch(P) ->
    fannkuch(P, 0).

fannkuch([1 | _T], Flips) ->
    Flips;
fannkuch(P, Flips) ->
    fannkuch(flip(P, find(P, 1)), Flips + 1).

% Flips the first N elements of the list.
flip(List, N) ->
    {Reversed, Remain} = lists:split(N, List),
    lists:reverse(Reversed) ++ Remain.

% Finds the position of the element in the list.
find(List, Element) ->
    find(List, Element, 1).

find([H | _T], Element, Index) when H == Element ->
    Index;
find([_H | T], Element, Index) ->
    find(T, Element, Index + 1).

% Generates all permutations of the list.
perms(List) ->
    perms(List, []).

perms([], Acc) ->
    [Acc];
perms(List, Acc) ->
    lists:flatmap(
        fun (E) ->
            perms(lists:delete(E, List), [E | Acc])
        end, List).

% Main entry point to run fannkuch_redux with N=12.
main() ->
    N = 12,
    Result = fannkuch_redux(N),
    io:format("Fannkuch redux number for ~p is ~p.~n", [N, Result]).
