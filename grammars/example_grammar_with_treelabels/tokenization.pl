%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  $RCSfile: tokenization.pl,v $
%% $Revision: 1.2 $
%%     $Date: 2006/02/26 18:08:11 $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Defines tokenization to be used for this grammar:
%%
%% Basic idea: Translate a string into words, taking any number 
%%    of spaces as delimiting words, e.g.
%%    "ab"     -> [ab]
%%    "ab cd"  -> [ab,cd]
%%    "ab  cd" -> [ab,cd]
%%
%%    Note that this is equivalent to
%%    [97,98]              -> [ab]
%%    [97,98,32,99,100]    -> [ab,cd]
%%    [97,98,32,32,99,100] -> [ab,cd]
%%
%% Specific cases:
%% - decapitalizes all capital letters
%% - removes the sentence internal punctuation symbols: ; ! , . ?  
%% - a ' ends a word and starts the next word (even if the last symbol)
%%   e.g. "John's" -> [john,'\'s']
%%        "Jons'" -> [Johns,'\'']
%% - treats sentence final . ! and ? as referring to the start symbols
%%   defined by decl_symbol/1, imp_symbol/1 and que_symbol/1;
%%   if none of these ends the sentence, root_symbol/1 is used
%%
%%   Author: Detmar Meurers 
%%           with decapitalization rules for Polish by Adam Przepiorkowski
%%           and idea to use sentence final punctuation by Stefan Mueller
%%


tokenize_sentence_string(String,Tokenlist,Desc):-
   tokenize_sentence_string_act(String,Tokenlist,Desc).

% tokenize_sentence_string_act(+String,-Tokenlist,-StartSymbolDesc)
tokenize_sentence_string_act([],[],Desc) :- 
   !,
   (  current_predicate(root_symbol/1) 
   -> root_symbol(Desc)
   ;  Desc = bot
   ).
tokenize_sentence_string_act([LastChar],[],Desc) :- 
   LastChar==fullstop,
   !,
   (  current_predicate(decl_symbol/1) 
   -> decl_symbol(Desc)
   ;  Desc = bot
   )
   ;
   LastChar==exclam,
   !,
   (  current_predicate(imp_symbol/1) 
   -> imp_symbol(Desc)
   ;  Desc = bot
   )
   ;
   LastChar==question,
   !,
   (  current_predicate(que_symbol/1) 
   -> que_symbol(Desc)
   ;  Desc = bot
   ).
tokenize_sentence_string_act(String,AtomList,StartSymb) :-
   tokenize_word_string(String,AtomList0,AtomList,RestString),
   tokenize_sentence_string_act(RestString,AtomList0,StartSymb).

tokenize_word_string(String,AtomList0,AtomList,RestString) :-
   tokenize_one_word(String,WordList,RestString),
   (  WordList == []
   -> AtomList = AtomList0
   ;  atom_codes(Atom,WordList),
      AtomList = [Atom|AtomList0]
   ).

tokenize_one_word([],[],[]).                  % end of string reached
tokenize_one_word([H|T],Word,Rest) :-
   (  H == 32                        % a) space ends a word
   -> Word=[],eliminate_spaces(T,Rest)  %    and remove additional spaces
   ;  (  H == 39                     % b) ' ends a word
      -> Word =[],Rest=[quote|T]     %    and leave quote at start of next word
      ;  (  sentence_final_punct(H,NewH) 
         -> Word=[],Rest=[NewH|T]
         ;  tokenize_one_char(H,Word0,Word), % else c), map one char
            tokenize_one_word(T,Word0,Rest)      %    and continue on word
         )
      )
   ).

sentence_final_punct(H,NewH) :-
   NewH=fullstop,
   atom_codes('.',[H]), !
   ;
   NewH=exclamation,
   atom_codes('!',[H]), !
   ;
   NewH=question,
   atom_codes('?',[H]).

tokenize_one_char(quote,L,[39|L]) :- % quote is output as '
   !.
% remove punctuation except for sentence ending .,?, and ! (treated above)
tokenize_one_char(Char,L,L) :-       
   (sentence_final_punct(_,Char)
   ;atom_codes('(',[Char])
   ;atom_codes(')',[Char])
   ;atom_codes('-',[Char])
   ;atom_codes(';',[Char])
   ;atom_codes(',',[Char])),
   !.
tokenize_one_char(Upper,L,[Lower|L]) :- % letters are decapitalized
   decapitalize_char(Upper,Lower),
   !.
tokenize_one_char(Char,L,[Char|L]).


eliminate_spaces([],[]).
eliminate_spaces([H|T],R) :-
   (  H == 32 
   -> eliminate_spaces(T,R)
   ;  [H|T]=R
   ).

% ------------------------------------------------------------------------
% Converting to lower caps: not the fastest code, but transparent

decapitalize_char(X,XDecap):-   % fails for non-cap characters
   atom_codes('A',[A]),
   atom_codes('Z',[Z]),
   atom_codes( a ,[Lower_a]),
   Diff is Lower_a - A,
   ( (A =< X, X =< Z)
   -> XDecap is X + Diff        % basic capital to lower letter conversion
   ; decap_special(X,XDecap)    % specials for other character sets
   ).

% German letters
decap_special(X,Y) :-           % Ä -> ä
   atom_codes('Ä',[X]),!, 
   atom_codes('ä',[Y]).
decap_special(X,Y) :-           % Ü -> ü
   atom_codes('Ü',[X]),!,             
   atom_codes('ü',[Y]).
decap_special(X,Y) :-           % Ö -> ö
   atom_codes('Ö',[X]),!,                     
   atom_codes('ö',[Y]).
% Polish letters added by Adam P.
%decap_special(X,Y) :-           % ¡ -> ±
%   atom_codes('¡',[X]),!, 
%   atom_codes(±,[Y]).
%decap_special(X,Y) :-           % Ê -> ê
%   atom_codes('Ê',[X]),!, 
%   atom_codes(ê,[Y]).
%decap_special(X,Y) :-           % Æ -> æ
%   atom_codes('Æ',[X]),!, 
%   atom_codes(æ,[Y]).
%decap_special(X,Y) :-           % Ñ -> ñ
%   atom_codes('Ñ',[X]),!, 
%   atom_codes(ñ,[Y]).
%decap_special(X,Y) :-           % Ó -> ó
%   atom_codes('Ó',[X]),!, 
%   atom_codes(ó,[Y]).
%decap_special(X,Y) :-           % ¦ -> ¶
%   atom_codes('¦',[X]),!, 
%   atom_codes(¶,[Y]).
%decap_special(X,Y) :-           % ¬ -> ¼
%   atom_codes('¬',[X]),!, 
%   atom_codes(¼,[Y]).
%decap_special(X,Y) :-           % ¯ -> ¿
%   atom_codes('¯',[X]),!, 
%   atom_codes(¿,[Y]).
%decap_special(X,Y) :-           % £ -> ³
%   atom_codes('£',[X]),!, 
%   atom_codes(³,[Y]).

