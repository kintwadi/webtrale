% File: principles.pl



% ---------------------------
% Principles
% ---------------------------

% A. Lexical Constraints

%%%
%%% All words
%%%


% Valents have empty SPR and COMPS lists

word *> (synsem:loc:cat:(subj: list_of_empty_spr_and_empty_comps,
                         spr: list_of_empty_spr_and_empty_comps,
                         comps: list_of_empty_spr_and_empty_comps)).


%%%
%%% Constraints on adjectives
%%%


%%%
%%% Constraints on complementizers
%%%



%%%
%%% Constraints on nouns
%%%


% Noun-Specifier Agreement

(word,
 synsem:loc:cat:(head:n,
                 spr:[synsem])) *> (synsem:loc:cat:(head:agr:Agr,
                                                    spr:[(loc:cat:head:agr:Agr)])).


%%%
%%% Constraints on prepositions
%%%



%%%
%%% Constraints on verbs
%%%

% Verb words must have a subject.  % Gert

(word,
 synsem:loc:cat:head:v) *> (synsem:loc:cat:(subj:[synsem],
                                            spr:[],
                                            spr_label:[])).



% Finite verbs agree with their subjects

(word,
 synsem:loc:cat:head:(v,
                      vform:fin)) *> (synsem:loc:cat:(head:agr:Agr,
                                                      subj:[(loc:cat:head:agr:Agr)])).


% Nominative case for the subject of finite verbs

(word,
 synsem:loc:cat:head:(v,
                      vform:fin))
*>
(synsem:loc:cat:subj:[loc:cat:head:case:nom]).


% Accusative case to NP complements

(word,
 synsem:loc:cat:(head:(v;p),
                 comps:hd:loc:cat:head:n))
*>
 (synsem:loc:cat:comps:hd:(loc:cat:head:case:acc)).

(word,
 synsem:loc:cat:(head:v,
                 comps:tl:hd:loc:cat:head:n))

*>
 (synsem:loc:cat:comps:tl:hd:(loc:cat:head:case:acc)).



% B. Phrasal Constraints

% ------
% phrase

% Empty COMPS Constraint (ECC)

phrase *> synsem:loc:cat:comps:[].




% -----
% hd_ph

% HEAD FEATURE PRINCIPLE

phrase *> 
  (synsem:loc:cat:head:Head,
   head_dtr:synsem:loc:cat:head:Head).

%-----------
% hd_subj_ph

hd_subj_ph *> (synsem:loc:(cat:head:vform:fin,
                           cont:(proposition,
                                 rel:Rel)),
               head_dtr:synsem:loc:cont:Rel).


% ----------
% hd_comp_ph



%%%
%%% Label principles
%%%

(word,
 synsem:loc:cat:(head:(v,
                       vform:fin),
                 subj_label:[np_case])) *> (synsem:loc:cat:subj_label:[np_nom]).

(word,
 synsem:loc:cat:(head:v,
                 comps_labels:[np_case|list])) *> (synsem:loc:cat:comps_labels:[np_acc|list]).


% Subj_Index, etc.

phrase *> (synsem:loc:cat:(subj_index:Subj_Index,
                          spr_index:Spr_Index,
                          comps_indices:Comps_Indices),
          head_dtr:(synsem:loc:cat:(subj_index:Subj_Index,
                                    spr_index:Spr_Index,
                                    comps_indices:Comps_Indices))).
