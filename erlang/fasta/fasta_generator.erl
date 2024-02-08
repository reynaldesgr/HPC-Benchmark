-module(fasta_generator).
-export([generate_fasta/3]).

% Entry function to generate DNA sequences and write to a FASTA file.
generate_fasta(NumSequences, SequenceLength, Filename) ->
    {ok, File} = file:open(Filename, [write]),
    generate_and_write_sequences(NumSequences, SequenceLength, File, 1),
    file:close(File).

% Recursively generates DNA sequences and writes them to the file.
generate_and_write_sequences(0, _SequenceLength, _File, _SeqNum) ->
    ok; % Base case: no more sequences to generate
generate_and_write_sequences(Count, SequenceLength, File, SeqNum) ->
    Sequence = generate_dna_sequence(SequenceLength),
    io:fwrite(File, ">seq~p\n~s\n", [SeqNum, Sequence]),
    generate_and_write_sequences(Count - 1, SequenceLength, File, SeqNum + 1).

% Generates a random DNA sequence of the specified length.
generate_dna_sequence(Length) ->
    lists:foldl(
        fun(_Elem, Acc) -> [random_base() | Acc] end,
        [],
        lists:seq(1, Length)
    ).

% Randomly selects a DNA base.
random_base() ->
    case rand:uniform(4) of
        1 -> $A;
        2 -> $C;
        3 -> $G;
        4 -> $T
    end.