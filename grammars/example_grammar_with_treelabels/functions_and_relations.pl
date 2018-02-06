

% --------------------------
% Functions and Relations
% --------------------------

% --------------
% append/3.
% appends two lists, returning a third as the result

fun append(+,+,-).
append(L1,L2,L3) if
   when( (L1 = (e_list;ne_list); L3 = (e_list;ne_list)),
         und_append(L1,L2,L3) ).

und_append([],L,L) if true.
und_append([H|T1],L,[H|T2]) if
     append(T1,L,T2).

% append/4
% appends 3 lists, returning a fourth as the result
fun append3(+,+,+,-).
append3(L1,L2,L3,L4) if
   append(L1,L2,Lmiddle),
   append(Lmiddle,L3,L4).

% list_of_empty_spr_and_empty_comps
% tests whether a sign/s SPR and COMPS lists are empty

fun list_of_empty_spr_and_empty_comps(-).
list_of_empty_spr_and_empty_comps(X) if
   when( X=(e_list;ne_list),
         und_list_of_empty_spr_and_empty_comps(X)).

und_list_of_empty_spr_and_empty_comps([]) if true.
und_list_of_empty_spr_and_empty_comps([(loc:cat:(spr:[],
                                                 comps:[]))|Y]) if list_of_empty_spr_and_empty_comps(Y).

                                           
% --------------                                                 
% synsem2labels/2
% given a list of synsems, it computes a list of their labels
fun synsem2labels(+,-).
synsem2labels(X,Y) if
   when(  ( X=(e_list;ne_list)
              ),
            undel_synsem2labels(X,Y)).

undel_synsem2labels([],[]) if true.
undel_synsem2labels([(Synsem)|Tl1],[Label|Tl2]) if
                                    label(Synsem,Label),
                                    synsem2labels(Tl1,Tl2).

% --------------
% synsem2label/2
% given a synsem, it computes its label
fun synsem2label(+,-).
synsem2label(Synsem,Label) if label(Synsem,Label).

label(loc:cat:head:d,det) if true.
label(loc:cat:head:(n,
                    case:nom),np_nom) if true.
label(loc:cat:head:(n,
                    case:acc),np_acc) if true.
label(loc:cat:head:p,pp) if true.
label(loc:cat:(head:(v,
                     vform:inf),
               subj:ne_list),vp_inf) if true.
label(loc:cat:(head:(v,
                     vform:base),
               subj:ne_list),vp_base) if true.
label(loc:cat:(head:(v,
                     vform:fin),
              subj:ne_list),vp_fin) if true.
label(loc:cat:(head:v,
               subj:e_list),s) if true.
label(loc:cat:head:a,ap) if true.
label(loc:cat:head:adv,advp) if true.


% --------------
% synsem2sign/2.
% takes a list of synsem values and converts it to a list of signs

fun synsem2sign(+,-).
synsem2sign(e_list,e_list) if true.
synsem2sign([H|T],[synsem:H|synsem2sign(T)]) if true.


% --------------
% fr: October 29, 2017
%%%
%%% build phonological atoms in lexical rules
%%%


fun pattern_to_word(+,-).
pattern_to_word((a_ Pattern),(a_ Word)) if
   prolog((morph_pattern(Pattern,Chars),make_char_list(Codes,Chars),
           name(Word,Codes))).


