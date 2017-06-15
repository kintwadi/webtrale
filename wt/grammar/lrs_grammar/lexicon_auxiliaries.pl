:- multifile '--->'/2.


%%%
%%% Be, existential
%%%

is ---> (word,
         phon:[(a_ is)],
	 synsem:(loc:(cat:(head:(verb,
			      aux:plus,
			      vform:fin,
			      agr:third_sg,
                              lex_class:none)))),
	 arg_st:[(loc:(cat:head:lex_class:there,
                       cont:none)),
		 (loc:(cat:(head:noun,
			    val:(subj:[],
				 spr:[],
				 comps:[])),
                       cont:noun_cont))]).

%%%
%%% Be, progressive
%%%

be ---> (word,
         phon:[(a_ be)],
	 synsem:(loc:(cat:(head:(verb,
		              aux:plus,
			      vform:bare,
                              lex_class:none)))),
	 arg_st:[(Subj),
		 (loc:(cat:(head:(verb,
				  vform:prog),
			    val:(subj:[Subj],
				 spr:[],
		                 comps:[]))))]).

are ---> (word,
          phon:[(a_ are)],             
	  synsem:(loc:(cat:(head:(verb,
			       aux:plus,
			       vform:fin,
			       agr:((per:sec)
				    ;
				    (num:pl)),
                               lex_class:none)))),
	  arg_st:[(Subj),
		  (loc:(cat:(head:(verb,
				   vform:prog),
			     val:(subj:[Subj],
				  spr:[],
		                  comps:[]))))]).

been ---> (word,
           phon:[(a_ been)],              
	   synsem:(loc:(cat:(head:(verb,
				aux:plus,
				vform:perf,
                                lex_class:none)))),
           arg_st:[(Subj),
		   (loc:(cat:(head:(verb,
				    vform:prog),
			      val:(subj:[Subj],
				   spr:[],
		                   comps:[]))))]).

is ---> (word,
         phon:[(a_ is)],            
	 synsem:(loc:(cat:(head:(verb,
			      aux:plus,
			      vform:fin,
			      agr:third_sg,
                              lex_class:none)))),
	 arg_st:[(Subj),
		 (loc:(cat:(head:(verb,
				  vform:prog),
			    val:(subj:[Subj],
				 spr:[],
		                 comps:[]))))]).

was ---> (word,
          phon:[(a_ was)],             
	  synsem:(loc:(cat:(head:(verb,
			       aux:plus,
			       vform:fin,
			       agr:third_sg,
                               lex_class:none)))),
	  arg_st:[(Subj),
		  (loc:(cat:(head:(pred:plus),
			     val:(subj:[Subj],
				  spr:[],
		                  comps:[]))))]).


%%%
%%% Do, do-support

do ---> (word,
         phon:[(a_ do)],            
	 synsem:(loc:(cat:(head:(verb,
		              aux:plus,
		              vform:fin,
                              lex_class:none,
	                      agr:non_third_sg)))),
	 arg_st:[(Subj),
		 (loc:(cat:(head:(verb,
				  vform:bare,
				  aux:minus),
			    val:(subj:[Subj],
				 spr:[],
                                 comps:[]))))]).

does ---> (word,
           phon:[(a_ does)],              
	   synsem:(loc:(cat:(head:(verb,
				aux:plus,
				vform:fin,
                                lex_class:none,
	                        agr:third_sg)))),
           arg_st:[(Subj),
		   (loc:(cat:(head:(verb,
				    vform:bare,
				    aux:minus),
			      val:(subj:[Subj],
				   spr:[],
                                   comps:[]))))]).

did ---> (word,
          phon:[(a_ did)],             
	  synsem:(loc:(cat:(head:(verb,
			       aux:plus,
			       vform:fin,
                               lex_class:none)))),
          arg_st:[(Subj),
		  (loc:(cat:(head:(verb,
				   vform:bare,
				   aux:minus),
			     val:(subj:[Subj],
				  spr:[],
                                  comps:[]))))]).


%%%
%%% Have, perfective
%%%

has ---> (word,
          phon:[(a_ has)],             
	  synsem:(loc:(cat:(head:(verb,
			       aux:plus,
			       vform:fin,
                               lex_class:none,
	                       agr:third_sg)))),
	  arg_st:[(Subj),
		  (loc:(cat:(head:(verb,
				   vform:perf),
			     val:(subj:[Subj],
				  spr:[],
			          comps:[]))))]).


had ---> (word,
          phon:[(a_ had)],             
	  synsem:(loc:(cat:(head:(verb,
			       aux:plus,
			       vform:fin,
                               lex_class:none)))),
	  arg_st:[(Subj),
		  (loc:(cat:(head:(verb,
				   vform:perf),
			     val:(subj:[Subj],
				  spr:[],
			          comps:[]))))]).


have ---> (word,
           phon:[(a_ have)],              
	   synsem:(loc:(cat:(head:(verb,
				aux:plus,
				vform:bare,
                                lex_class:none)))),
	   arg_st:[(Subj),
		   (loc:(cat:(head:(verb,
				    vform:perf),
			      val:(subj:[Subj],
				   spr:[],
			           comps:[]))))]).



%%%
%%% Modal auxiliaries
%%% 

can ---> (word,
          phon:[(a_ can)],             
	  synsem:(loc:(cat:(head:(verb,
			       aux:plus,
			       vform:fin,
                               lex_class:none)))),
          arg_st:[(Subj),
		  (loc:(cat:(head:(verb,
				   vform:bare),
			     val:(subj:[Subj],
				  spr:[],
			          comps:[]))))]).



should ---> (word,
             phon:[(a_ should)],                
	     synsem:(loc:(cat:(head:(verb,
				  aux:plus,
				  vform:fin,
                                  lex_class:none)))),
	    arg_st:[(Subj),
		    (loc:(cat:(head:(verb,
				     vform:bare),
			       val:(subj:[Subj],
				    spr:[],
			            comps:[]))))]).


will ---> (word,
           phon:[(a_ will)],              
	   synsem:(loc:(cat:(head:(verb,
				aux:plus,
				vform:fin,
                                lex_class:none)))),
	   arg_st:[(Subj),
		   (loc:(cat:(head:(verb,
				    vform:bare),
			      val:(subj:[Subj],
				   spr:[],
			           comps:[]))))]).

%%%
%%% The infinitive marker
%%%


to ---> (word,
         phon:[(a_ to)],            
	 synsem:(loc:(cat:(head:(verb,
			      aux:plus,
			      vform:inf,
                              lex_class:none)))),
	 arg_st:[(Subj),
		 (loc:(cat:(head:(verb,
				  vform:bare),
			    val:(subj:[Subj],
				 spr:[],
			         comps:[]))))]).


