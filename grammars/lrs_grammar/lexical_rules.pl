% -*-trale-prolog-*-





%%%
%%% Lexical rules for verbs
%%%


base_rule lex_rule
(verb_lexeme,
 synsem:Synsem,
 arg_st:Arg_st)
**>
(word,
 synsem:(Synsem,
         loc:cat:head:(vform:bare,
                       pred:minus)),
 arg_st:Arg_st)
morphs
  W becomes W.

non_third_sg_rule lex_rule
(verb_lexeme,
 synsem:Synsem,
 arg_st:Arg_st)
**>
(word,
 synsem:(Synsem,
         loc:cat:head:(vform:fin,
		       agr:non_third_sg,
                       pred:minus)),
 arg_st:Arg_st)
morphs
  W becomes W.


third_sg_rule lex_rule
(verb_lexeme,
 synsem:Synsem,
 arg_st:Arg_st)
**>
(word,
 synsem:(Synsem,
         loc:cat:head:(vform:fin,
		       agr:third_sg,
                       pred:minus)),
 arg_st:Arg_st)
morphs
  be becomes is,
  have becomes has,
  annoy becomes annoys,
 (W,y) becomes (W,ies),
  W becomes (W,s).


past_rule lex_rule
(verb_lexeme,
 synsem:Synsem,
 arg_st:Arg_st)
**>
(word,
 synsem:(Synsem,
         loc:cat:head:(vform:fin,
                       pred:minus)),
 arg_st:Arg_st)
morphs
  be becomes was,
  beat becomes beat,
  do becomes did,
  eat becomes ate,
  give becomes gave,
  have becomes had,
  leap becomes leapt,
  meet becomes met,
  see becomes saw,
 (W,y) becomes (W,ied),
 (W,e) becomes (W,ed),
  W becomes (W,ed).


prog_rule lex_rule
(verb_lexeme,
 synsem:Synsem,
 arg_st:Arg_st)
**>
(word,
 synsem:(Synsem,
         loc:cat:head:(vform:prog,
                       pred:plus)),
 arg_st:Arg_st)
morphs
 (W,e) becomes (W,ing),
  W becomes (W,ing).


perf_rule lex_rule
(verb_lexeme,
 synsem:Synsem,
 arg_st:Arg_st)
**>
(word,
 synsem:(Synsem,
         loc:cat:head:(vform:perf,
                       pred:minus)),
 arg_st:Arg_st)
morphs
  be becomes been,
  beat becomes beaten,
  buy becomes bought,
  eat becomes eaten,
  give becomes given,
  have becomes had,
  leap becomes leapt,
  meet becomes met,
  see becomes seen,
  show becomes shown,
 (W,y) becomes (W,ied),
 (W,e) becomes (W,ed),
  W becomes (W,ed).


% Short passives of transitive verbs

short_pass lex_rule
(verb_lexeme,
 synsem:(loc:(cat:head:(verb,
		        aux:minus),
              cont:Cont),
	 non_loc:Nloc),
 arg_st:[(Subj,
          loc:cat:head:noun),
         (Obj,
          loc:cat:head:noun)|Compl])
**>
(word,
 synsem:(loc:(cat:head:(verb,
		     aux:minus,
		     vform:pass,
		     pred:plus),
           cont:Cont),
      non_loc:Nloc),
 arg_st:[Obj|Compl])
morphs
  beat becomes beaten,
  buy becomes bought,
  eat becomes eaten,
  give becomes given,
  meet becomes met,
  see becomes seen,
  show becomes shown,
 (W,y) becomes (W,ied),
 (W,e) becomes (W,ed),
  W becomes (W,ed).


% Long passives of transitive verbs

long_pass lex_rule
(verb_lexeme,
 synsem:(loc:(cat:head:(verb,
		        aux:minus),
              cont:Cont),
	 non_loc:Nloc),
 arg_st:[(Subj,
          loc:cat:head:noun),
         (Obj,
          loc:cat:head:noun)|Compl])
**>
(word,
 synsem:(loc:(cat:head:(verb,
		     aux:minus,
		     vform:pass,
		     pred:plus),
           cont:Cont),
      non_loc:Nloc),
 arg_st: append([Obj|Compl],[(loc:cat:(head:(prep,
                                             lex_class:by),
                                       val:(subj:[],
                                            spr:[],
                                            comps:[])))]))
morphs
  beat becomes beaten,
  buy becomes bought,
  eat becomes eaten,
  give becomes given,
  meet becomes met,
  see becomes seen,
  show becomes shown,
 (W,y) becomes (W,ied),
 (W,e) becomes (W,ed),
  W becomes (W,ed).





%%%
%%% Lexical rules for nouns
%%%


singular_rule lex_rule
(noun_lexeme,
 synsem:Synsem,
 arg_st:Arg_st)
**>
(word,
 synsem:(Synsem,
         loc:cat:head:agr:third_sg),
 arg_st:Arg_st)
morphs
  W becomes W.


plural_rule lex_rule
(noun_lexeme,
 synsem:Synsem,
 arg_st:Arg_st)
**>
(word,
 synsem:(Synsem,
         loc:cat:head:agr:third_pl),
 arg_st:Arg_st)
morphs
 (W,s) becomes (W,ses),
 (W,y) becomes (W,ies),
  W becomes (W,s).


%% POSSESSIVE PRONOUNS

poss lex_rule
(word,
 synsem:loc:(cat:(head:(Head,
		        noun),
	          val:(subj:Subj,
		       spr:[(loc:cat:head:det)],
                       comps:Comps)),
             cont:Cont))
**>
(word,
 synsem:loc:(cat:(head:(Head,
		        noun),
	          val:(subj:Subj,
		       spr:[(loc:cat:head:(noun,
				           case:poss))],
		       comps:Comps)),
             cont:Cont))
morphs
  W becomes W.



%%%
%%% Other lexical rules
%%%

%% IT-EXTRAPOSITION

it_ex lex_rule
(word,
 synsem:loc:(cat:head:(Head,
		   verb;adj),
             cont:Cont),
 arg_st:[(Clause,
          loc:cat:(head:verb,
		   marking:that,
		   val:(subj:[],
			spr:[],
			comps:[])))|Rest])
**>
(word,
 synsem:loc:(cat:head:Head,
             cont:Cont),
 arg_st:append([(loc:cat:head:lex_class:it)|Rest],[Clause]))
morphs
  W becomes W.












/*





% Long passive

long_pass ##
(v_lx,
 synsem:(loc:cat:head:(verb,
		       aux:minus,
		       form:Form),
	 nloc:Nloc),
 arg_st:[@np,(Obj,@np)|Compl])
**>
(word,
 synsem:(loc:cat:head:(verb,
		       aux:minus,
		       vform:pass,
		       pol:pos,
		       pred:plus,
		       form:Form),
	 nloc:Nloc),
 arg_st: append([(Obj,@np)|Compl],[(loc:cat:head:form:by)]))
morphs
  beat becomes beaten,
  buy becomes bought,
  give becomes given,
  show becomes shown,
 (W,y) becomes (W,ied),
 (W,e) becomes (W,ed),
  W becomes (W,ed).



*/
