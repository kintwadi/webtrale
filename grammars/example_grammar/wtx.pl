:- use_module(library(sockets), [socket/2, socket_accept/3, socket_close/1]).
:- use_module(library(charsio), [write_to_chars/2]).
:- use_module(library(lists), [substitute/4]).

:- ensure_loaded(trale_home(ghooks)).
:- ensure_loaded(tokenization).

trale_server_start(Port) :-
    socket('AF_INET', ServerSocket),
    socket_bind(ServerSocket, 'AF_INET'('127.0.0.1', Port)),
    socket_listen(ServerSocket, 1),
    print_message(informational, 'waiting for client on port'=Port),
    socket_accept(ServerSocket, Client, Stream),
    print_message(informational, client=Client),
    socket_close(ServerSocket),
    asserta(socket_info(_, Stream)),
    trale_server_toplevel(Stream),
    retractall(socket_info(_, _)).

trale_server_toplevel(Stream) :-
    repeat,
    catch((
        read(Stream, Term),
        print_message(informational, read_term=Term), nl,
        % niko. Description hab ich reingemacht. das ist der constraint oder macro.
        % z.b: @root oder syntax:head:verb
        (   Term = rec(X, MaxResults, MaxWords, Description)
                            ->  Command = (wt_recmax(X, MaxResults, MaxWords, Description), fail)
        ;   Term = rec(X, MaxResults)
                            ->  Command = (wt_recmax(X, MaxResults, 10, Description), fail)
        ;   Term = rec(X)   ->  Command = (wt_recmax(X, 100, 100, Description), fail)
        ;   Term = lex(X)   ->  Command = (wt_lexall(X), fail)
        ;   Term = words    ->  Command = (wt_lexicon, fail)
        ;   Term = quit     ->  Command = true
        ;                       Command = fail
        ),
        once(Command)
        ),
        Exception,
        (advice_exception(Exception), fail)
    ).

advice_exception(Ex) :-
    get_output_stream(S),
    write(S, '*'),
    write_to_chars(Ex, ExChars0),
    substitute(0'., ExChars0, 0'?, ExChars), % '
    atom_codes(ExAtom, ExChars),
    write(S, ExAtom), nl(S),
    terminate_output(S).

terminate_output :-
    get_output_stream(S),
    terminate_output(S).
    
terminate_output(S) :-
    get_output_stream(S),
    write(S, '.'), nl(S),
    flush_output(S).

:- dynamic wt_recmax_counter/0.

wt_recmax(String, MaxResults, MaxWords, Description) :-
    general_tokenize_sentence_string(String, Words, _IgnoredDesc),
    length(Words, NumWords),
    (   NumWords > MaxWords
    ->  throw(webtrale_rec_error('word count limit exceeded', NumWords, limit:MaxWords))
    ;   true
    ),
    retractall(wt_recmax_counter),
    % niko (hier ist das interface zum constraint)
    %Desc=bot, % so wars frueher
    %Desc=syntax:head:verb, % tut.
    Desc=Description, 
    wt_recmax(Words=Desc, MaxResults),
    terminate_output.

wt_recmax(Words=Desc, MaxResults) :-
    rec(Words, FS, Desc, Residue, Index),
    % niko.
   % print_message('informational', 'anfang1'),
   % print_message('informational', Words),
   % print_message('informational', 'ende1'),
   % print_message('informational', 'anfang2'),
   % print_message('informational', FS),
   % print_message('informational', 'ende2'),
   % print_message('informational', 'anfang3'),
   % print_message('informational', Desc),
   % print_message('informational', 'ende3'),
   % print_message('informational', 'anfang4'),
   % print_message('informational', Residue),
   % print_message('informational', 'ende4'),
   % print_message('informational', 'anfang5'),
   % print_message('informational', Index),
   % print_message('informational', 'ende5'),
    
    portray_cat(Words, Desc, FS, Residue, Index),
    assert(wt_recmax_counter),
    findall(_, wt_recmax_counter, Counters),
    length(Counters, NumCounters),
    NumCounters >= MaxResults,
    !.
wt_recmax(_, _).

wt_lexall(String) :-
    general_tokenize_sentence_string(String, Words, _),
    (   Words = [Word], nonvar(Word)        % exactly one word, nonvar
    ->  true
    ;   throw(webtrale_lex_error(String, Words))
    ),
    (   lex(Word, FS),
        portray_lex(Word, FS, _),
        fail
    ;   true
    ),
    terminate_output.

wt_lexicon :-
    get_output_stream(S),
    (   --->(Word, _FS),
        write(S, Word), nl(S),
        fail
    ;   true
    ),
    terminate_output.
