:- multifile '--->'/2.




%% Nominative pronouns


i ---> (word,
        phon:[(a_ i)],
	synsem:(loc:(cat:(head:(noun,
                             lex_class:pron,
	                     agr:first_sg,
		             case:nom),
		       val:(subj:[],
			    spr:[],
			    comps:[]))),
                non_loc:inher:wh:[]),
	arg_st:[]).


you ---> (word,
          phon:[(a_ you)],             
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:per:sec,
			       case:plain),
			 val:(subj:[],
			      spr:[],
			      comps:[]))),
                 non_loc:inher:wh:[]),                  
	  arg_st:[]).


he ---> (word,
         phon:[(a_ he)],            
	 synsem:(loc:(cat:(head:(noun,
                              lex_class:pron,
	                      agr:third_sg,
		              case:nom),
			val:(subj:[],
		             spr:[],
		             comps:[]))),
                 non_loc:inher:wh:[]),                 
	 arg_st:[]).


she ---> (word,
          phon:[(a_ she)],           
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:third_sg,
			       case:nom),
			 val:(subj:[],
			      spr:[],
			      comps:[]))),
                  non_loc:inher:wh:[]),                  
	  arg_st:[]).


it ---> (word,
         phon:[(a_ it)],            
	 synsem:(loc:(cat:(head:(noun,
                              lex_class:pron,
	                      agr:third_sg,
			      case:plain),
			val:(subj:[],
		             spr:[],
		             comps:[]))),
                 non_loc:inher:wh:[]),                 
	 arg_st:[]).



it ---> (word,
         phon:[(a_ it)],            
	 synsem:(loc:(cat:(head:(noun,
                              lex_class:it,
	                      agr:third_sg,
			      case:plain),
			val:(subj:[],
		             spr:[],
		             comps:[])),
                      cont:none),
                 non_loc:inher:wh:[]),                 
	 arg_st:[]).


we ---> (word,
         phon:[(a_ we)],            
	 synsem:(loc:(cat:(head:(noun,
                              lex_class:pron,
	                      agr:first_pl,
		              case:nom),
			val:(subj:[],
		             spr:[],
		             comps:[]))),
                 non_loc:inher:wh:[]),                 
	 arg_st:[]).




they ---> (word,
           phon:[(a_ they)],              
	   synsem:(loc:(cat:(head:(noun,
                                lex_class:pron,
	                        agr:third_pl,
				case:nom),
			  val:(subj:[],
			       spr:[],
			       comps:[]))),
                   non_loc:inher:wh:[]),                   
	   arg_st:[]).


%% Accusative pronouns


me ---> (word,
         phon:[(a_ me)],            
	 synsem:(loc:(cat:(head:(noun,
                              lex_class:pron,
	                      agr:first_sg,
		              case:acc),
		        val:(subj:[],
		             spr:[],
		             comps:[]))),
                 non_loc:inher:wh:[]),                 
	 arg_st:[]).

him ---> (word,
          phon:[(a_ him)],             
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:third_sg,
			       case:acc),
			 val:(subj:[],
			      spr:[],
		              comps:[]))),
                 non_loc:inher:wh:[]),                  
	  arg_st:[]).


her ---> (word,
          phon:[(a_ her)],             
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:third_sg,
			       case:acc),
			 val:(subj:[],
			      spr:[],
			      comps:[]))),
                 non_loc:inher:wh:[]),                  
	  arg_st:[]).


us ---> (word,
         phon:[(a_ us)],            
	 synsem:(loc:(cat:(head:(noun,
                              lex_class:pron,
	                      agr:first_pl,
			      case:acc),
		        val:(subj:[],
		             spr:[],
		             comps:[]))),
                 non_loc:inher:wh:[]),                 
	 arg_st:[]).


them ---> (word,
           phon:[(a_ them)],              
	   synsem:(loc:(cat:(head:(noun,
                                lex_class:pron,
	                        agr:third_pl,
				case:acc),
			  val:(subj:[],
			       spr:[],
			       comps:[]))),
                   non_loc:inher:wh:[]),                   
	   arg_st:[]).


%% Possessive pronouns


my ---> (word,
         phon:[(a_ my)],            
	 synsem:(loc:(cat:(head:(noun,
                              lex_class:pron,
	                      agr:first_sg,
			      case:poss),
			val:(subj:[],
		             spr:[],
		             comps:[]))),
                 non_loc:inher:wh:[]),                 
	 arg_st:[]).


your ---> (word,
	   synsem:(loc:(cat:(head:(noun,
                                lex_class:pron,
	                        agr:(per:third),
				case:poss),
			  val:(subj:[],
			       spr:[],
			       comps:[]))),
                 non_loc:inher:wh:[]),                   
	   arg_st:[]).


his ---> (word,
          phon:[(a_ his)],             
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:third_sg,
			       case:poss),
			 val:(subj:[],
		              spr:[],
		              comps:[]))),
                  non_loc:inher:wh:[]),                  
	  arg_st:[]).


her ---> (word,
          phon:[(a_ her)],             
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:third_sg,
			       case:poss),
			 val:(subj:[],
		             spr:[],
		             comps:[]))),
                  non_loc:inher:wh:[]),                  
	  arg_st:[]).


its ---> (word,
          phon:[(a_ its)],             
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:third_sg,
			       case:poss),
			 val:(subj:[],
			      spr:[],
			      comps:[]))),
                  non_loc:inher:wh:[]),                  
	  arg_st:[]).


our ---> (word,
          phon:[(a_ our)],             
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:first_pl,
			       case:poss),
			 val:(subj:[],
			      spr:[],
			      comps:[]))),
                  non_loc:inher:wh:[]),                  
	  arg_st:[]).


their ---> (word,
            phon:[(a_ their)],               
	    synsem:(loc:(cat:(head:(noun,
                                 lex_class:pron,
	                         agr:third_pl,
		                 case:poss),
			   val:(subj:[],
				spr:[],
				comps:[]))),
                   non_loc:inher:wh:[]),                    
	    arg_st:[]).


%% The expletive pronoun "there"


there ---> (word,
            phon:[(a_ there)],               
	    synsem:(loc:(cat:(head:(noun,
                                 lex_class:there,
	                         agr:per:third,
				 case:plain),
			   val:(subj:[],
				spr:[],
				comps:[])),
                         cont:none),
                   non_loc:inher:wh:[]),                    
	   arg_st:[]).


%% Wh-pronouns



what ---> (word,
           phon:[(a_ what)],              
	   synsem:(loc:(cat:(head:(noun,
                                lex_class:pron,
	                        agr:third_sg,
				case:plain),
			  val:(subj:[],
			       spr:[],
			       comps:[]))),
                   non_loc:inher:wh:[wh]),                                     
	  arg_st:[]).

who ---> (word,
          phon:[(a_ who)],             
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:third_sg,
			       case:plain),
			 val:(subj:[],
			      spr:[],
			      comps:[]))),
                  non_loc:inher:wh:[wh]),                  
	 arg_st:[]).



whose ---> (word,
            phon:[(a_ whose)],             
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:pron,
	                       agr:agr,
			       case:poss),
			 val:(subj:[],
			      spr:[],
			      comps:[]))),
                  non_loc:inher:wh:[wh]),                                    
	 arg_st:[]).


