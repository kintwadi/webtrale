% DEFINITE CLAUSES

%%%
%%% APPEND
%%%

% append(+,+,-)
% This append assumes that the first or the third argument
% are known to be non_empty or empty lists. 
%

fun append(+,+,-).
append(X,Y,Z) if 
   when( (X=(e_list;ne_list);
          Z=(e_list;ne_list)) 
       , undelayed_append(X,Y,Z)
       ).

undelayed_append([],L,L) if true.
undelayed_append([H|T1],L,[H|T2]) if append(T1,L,T2).


%%%
%%% ARGUMENT REALIZATION PRINCIPLE
%%%

arg_real_principle(L1,L2,L3,L4) if
       append(L1,L2,Lmiddle),
       append(Lmiddle,L3,L4).



%%%
%%% COLLECT_SLASHES
%%%


fun collect_slashes(+,-).
collect_slashes(Nhd_dtrs, Slashes) if
   when( (Nhd_dtrs=(e_list;ne_list))
       , undelayed_collect_slashes(Nhd_dtrs, Slashes)
       ).

undelayed_collect_slashes([],[]) if true.
undelayed_collect_slashes([(synsem:non_loc:inher:slash:Slash1)|Rest],Slash_all) if
         collect_slashes(Rest,Slash_Rest),
	 append(Slash1,Slash_Rest,Slash_all).




%%%
%%% LIST-OF-SYNTACTIC-SIGNS
%%%

fun list_of_syntactic_signs(-).
list_of_syntactic_signs([]) if true.
list_of_syntactic_signs([syntactic_sign]) if true.
list_of_syntactic_signs([syntactic_sign,syntactic_sign]) if true.
list_of_syntactic_signs([syntactic_sign,syntactic_sign,syntactic_sign])
        if true.


%%%
%%% MARKING PRINCIPLE
%%%

fun lexical_marking_principle(-).
lexical_marking_principle(synsem:loc:cat:head:marker) if true.
lexical_marking_principle(synsem:loc:cat:marking:unmarked) if true.



%%%
%%% SIGNS TO SYNS
%%%

signs_to_synsems(Signs,Synsems) if
   when(  (Signs=(e_list;ne_list)
	  ,Synsems=(e_list;ne_list)
	  ),
	  undel_signs_to_synsems(Signs,Synsems)).

undel_signs_to_synsems([],[]) if true.
undel_signs_to_synsems([(synsem:First)|T1],[First|T2]) if
                signs_to_synsems(T1,T2).



%%%
%%% COMBINE-PHONOLOGIES
%%%

fun combine_phonologies(+,-).
combine_phonologies(Dtrs, Phonology) if
   when( (Dtrs=(e_list;ne_list))
       , undelayed_combine_phonologies(Dtrs, Phonology)
       ).


undelayed_combine_phonologies([],[]) if true.
undelayed_combine_phonologies([(phon:Phon)|T],Result) if
    combine_phonologies(T,TPhon),
    append(Phon,TPhon,Result).

%%%
%%% build phonological atoms in lexical rules
%%%

pattern_to_word(Pattern) macro pattern_to_word((a_ Pattern)).
fun pattern_to_word(+,-).
pattern_to_word((a_ Pattern),(a_ Word)) if
   prolog((morph_pattern(Pattern,Chars),make_char_list(Codes,Chars),
           name(Word,Codes))).
