% File: lexical_rules.pl

% -----------------
% II. Lexical Rules
% -----------------



% Lexical rules for adjectives

adj_rule lex_rule
(word,                       
 synsem:loc:(cat:(head:a,
                  subj:Subj,
                  spr:[synsem],
                  comps:Comps,
                  subj_label:Subj_label,
                  subj_index:Index,
                  comps_labels:Comps_labels,
                  comps_indices:Comps_indices),                 
             cont:Rel))
  **>
(word,
 phon:ne_list,                       
 synsem:loc:(cat:(head:a,
                  subj:Subj,
                  spr:[],
                  comps:Comps,
                  subj_label:Subj_label,
                  subj_index:Index,
                  spr_label:[],
                  spr_index:none,
                  comps_labels:Comps_labels,
                  comps_indices:Comps_indices),
             cont:(Rel,
                   degree:normal)))
morphs            
  W becomes W.
  
  

/*
% B. Lexical rules for nouns

% Plural nouns

noun_pl_rule lex_rule
(word,
 synsem:loc:(cat:(head:(n,
                        agr:thd_sg),
                  subj:[],
                  spr:[(@dp(Index))],
                  comps:[],
                  subj_label:Subj_label,
                  subj_index:Subj_Index,
                  spr_label:Spr_label,
                  spr_index:Spr_Index,
                  comps_labels:Comps_labels,
                  comps_indices:Comps_indices),
              cont:Index,
              cont_label:Cont_label))
  **>
(word,
 synsem:loc:(cat:(head:(n,
                        agr:thd_pl),
                  subj:[],
                  spr:[(@dp(Index))],
                  comps:[],
                  subj_label:Subj_label,
                  subj_index:Subj_Index,
                  spr_label:Spr_label,
                  spr_index:Spr_Index,
                  comps_labels:Comps_labels,
                  comps_indices:Comps_indices),
              cont:Index,
              cont_label:Cont_label))
morphs
 (W,ch) becomes (W,ches),
 (W,y) becomes (W,ies),
  W becomes (W,s).                  
*/


% Lexical rules for verbs

% Non-third singular present tense

non_third_sg_rule lex_rule
(word,
 synsem:loc:(cat:(head:(v,
                        aux:minus,
                        vform:base),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices),                   
             cont:Rel),
  lex_ru:plus)
**>
(word,
 phon:ne_list,
 synsem:loc:(cat:(head:(v,
                        agr:non_thd_sg,
                        aux:minus,
                        vform:fin),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices),                     
             cont:Rel))
morphs
  W becomes W.

  
  
% Third-sg present tense

third_sg_rule lex_rule
(word,
 synsem:(loc:(cat:(head:(v,
                         aux:minus,
                         vform:base),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices), 
              cont:Rel)),
  lex_ru:plus)
**>
(word,
 synsem:(loc:(cat:(head:(v,
                         agr:thd_sg,
                         aux:minus,
                         vform:fin),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices),  
              cont:Rel)))
morphs
  be becomes is,
  go becomes goes,
  have becomes has,
 (W,ch) becomes (W,ches),
 (W,y) becomes (W,ies),
  W becomes (W,s).
  



% Past tense

past_tense_rule lex_rule
(word,
 synsem:(loc:(cat:(head:(v,
                         aux:minus,
                         vform:base),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices), 
              cont:Rel)),
 lex_ru:plus)
**>
(word,
 phon:ne_list,
 synsem:(loc:(cat:(head:(v,
                         aux:minus,
                         vform:fin),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices),  
              cont:(past,
                    arg1:Rel))))
morphs
  be becomes was,
  beat becomes beat,
  do becomes did,
  eat becomes ate,
  give becomes gave,
  go becomes went,
  have becomes had,
  know becomes knew,
  leave becomes left,
  make becomes made,
  put becomes put,
  run becomes ran,
  see becomes saw,
  sing becomes sang,
  speak becomes spoke,
  think becomes thought,
 (W,y) becomes (W,ied),
 (W,e) becomes (W,ed),
  W becomes (W,ed).


% Present participle

prp_rule lex_rule
(word,
 synsem:(loc:(cat:(head:(v,
                         aux:minus,
                         vform:base),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices), 
              cont:Cont)),
  lex_ru:plus)
**>
(word,
 phon:ne_list,
 synsem:(loc:(cat:(head:(v,
                         aux:minus,
                         vform:prp),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices),  
              cont:Cont)))
morphs
  be becomes being,
  put  becomes putting,
  see becomes seeing,
 (W,e) becomes (W,ing),
  W becomes (W,ing).   


% Perfect participle

pfp_rule lex_rule
(word,
 synsem:(loc:(cat:(head:(v,
                         aux:minus,
                         vform:base),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices),  
              cont:Cont)),
  lex_ru:plus)
**>
(word,
 phon:ne_list,
 synsem:(loc:(cat:(head:(v,
                         aux:minus,
                         vform:pfp),
                   subj:Subj,
                   subj_label:Subj_label,
                   subj_index:Subj_Index,
                   spr_index:Spr_Index,
                   comps:Comps,
                   comps_labels:Comps_labels,
                   comps_indices:Comps_Indices), 
              cont:Cont)))
morphs
  be becomes been,
  beat becomes beaten,
  buy becomes bought,
  eat becomes eaten,
  give becomes given,
  go becomes gone,
  have becomes had,
  know becomes known,
  leave becomes left,
  made becomes made,
  put becomes put,
  run becomes run,
  see becomes seen,
  show becomes shown,
  sing becomes sung,
  speak becomes spoken,
  think becomes thought,
 (W,y) becomes (W,ied),
 (W,e) becomes (W,ed),
  W becomes (W,ed).



