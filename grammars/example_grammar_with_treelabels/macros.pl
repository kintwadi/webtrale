% File: macros.pl

:- multifile macro/2. % needed for phonology of derived words

% ---------------------------
% Macros
% ---------------------------

% fr: Oct 29
% macro for phonology of words derived by lexical rule

pattern_to_word(Pattern) macro  pattern_to_word((a_ Pattern)).




%%%
%%% Macros for words
%%%

% Adjectives

sia(Rel) := (word,                       
             synsem:loc:(cat:(head:a,
                              subj:[@ref_np(Index1)],
                              spr:[@deg_adv(Degree)],
                              subj_label:[np_case],
                              subj_index:Index1,
                              spr_label:[advb],
                              spr_index:Degree,
                              comps:[],
                              comps_labels:[],
                              comps_indices:[]),
                         cont:(Rel,
                               arg1:Index1,
                               degree:Degree))).

pp_adj(Rel,Pform,PP_label) := (word,                       
                      synsem:loc:(cat:(head:a,
                                       subj:[@ref_np(Index1)],
                                       spr:[@deg_adv(Degree)],
                                       comps:[@argm_pp(Index2,Pform)],
                                       subj_label:[np_case],
                                       subj_index:Index1,
                                       spr_label:[advb],
                                       spr_index:Degree,
                                       comps_labels:[PP_label],
                                       comps_indices:[Index2]),
                                  cont:(Rel,
                                        arg1:Index1,
                                        arg2:(Index2,index),
                                        degree:Degree))).

         
sra(Rel) := (word,
             synsem:loc:(cat:(head:a,
                              subj:[Subj],
                              spr:[@deg_adv(Degree)],
                              subj_label:[Subj_label],
                              subj_index:(Subj_Index),
                              spr_label:[advb],
                              spr_index:Degree,
                              comps:[(loc:(cat:(head:vform:inf,
                                subj:[Subj],
			        comps:[],
                                subj_label:[Subj_label],
                                subj_index:Subj_Index),
                           cont:(Rel2,rel)))],
                              comps_labels:[vp_inf],
                              comps_indices:[Rel2]), 
                         cont:(Rel,
                               arg1:Rel2,
                               degree:Degree))).



% Adverbs (only "very")

deg(Degree) := (word,
                synsem:loc:(cat:(head:adv,
                                 @saturated),
                            cont:Degree)).

% Complementizers

compl(Vform,Cont) := (word,
                      synsem:(loc:(cat:(head:c,
                                        subj:[],
                                        spr:[],
                                        subj_label:[],
                                       subj_index:none,
                                       spr_label:[],
                                       spr_index:none,
                                       comps:[(loc:(cat:(head:(v,
                                               vform:Vform),
                                         subj:[]),
                                    cont:Cont))],
                                    comps_labels:[s],
                                       comps_indices:[]), 
                                   cont:(Cont,
                                         proposition)))).


% Determiners


det(Index,Agr,Cont_label) := (word,                                            
                              synsem:(loc:(cat:(head:(d,
                                                      agr:Agr),
                               @saturated,
                               subj_label:[],
                               subj_index:none,
                               spr_label:[],
                               spr_index:none,
                               comps_labels:[],
                               comps_indices:[]), 
		          cont:Index,
		          cont_label:Cont_label))).

%%% Nouns

% Names



name(Index) := (word,
                synsem:(loc:(cat:(head:(n,
                                        agr:thd_sg,
                                        case:case),
                                  subj:[],
                                  spr:[],
                                  comps:[],
                                  subj_label:[],
                                  subj_index:none,
                                  spr_label:[],
                                  spr_index:none,
                                  comps_labels:[],
                                  comps_indices:[]), 
                             cont:(Index,
                                   index)))).
        
% Pronouns


ppron(Agr,Index,Case) := (word,
                      synsem:(loc:(cat:(head:(n,
                                              agr:Agr,
	                                      case:Case),
                                        subj:[],
                                        spr:[],
                                        comps:[],
                                        subj_index:none,
                                        spr_index:none,
                                        comps_indices:[]),
	                           cont:(Index,
                                         index)))).

ppron_it(Agr,Index,Case) := (word,
                      synsem:(loc:(cat:(head:(n,
                                              agr:Agr,
	                                      case:Case),
                                        subj:[],
                                        spr:[],
                                        comps:[],
                                        subj_index:none,
                                        spr_index:none,
                                        comps_indices:[]),
	                           cont:thing))).
it := (word,
       synsem:(loc:(cat:(head:(n,
                               agr:thd_sg,
                               case:case,
                               form:it),
	                       subj:[],
                               spr:[],
                               comps:[],
                               subj_index:none,
                               spr_index:none,
                            comps_indices:[]),                                       
	            cont:none))).

there := (word,
                      synsem:(loc:(cat:(head:(n,
                                              form:there),
                                        subj:[],
                                        spr:[],
                                        comps:[],
                                        subj_index:none,
                                        spr_index:none,
                                        comps_indices:[]),
	                           cont:none))).

f_s_ppron(Agr,Case,Index) := (word,
                             synsem:(loc:(cat:(head:(n,
                                                     agr:Agr,
	                                             case:Case),
                                        subj:[],
                                        spr:[],
                                        comps:[],
                                        subj_index:none,
                                        spr_index:none,
                                        comps_indices:[]),	                                             
	                                    cont:(Index,
                                                  index)))).


% Common nouns

cn_sg(Index,Cont_label) := (word,
              synsem:(loc:(cat:(head:(n,
                                      agr:thd_sg),
                                subj:[],
                                spr:[(@dp(Index))],
                                comps:[],
                                subj_label:[],
                                subj_index:none,
                                spr_label:[det],
                                spr_index:Index,
                                comps_labels:[],
                                comps_indices:[]),
                           cont:Index,
		           cont_label:Cont_label))).
		           
cn_pl(Index,Cont_label) := (word,
              synsem:(loc:(cat:(head:(n,
                                      agr:thd_pl),
                                subj:[],
                                spr:[(@dp(Index))],
                                comps:[],
                                subj_label:[],
                                subj_index:none,
                                spr_label:[det],
                                spr_index:Index,
                                comps_labels:[],
                                comps_indices:[]),
                           cont:Index,
		           cont_label:Cont_label))).

		           
% Prepositions                       

arg_mark_prep(Pform) := (word,
                         synsem:(loc:(cat:(head:(p,
                                                 form:Pform),
                                           subj:[],
                                           subj_label:[],                                           
                                           subj_index:none,
                                           spr:[],
                                           spr_label:[],                                           
                                           spr_index:none,
                                           comps:[(@ref_np(Index))],
                                           comps_labels:[np_acc],
                                           comps_indices:[Index]), 
                                      cont:(Index,index)))).


siv(Rel) := (word,
	          synsem:(loc:(cat:(head:(v,
                                          aux:minus,
                                          vform:base),
                                    subj:[(@ref_np(Index1))],
                                    comps:[],
                                    subj_index:Index1,
                                    subj_label:[np_case],
                                    spr_index:none,
                                    comps_indices:[]),
                               cont:(Rel,
                                     arg1:Index1)))).

stv(Rel) := (word,
	          synsem:(loc:(cat:(head:(v,
                                          aux:minus,
                                          vform:base),
                                    subj:[(@ref_np(Index1))],
                                    comps:[(@ref_np(Index2))],
                                    subj_index:Index1,
                                    subj_label:[np_case],
                                    comps_indices:[Index2],
                                    comps_labels:[np_acc],
                                    spr_index:none),                                    
                               cont:(Rel,
                                     arg1:Index1,
                                     arg2:Index2)))).

dtv(Rel) := (word,
	          synsem:loc:(cat:(head:(v,
                                         aux:minus,
                                         vform:base),
                                    subj: [@ref_np(Index1)],
                                    comps:[@ref_np(Index2),
                                           @ref_np(Index3)],
                                    subj_label:[np_case],
                                    comps_labels:[np_acc,np_acc],
                                    subj_index:Index1,
                                    spr_index:none,
                                    comps_indices:[Index2,Index3]),                                   
                              cont:(Rel,
                                    arg1:Index1,
                                    arg2:Index2,
                                    arg3:Index3))).

argm_piv(Rel,Pform,Pform_label) := (word,
	                synsem:loc:(cat:(head:(v,
                                               aux:minus,
                                               vform:base),
                                        subj: [@ref_np(Index1)],
                                        comps:[@argm_pp((Index2,
                                                         index),Pform)],   
                                        subj_label:[np_case],
                                        comps_labels:[Pform_label],
                                        subj_index:Index1,
                                        spr_index:none,
                                        comps_indices:[Index2]),                                         
                                    cont:(Rel,
                                          arg1:Index1,
                                          arg2:Index2))).


s_comp_v(Rel) := (word,
	               synsem:loc:(cat:(head:(v,
                                              aux:minus,
                                              vform:base),
                                        subj: [@ref_np(Index1)],
                                        comps:[(loc:(cat:head:c,
                                                      cont:Rel2))],
                                        subj_label:[np_case],
                                        comps_labels:[s],
                                        subj_index:Index1,
                                        spr_index:none,
                                        comps_indices:[Rel2]),                                        
			           cont:(Rel,
                                         arg1:Index1,
				         arg2:Rel2))).

argm_ptv(Rel,Pform,Pform_label) := (word,
	                synsem:loc:(cat:(head:(v,
                                               aux:minus,
                                               vform:base),
                                         subj: [@ref_np(Index1)],
                                         comps:[@ref_np(Index2),
                                                @argm_pp(Index3,Pform)],
                                         subj_label:[np_case],
                                         comps_labels:[np_acc,Pform_label],
                                         subj_index:Index1,
                                         spr_index:none,
                                         comps_indices:[Index2,Index3]),                                         
                                    cont:(Rel,
                                          arg1:Index1,
                                          arg2:Index2,
                                          arg3:(Index3,index)))).


srv(Rel) := (word,                                      
             synsem:loc:(cat:(head:(v,            
                                    aux:minus,
                                    vform:base),
                              subj: [Subj],
                              comps: [(loc:(cat:(head:vform:inf,
                                                 subj:[Subj],
                                                 subj_label:[(Subj_label)],
                                                 subj_index:Subj_Index,
			                         comps:[]),
                                            cont:(Rel2,rel)))],
                              subj_label:[Subj_label],
                              subj_index:Subj_index,
                              spr_label:[],
                              spr_index:none,
                              comps_indices:[Rel2]),         
                         cont:(Rel,
                               arg1:Rel2))).




orv(Rel) := (word,
             synsem:loc:(cat:(head:(v,                   
                                    aux:minus,
                                    vform:base),
                              subj: [@ref_np(Index1)],
                              comps: [Obj,
	             (loc:(cat:(head:vform:inf,
                                subj:[Obj],
			        comps:[],
                                subj_label:[Obj_label],
                                subj_index:Index2),
                           cont:(Rel2,rel)))],
                              subj_index:Index1,
                              spr_index:none,
                              comps_labels:[Obj_label,vp_inf],
                              comps_indices:[Index2,Rel2]),
                         cont:(Rel,
                               arg1:(Index1,index),
                               arg2:Rel2))).


scv(Rel) := (word,
             synsem:loc:(cat:(head:(v,
                                    aux:minus,
                                    vform:base),
                              subj: [@ref_np(Index1)],
                              comps: [
	             (loc:(cat:(head:vform:inf,
                                subj:[@ref_np(Index1)],
                                subj_label:[np_case],
                                subj_index:Index1,
			        comps:[]),
                           cont:(Rel2,rel)))],
                              subj_label:[np_case],
                              subj_index:Index1,
                              spr_label:[],
                              spr_index:none,
                              comps_labels:[vp_inf],
                              comps_indices:[Rel2]),                              
                         cont:(Rel,
                               arg1:Index1,
                               arg2:Rel2))).

ocv(Rel) := (word,
             synsem:loc:(cat:(head:(v,
                                    aux:minus,
                                    vform:base),
                              subj: [@ref_np(Index1)],
                              comps: [@ref_np(Index2),
	             (loc:(cat:(head:vform:inf,
                                subj:[@ref_np(Index2)],
                                subj_label:[np_case],
                                subj_index:Index2,
			        comps:[]),
                           cont:Rel2))],
                              subj_label:[np_case],
                              subj_index:Index1,
                              spr_index:none,
                              comps_labels: [np_acc,vp_inf],
                              comps_indices:[Index2,Rel2]), 
                         cont:(Rel,
                               arg1:Index1,
                               arg2:Index2,                                   
                               arg3:Rel2))).

% Rain verbs

rain_verb(Rel) :=  (word,
                    synsem:(loc:(cat:(head:(v,
                                            aux:minus,
                                            vform:base),
                                      subj:[(loc:(cat:head:(n,
                                                            form:it),
                                                  cont:none))],
                                      subj_label:list, % [n_it],
                                      subj_index:none,
                                      spr_label:[],
                                      spr_index:none,
                                      comps:[],
                                      comps_labels:[],
                                      comps_indices:[]), 
                                    cont:Rel))).

% There verbs

there_v(Rel) := (word,
	         synsem:(loc:(cat:(head:(v,
                                         aux:minus,
                                         vform:base),
                                   subj:[(loc:(cont:none,
                                               cat:(head:(n,
                                                          form:there,
                                                          agr:Agr))))],
                                   comps: [(@ref_np(Index),
                                           loc:cat:head:agr:Agr)],
                                   subj_label:[n_there],
                                   subj_index:none,
                                   spr_label:[],
                                   spr_index:none,
                                   comps_labels:[np_case],
                                   comps_indices:[Index]), 
                               cont:(Rel,
                                     arg1:Index)))).


%%% AUXILIARIES

% Be

be_progr_aux_pres(Agr,Vform,Subj_label) := (word,
                                                  synsem:loc:(cat:(head:(v,
                                                                         agr:Agr,
                                                                         aux:plus,
                                                                         vform:Vform),
                                                                   subj: [Subj],
                                                                   subj_label:[Subj_label],
                                                                   subj_index:Subj_index,
                                                                   spr_label:[],
                                                                   spr_index:none,
                                                                   comps:[(loc:(cat:(head:(v,
                                                                                           vform:prp),
                                                                                     subj:[Subj],
                                                                                     subj_label:[Subj_label],
                                                                                     subj_index:Subj_index,
                                                                                     comps:[]),
                                                                               cont:(Rel2,rel)))],
                                                                   comps_labels:[vp_prp],
                                                                   comps_indices:[Rel2]),
                                                              cont:(in_prog_rel,
                                                                    arg1:Rel2)),
                                                lex_ru:minus).

be_progr_aux_past(Agr,Vform,Subj_label) := (word,
                                                  synsem:loc:(cat:(head:(v,
                                                                         agr:Agr,
                                                                         aux:plus,
                                                                         vform:Vform),
                                                                   subj: [Subj],
                                                                   subj_label:[Subj_label],
                                                                   subj_index:Subj_index,
                                                                   spr_label:[],
                                                                   spr_index:none,
                                                                   comps:[(loc:(cat:(head:(v,
                                                                                           vform:prp),
                                                                                     subj:[Subj],
                                                                                     subj_label:[Subj_label],
                                                                                     subj_index:Subj_index,
                                                                                     comps:[]),
                                                                               cont:(Rel2,rel)))],
                                                                   comps_labels:[vp_prp],
                                                                   comps_indices:[Rel2]),
                                                              cont:(past,
                                                                    arg1:(in_prog_rel,
                                                                          arg1:Rel2))),
                                                lex_ru:minus).

be_progr_aux_nonfin(Vform,Subj_label) := (word,
                                                     synsem:loc:(cat:(head:(v,
                                                                            aux:plus,
                                                                            vform:Vform),
                                                                      subj:[Subj],
                                                                      subj_label:[Subj_label],
                                                                      subj_index:Subj_index,
                                                                      spr_label:[],
                                                                      spr_index:none,
                                                                      comps:[(loc:(cat:(head:(v,
                                                                                           vform:prp),
                                                                                     subj:[Subj],
                                                                                     subj_label:[Subj_label],
                                                                                     subj_index:Subj_index,
                                                                                     comps:[]),
                                                                               cont:(Rel2,rel)))],
                                                                      comps_labels:[vp_prp],
                                                                      comps_indices:[Rel2]),
                                                                cont:(in_prog_rel,
                                                                      arg1:Rel2)),
                                                  lex_ru:minus). 
                                                  
be_copula_aux_ap_pres(Agr,Vform,Subj_label) := (word,
                                                synsem:loc:(cat:(head:(v,
                                                                       agr:Agr,
                                                                       aux:plus,
                                                                       vform:Vform),
                                                                  subj:[Subj],
                                                                  subj_label:[Subj_label],
                                                                  subj_index:Subj_index,
                                                                  spr_label:[],
                                                                  spr_index:none,
                                                                  comps:[(loc:(cat:(head:a,
                                                                                    subj:[Subj],
                                                                                    subj_label:[Subj_label],
                                                                                    subj_index:Subj_index,
                                                                                    comps:[]),
                                                                               cont:(Rel2,rel)))],
                                                                     comps_labels:[ap],
                                                                     comps_indices:[Rel2]),            
                                                             cont:Rel2),
                                                      lex_ru:minus).                                                  
                                                   
                                                  
                                                      
be_copula_aux_ap_past(Agr,Vform,Subj_label) := (word,
                                                synsem:loc:(cat:(head:(v,
                                                                             agr:Agr,
                                                                             aux:plus,
                                                                             vform:Vform),
                                                                      subj:[Subj],
                                                                      subj_label:[Subj_label],
                                                                      subj_index:Subj_index,
                                                                      spr_label:[],
                                                                      spr_index:none,
                                                                      comps:[(loc:(cat:(head:a,
                                                                                       subj:[Subj],
                                                                                       subj_label:[Subj_label],
                                                                                       subj_index:Subj_index,
                                                                                       comps:[]),                                   
                                                                                 cont:(Rel2,rel)))],
                                                                     comps_labels:[ap],
                                                                     comps_indices:[Rel2]),            
                                                                  cont:(past,
                                                                        arg1:Rel2)),
                                                      lex_ru:minus).

be_copula_aux_ap_nonfin(Vform,Subj_label) := (word,
                                              synsem:loc:(cat:(head:(v,
                                                                     aux:plus,
                                                                     vform:Vform),
                                                               subj:[Subj],
                                                               subj_label:[Subj_label],
                                                               subj_index:Subj_index,
                                                               spr_label:[],
                                                               spr_index:none,
                                                               comps:[(loc:(cat:(head:a,
                                                                            subj:[Subj],
                                                                            subj_label:[Subj_label],
                                                                            subj_index:Subj_index,
                                                                            comps:[]),                                   
                                                                        cont:(Rel,rel)))],
                                                               comps_labels:[ap],
                                                               comps_indices:[Rel]),
                                                           cont:Rel),
                                              lex_ru:minus).

% Do                                       

do_aux_pres(Agr) :=   (word,
                       synsem:loc:(cat:(head:(v,
                                             agr:Agr,
                                             aux:plus,
                                             vform:fin),
                                        subj:[Subj],
                                        subj_label:[Subj_label],
                                        subj_index:Subj_index,
                                        spr_label:[],
                                        spr_index:none,
                                        comps:[(loc:(cat:(head:(vform:base,
                                                                aux:minus),
                                                         subj:[Subj],
                                                         subj_label:[Subj_label],
                                                         subj_index:Subj_index,
                                                         comps:[]),
                                                     cont:(Rel2,rel)))],
                                        comps_labels:[vp_base],
                                        comps_indices:[Rel2]),
                                   cont:Rel2)).       
                                    
do_aux_past :=   (word,
                  synsem:loc:(cat:(head:(v,
                                         aux:plus,
                                         vform:fin),
                                   subj:[Subj],
                                   subj_label:[Subj_label],
                                   subj_index:Subj_index,
                                   spr_label:[],
                                   spr_index:none,
                                   comps:[(loc:(cat:(head:(vform:base,
                                           aux:minus),
                                     subj:[Subj],
                                     subj_label:[Subj_label],
                                     subj_index:Subj_index,
                                     comps:[]),
                                cont:(Rel2,rel)))],
                                comps_labels:[vp_base],
                                   comps_indices:[Rel2]),
                              cont:(past,
                                    arg1:Rel2))).                                                       



% Have

have_aux_pres(Agr,Vform,Subj_label) := (word,
                                              synsem:loc:(cat:(head:(v,
                                                                     agr:Agr,
                                                                     aux:plus,
                                                                     vform:Vform),
                                                               subj:[Subj],
                                                               subj_label:[Subj_label],
                                                               subj_index:Subj_index,
                                                               spr_label:[],
                                                               spr_index:none,
                                                               comps:[(loc:(cat:(head:vform:pfp,
                                                                subj:[Subj],
                                                                subj_label:[Subj_label],
                                                                subj_index:Subj_index),
                                                           cont:(Rel2,rel)))],
                                                           comps_labels:[vp_pfp],
                                                               comps_indices:[Rel2]),
                                                          cont:(completed_rel,
                                                                arg1:Rel2)),
                                             lex_ru:minus).
                                             
have_aux_past(Agr,Vform,Subj_label) := (word,
                                              synsem:loc:(cat:(head:(v,
                                                                     agr:Agr,
                                                                     aux:plus,
                                                                     vform:Vform),
                                                               subj:[Subj],
                                                               subj_label:[Subj_label],
                                                               subj_index:Subj_index,
                                                               spr_label:[],
                                                               spr_index:none,
                                                               comps:[(loc:(cat:(head:vform:pfp,
                                                                subj:[Subj],
                                                                subj_label:[Subj_label],
                                                                subj_index:Subj_index),
                                                           cont:(Rel2,rel)))],
                                                           comps_labels:[vp_pfp],
                                                               comps_indices:[Rel2]),
                                                          cont:(past,
                                                                arg1:(completed_rel,
                                                                      arg1:Rel2))),
                                             lex_ru:minus).                                             

have_aux_nonfin(Vform,Subj_label) := (word,
                                                     synsem:loc:(cat:(head:(v,
                                                                            aux:plus,
                                                                            vform:Vform),
                                                                      subj:[Subj],
                                                                      subj_label:[Subj_label],
                                                                      subj_index:Subj_index,
                                                                      spr_label:[],
                                                                      spr_index:none,
                                                                      comps:[(loc:(cat:(head:vform:pfp,
                                                                subj:[Subj],
                                                                subj_label:[Subj_label],
                                                                subj_index:Subj_index),
                                                           cont:(Rel2,rel)))],
                                                           comps_labels:[vp_pfp],
                                                               comps_indices:[Rel2],
                                                                      comps_indices:[Rel2]),
                                                                cont:(completed_rel,
                                                                      arg1:Rel2)),
                                                  lex_ru:minus).

% will

will(Rel) := (word,                                      
             synsem:loc:(cat:(head:(v,            
                                    aux:plus,
                                    vform:fin),
                              subj:[Subj],
                              subj_label:[Subj_label],
                              subj_index:Subj_index,
                              spr_label:[],
                              spr_index:none,
                              comps:[(loc:(cat:(head:vform:base,
                                subj:[Subj],
                                subj_label:[Subj_label],
                                subj_index:Subj_index,
			        comps:[]),
                           cont:(Rel2,rel)))],
                              comps_labels:[vp_base],
                              comps_indices:[Rel2]),         
                         cont:(Rel,
                               arg1:Rel2)),
             lex_ru:minus).   


% The infinitive marker

inf_to :=    (word,
              synsem:loc:(cat:(head:(v,
                                     aux:plus,
                                     vform:inf),
                               subj:[Subj],
                               subj_label:[Subj_label],
                               subj_index:Subj_index,
                               spr_label:[],
                               spr_index:none,
                               comps:[(loc:(cat:(head:vform:base,
                                                 subj:[Subj],
                                                 subj_label:[Subj_label],
                                                 subj_index:Subj_index,
                                                comps:[]),
                                            cont:(Rel,rel)))],
                               comps_labels:[vp_base],
                               comps_indices:[Rel]),
                           cont:Rel)).


saturated := (subj:e_list,
              spr:e_list,
              comps:e_list).
      
%%%
%%% Macros for valents
%%%

dp(Index) :=  (loc:(cat:(head:d,
                         subj:e_list,
                         spr:e_list,
                         comps:e_list),
                    cont:Index)).

np(Index) := (loc:(cat:(head:n,
                        subj:[],
                        spr:[],
                        comps:[]),
                   cont:Index)).

ref_np(Index) := (loc:(cat:(head:n,
                        subj:[],
                        spr:[],
                        comps:[]),
                   cont:(Index,
                         index))).

argm_pp(Index,Pform) := (loc:(cat:(head:(p,
                                         form:Pform),
                                   subj:[],
                                   spr:[]),
                              cont:Index)).


vp(Cont-sem_obj):= (loc:(cat:(head:v,
                              subj:[@np(_)],
                              spr:[],
                              comps:[])),
                         cont:Cont).

xp(Subj-synsem,Cont-sem_obj):= (loc:(cat:(subj:[Subj],
					  spr:[],
					  comps:[]),
				     cont:Cont)).

s_fin := (loc:(cat:(head:(v,
                          vform:fin),
                    subj:[],
                    spr:[],
                    comps:[]))).

to_inf := (loc:(cat:(head:(v,
                           vform:inf),
                     spr:[],
                     comps:[]))).

deg_adv(Degree) := (loc:(cat:head:adv,
                    cont:Degree)).


% The root macro

root := (synsem:(loc:(cat:head:(v,
                                vform:fin),
                      cont:message))).


% The Core Clause Macro


core_cl := (synsem:loc:cat:head:(v,  
                                 vform:clausal)).


