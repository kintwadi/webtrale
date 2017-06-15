
%% TO-DO: THE CONSTRAINT FROM FRANK'S REFERENCE GRAMMAR THAT ASSIGNS
%% A PHONOLOGY TO PHRASES


%% PHRASES: ALL DAUGHTERS OF A PHRASE ARE SYNTACTIC SIGNS


phrase *> (dtrs: list_of_syntactic_signs).


%% HEAD FEATURE PRINCIPLE

headed_ph *> (synsem:loc:cat:head:Head,
	      hd_dtr:(synsem:loc:cat:head:Head)).

%% THE SEMANTICS PRINCIPLE

headed_ph *> (synsem:loc:cont:Cont,
	      hd_dtr:(synsem:loc:cont:Cont)).



%% THE MARKING PRINCIPLE

phrase *> ((hd_marker_ph)
	  ;
	   (synsem:loc:cat:marking:Marking,
            hd_dtr:synsem:loc:cat:marking:Marking)).



(hd_subj_ph,
 dtrs:hd:phon:e_list) *> (subj_gap:plus).

(hd_subj_ph,
 dtrs:hd:phon:ne_list) *> (subj_gap:minus).

%% I FORMULATED THE PRINCIPLE BELOW, BECAUSE I WANT TRALE TO DISAMBIGUATE
%% THE AGREEMENT AT THE S-LEVEL

hd_subj_ph *> (synsem:loc:cat:head:agr:(first_sg;sec_sg;third_sg;
			                first_pl;sec_pl;third_pl)).


                         
%% HEAD-FILLER PHRASES

hd_fill_ph *> (synsem:(loc:cat:val:Val,
	               non_loc:(inher:slash:[],
		             to_bind:slash:[])),
               hd_dtr:(Hd_dtr,
                       synsem:(loc:cat:(head:verb,
		                        val:(Val,
			                     subj:[],
			                     spr:[],
			                     comps:[])),
	                       non_loc:(inher:slash:[Loc],
		                        to_bind:slash:[Loc]))),
               non_hd_dtrs:[(Non_hd_dtr,
                             synsem:(loc:Loc,
	                     non_loc:(inher:slash:[],
		                      to_bind:slash:[])))],
               dtrs:[Non_hd_dtr,Hd_dtr]).



%% THE ARGUMENT REALIZATION PRINCIPLE

word *> (synsem:loc:cat:val:(subj:L1,
			     spr:L2,
			     comps:L3),
	 arg_st:L4)
goal
     arg_real_principle(L1,L2,L3,L4).


%% VERBAL WORDS HAVE ONE SUBJ AND NO SPECIFIER

(word,
 synsem:loc:cat:head:verb) *> (synsem:loc:cat:val:(subj:[_],
				                   spr:[])).

%% THE FORMULATION BELOW IS CLUNKY. IT WOULD BE MORE ELEGANT TO IMPOSE
%% THIS CONDITION ON ALL NON-HEAD-DTRS OF PHRASES, AMONG OTHERS, BECAUSE
%% THIS WOULD ALSO COVER MODIFIERS. WHAT IS THE BEST WAY
%% TO ACCESS THOSE: A NEW ATTRIBUTE "NON-HD-DTRS"? 

%% SATURATION CONDITION

(word,
 arg_st:[_]) *> (arg_st:[(loc:cat:val:(spr:[],
			               comps:[]))]).

(word,
 arg_st:[_,_]) *> (arg_st:[(loc:cat:val:(spr:[],
			                 comps:[])),
		           (loc:cat:val:(spr:[],
			                 comps:[]))]).

(word,
 arg_st:[_,_,_]) *> (arg_st: [(loc:cat:val:(spr:[],
			                    comps:[])),
		              (loc:cat:val:(spr:[],
			                    comps:[])),
		              (loc:cat:val:(spr:[],
			                    comps:[]))]).	       
		
%% VERBS ARE NOT MODIFIERS (TEMPORARY: TO EXLUDE UNWANTED PARSES)

(word,
 synsem:loc:cat:head:verb) *> (synsem:loc:cat:head:mod:[]).


%% SUBJECTS OF FINITE VERBS
%% APPLIES ONLY TO SUBJECTS WHICH ARE NPs, NOT TO SENTENTIAL SUBJECTS

(word,
 synsem:loc:cat:head:(verb,
		      vform:fin),
 arg_st:hd:(loc:cat:head:noun))   *> (synsem:loc:cat:head:agr:Agr,
				      arg_st:hd:loc:cat:head:(case:nom,
							      agr:Agr)).


%% ACCUSATIVE CASE PRINCIPLE


%% First NP complement

(word,
 synsem:loc:cat:val:comps:[(loc:cat:head:noun)]) *>

(word,
 synsem:loc:cat:val:comps:[(loc:cat:head:case:acc)]).


%% Second NP complement

(word,
 synsem:loc:cat:val:comps:tl:hd:(loc:cat:head:noun)) *>

(word,
 synsem:loc:cat:val:comps:tl:hd:(loc:cat:head:case:acc)).




%% Non-traces have empty SLASH values

(word,                                                    
 phon:ne_list) *> (synsem:non_loc:(inher:slash:[],
			           to_bind:slash:[])).


%% Verbal traces must be non-finite

(word,
 phon:[],
 synsem:loc:cat:head:verb) *> (synsem:loc:cat:head:vform:non_fin).



%% Non-markers have an unmarked MARKING value


word *> lexical_marking_principle.



%% Semantics

% Adjectives

(word,
 synsem:loc:cat:head:adj) *> (synsem:loc:cont:adj_cont).

% Determiners

(word,
 synsem:loc:cat:head:det) *> (synsem:loc:cont:det_cont).

% Nouns

noun_lexeme *> (synsem:loc:cont:noun_cont).

% Verbs and auxiliaries

(lexical_sign,
 synsem:loc:cat:head:verb) *> (synsem:loc:cont:verb_cont).


%% The Wh-feature

(word,
 synsem:loc:cat:head:(adj;verb;prep)) *> (synsem:non_loc:inher:wh:[]).

(word,
 synsem:loc:cat:head:lex_class:non_pron) *> (synsem:non_loc:inher:wh:[]).

(phrase,
 synsem:loc:cat:(head:verb,
                 val:(subj:[],
                     spr:[],
                     comps:[]))) *> (synsem:non_loc:inher:wh:[]).


