:- multifile '--->'/2.


%% Common nouns

belief ---> (noun_lexeme,
             phon:[(a_ belief)],
	     synsem:(loc:(cat:(head:(noun,
                                  lex_class:non_pron,
				  case:plain,
				  agr:Agr),
			    val:(subj:[],
				 spr:[(loc:cat:head:(det,
						     agr:Agr))],
				 comps:[]))))).


breakfast ---> (noun_lexeme,
                phon:[(a_ breakfast)],                   
	        synsem:(loc:(cat:(head:(noun,
                                     lex_class:non_pron,
				     case:plain,
				     agr:Agr),
			       val:(subj:[],
				    spr:[(loc:cat:head:(det,
						        agr:Agr))],
				    comps:[]))))).


cake ---> (noun_lexeme,
           phon:[(a_ cake)],
	   synsem:(loc:(cat:(head:(noun,
                                lex_class:non_pron,
				case:plain,
				agr:Agr),
			  val:(subj:[],
			       spr:[(loc:cat:head:(det,
						   agr:Agr))],
			       comps:[]))))).

claim ---> (noun_lexeme,
            phon:[(a_ claim)],               
	    synsem:(loc:(cat:(head:(noun,
                                 lex_class:non_pron,
				 case:plain,
				 agr:Agr),
			   val:(subj:[],
				spr:[(loc:cat:head:(det,
						    agr:Agr))],
				comps:[]))))).

friend ---> (noun_lexeme,
             phon:[(a_ friend)],                
	     synsem:(loc:(cat:(head:(noun,
                                  lex_class:non_pron,
				  case:plain,
				  agr:Agr),
			    val:(subj:[],
				 spr:[(loc:cat:head:(det,
						     agr:Agr))],
				 comps:[]))))).

king ---> (noun_lexeme,
           phon:[(a_ king)],              
	   synsem:(loc:(cat:(head:(noun,
                                lex_class:non_pron,
				case:plain,
				agr:Agr),
			  val:(subj:[],
			       spr:[(loc:cat:head:(det,
						   agr:Agr))],
			       comps:[(loc:cat:head:prep)]))))).

letter ---> (noun_lexeme,
             %phon:[(a_ letter)],
	     synsem:(loc:(cat:(head:(noun,
                                  lex_class:non_pron,
				  case:plain,
				  agr:Agr),
			    val:(subj:[],
			         spr:[(loc:cat:head:(det,
						     agr:Agr))],
			         comps:[]))))).

murderer ---> (noun_lexeme,
               phon:[(a_ murderer)],                  
	       synsem:(loc:(cat:(head:(noun,
                                    lex_class:non_pron,
				    case:plain,
				    agr:Agr),
			      val:(subj:[],
				   spr:[(loc:cat:head:(det,
						       agr:Agr))],
				   comps:[]))))).

people ---> (word,
             phon:[(a_ people)],                
	     synsem:(loc:(cat:(head:(noun,
                                  lex_class:non_pron,
				  case:plain,
				  agr:(Agr,
				       third_pl)),
			    val:(subj:[],
				 spr:[(loc:cat:head:(det,
						        agr:Agr))],
				 comps:[]))))).



person ---> (noun_lexeme,
             phon:[(a_ person)],                
	     synsem:(loc:(cat:(head:(noun,
                                  lex_class:non_pron,
				  case:plain,
				  agr:Agr),
			    val:(subj:[],
				 spr:[(loc:cat:head:(det,
						     agr:Agr))],
				 comps:[]))))).

senator ---> (noun_lexeme,
              phon:[(a_ senator)],                 
	      synsem:(loc:(cat:(head:(noun,
                                   lex_class:non_pron,
				   case:plain,
				   agr:Agr),
			     val:(subj:[],
				  spr:[(loc:cat:head:(det,
						      agr:Agr))],
				  comps:[]))))).

student ---> (noun_lexeme,
              phon:[(a_ student)],                 
	      synsem:(loc:(cat:(head:(noun,
                                   lex_class:non_pron,
				   case:plain,
				   agr:Agr),
			     val:(subj:[],
				  spr:[(loc:cat:head:(det,
					  	      agr:Agr))],
				  comps:[(loc:cat:head:prep)]))))).


threat ---> (noun_lexeme,
             phon:[(a_ threat)],                
	     synsem:(loc:(cat:(head:(noun,
                                  lex_class:non_pron,
				  case:plain,
				  agr:Agr),
			    val:(subj:[(loc:cat:head:noun)],
				 spr:[(loc:cat:head:(det,
						     agr:Agr))],
				 comps:[]))))).

visit ---> (noun_lexeme,
            phon:[(a_ visit)],               
	    synsem:(loc:(cat:(head:(noun,
                                 lex_class:non_pron,
				 case:plain,
				 agr:Agr),
			   val:(subj:[(loc:cat:head:noun)],
				spr:[(loc:cat:head:(det,
						    agr:Agr))],
				comps:[(loc:cat:head:prep)]))))).

wife ---> (noun_lexeme,
           phon:[(a_ wife)],              
	   synsem:(loc:(cat:(head:(noun,
                                lex_class:non_pron,
				case:plain,
				agr:Agr),
			  val:(subj:[],
			       spr:[(loc:cat:head:(det,
						   agr:Agr))],
			       comps:[]))))).



%% Names

chemistry ---> (word,
                phon:[(a_ chemistry)],                   
	        synsem:(loc:(cat:(head:(noun,
                                     lex_class:non_pron,
	                             agr:third_sg,
				     case:plain),
			       val:(subj:[],
				    spr:[],
				    comps:[])),
                            cont:noun_cont)),
		arg_st:[]).


england ---> (word,
              phon:[(a_ england)],                 
	      synsem:(loc:(cat:(head:(noun,
                                   lex_class:non_pron,
	                           agr:third_sg,
				   case:plain),
			     val:(subj:[],
				  spr:[],
				  comps:[])),
                           cont:noun_cont)),
	      arg_st:[]).



kim ---> (word,
	  phon:[(a_ kim)],
	  synsem:(loc:(cat:(head:(noun,
                               lex_class:non_pron,
	                       agr:third_sg,
			       case:plain),
			 val:(subj:[],
			      spr:[],
		              comps:[])),
                       cont:noun_cont)),
	  arg_st:[]).


leslie ---> (word,
             %phon:[(a_ leslie)],                
	     synsem:(loc:(cat:(head:(noun,
                                  lex_class:non_pron,
	                          agr:third_sg,
				  case:plain),
			    val:(subj:[],
				 spr:[],
				 comps:[])),
                    cont:noun_cont)),
	     arg_st:[]).

paris ---> (word,
            phon:[(a_ paris)],               
	    synsem:(loc:(cat:(head:(noun,
                                 lex_class:non_pron,
	                         agr:third_sg,
				 case:plain),
			   val:(subj:[],
				spr:[],
				comps:[])),
                         cont:noun_cont)),
	    arg_st:[]).

robin ---> (word,
            phon:[(a_ robin)],               
	    synsem:(loc:(cat:(head:(noun,
                                 lex_class:non_pron,
	                         agr:third_sg,
				 case:plain),
			   val:(subj:[],
				spr:[],
				comps:[])),
                         cont:noun_cont)),
	    arg_st:[]).


