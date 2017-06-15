:- multifile '--->'/2.

%% Complementizers

that ---> (word,
           phon:[(a_ that)],
	   synsem:(loc:(cat:(head:marker,
			     val:(subj:[],
			          spr:[],
			          comps:[]),
			     marking:that),
                        cont:none),
                   non_loc:inher:wh:[]),
              
	   arg_st:[]).


%% Determiners


a ---> (word,
        phon:[(a_ a)],
	synsem:(loc:(cat:(head:(det,
                             lex_class:none,
	                     agr:third_sg),
		       val:(subj:[],
			    spr:[],
			    comps:[]))),
                non_loc:inher:wh:[]),                
	arg_st:[]).

an ---> (word,
         phon:[(a_ an)],            
	 synsem:(loc:(cat:(head:(det,
                              lex_class:none,
	                      agr:third_sg),
	                val:(subj:[],
		             spr:[],
		             comps:[]))),
                 non_loc:inher:wh:[]),                 
	 arg_st:[]).

any ---> (word,
          phon:[(a_ any)],             
	  synsem:(loc:(cat:(head:(det,
                               lex_class:none,
	                       agr:(per:third)),
			 val:(subj:[],
			      spr:[],
			      comps:[]))),
                  non_loc:inher:wh:[]),                  
	  arg_st:[]).


s ---> (word,
        phon:[(a_ s)],           
	synsem:(loc:(cat:(head:(det,
                             lex_class:none,
	                     agr:(per:third)),
		       val:(subj:[],
			    spr:[(loc:(cat:(head:(noun,
						  lex_class:non_pron),
					    val:(subj:[],
						 spr:[],
						 comps:[])),
                                       cont:noun_cont))],
			    comps:[]))),
                non_loc:inher:wh:[])).

that ---> (word,
           phon:[(a_ that)],              
	   synsem:(loc:(cat:(head:(det,
                                lex_class:none,
	                        agr:(per:third)),
			  val:(subj:[],
			       spr:[],
			       comps:[]))),
                   non_loc:inher:wh:[]),                   
	  arg_st:[]).

the ---> (word,
          phon:[(a_ the)],             
	  synsem:(loc:(cat:(head:(det,
                               lex_class:none,
	                       agr:(per:third)),
			 val:(subj:[],
			      spr:[],
			      comps:[]))),
                  non_loc:inher:wh:[]),                  
	  arg_st:[]).


this ---> (word,
           phon:[(a_ this)],                             
	   synsem:(loc:(cat:(head:(det,
                                lex_class:none,
	                        agr:third_sg),
			  val:(subj:[],
			       spr:[],
			       comps:[]))),
                   non_loc:inher:wh:[]),                   
	  arg_st:[]).


those ---> (word,
            phon:[(a_ those)],               
	    synsem:(loc:(cat:(head:(det,
                                 lex_class:none,
	                         agr:third_pl),
			   val:(subj:[],
				spr:[],
				comps:[]))),
                    non_loc:inher:wh:[]),                    
	    arg_st:[]).


which ---> (word,
            phon:[(a_ which)],               
	    synsem:(loc:(cat:(head:det,
			      val:(subj:[],
				   spr:[],
				   comps:[]))),
                    non_loc:inher:wh:[wh]),                                      
	    arg_st:[]).



%% Trace


empty (word,
       phon:[],
       synsem:(loc:(Loc,
		 cat:(val:(spr:[],
			   comps:[]))),
            non_loc:(inher:(slash:[Loc],
                            wh:[]),
	             to_bind:slash:[]))).

 

