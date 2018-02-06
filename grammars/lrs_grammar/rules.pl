
%% HEAD-SUBJECT RULE

hd_subj rule
(hd_subj_ph,
 phon:combine_phonologies(Dtrs),
 synsem:(loc:cat:val:(subj:[],
		   spr:Spr,
		   comps:Comps),
      non_loc:(inher:(slash: append(Slash_Subj,Slash_Hd_dtr),
                      wh:[]))),
 hd_dtr:Hd_dtr,
 dtrs:(Dtrs,
       [Non_hd_dtr,Hd_dtr]))
===>
cat> (Non_hd_dtr,
      synsem:(Subj,
           loc:cat:val:(spr:[],
			comps:[]),
	   non_loc:(inher:(slash:Slash_Subj,
                           wh:[]),
		    to_bind:(slash:[])))),
cat> (Hd_dtr,
      synsem:(loc:cat:(head:(verb,
			  vform:fin,
			  inv:minus),
		    val:(subj:[Subj],
			 spr:(Spr,
			      []),
			 comps:(Comps,
				[]))),
	   non_loc:(inher:(slash:Slash_Hd_dtr,
                           wh:[]),
		    to_bind:(slash:[])))).


%% HEAD-SPECIFIER RULE

hd_spr rule
(hd_spr_ph,
 phon:combine_phonologies(Dtrs), 
 synsem:(loc:cat:val:(subj:Subj,
		   spr:[],
		   comps:Comps),
      non_loc:(inher:(slash:Hd_dtr_slash,
                      wh:Non_hd_dtr_wh))),
 hd_dtr:Hd_dtr,
 dtrs:(Dtrs,
       [Non_hd_dtr,Hd_dtr]))
===>
cat> (Non_hd_dtr,
      synsem:(Spr,
	   non_loc:(inher:(slash:[],
                           wh:Non_hd_dtr_wh),
		    to_bind:slash:[]))),
cat> (Hd_dtr,
      synsem:(loc:cat:(val:(subj:Subj,
			 spr:[Spr],
			 comps:(Comps,
				[]))),
	   non_loc:(inher:(slash:Hd_dtr_slash,
                           wh:[])))).



%% HEAD-COMPLEMENT RULE

hd_comp rule
(hd_comp_ph,
 phon:combine_phonologies(Dtrs),
 synsem:(loc:cat:val:(subj:Subj,
		   spr:Spr,
		   comps:[]),
      non_loc:(inher:(slash: collect_slashes(Non_hd_dtrs),
                      wh:[]))),                    %% will not work for PPs!!!
 hd_dtr:Hd_dtr,
 dtrs:(Dtrs,
       [Hd_dtr|Non_hd_dtrs]))
===>
cat> (Hd_dtr,
      synsem:loc:cat:(val:(subj:Subj,
			spr:Spr,
			comps:Comps))),
cats> (([_];[_,_]),Non_hd_dtrs),
goal> signs_to_synsems(Non_hd_dtrs,Comps).


%% SUBJECT-AUX-INVERSION RULE

sai_ph rule
(sai_ph,
 phon:combine_phonologies(Dtrs),
 synsem:(loc:cat:val:(subj:[],
		   spr:[],
		   comps:[]),
      non_loc:inher:(slash:Slash,
                     wh:Wh)),
 hd_dtr:Hd_dtr,
 dtrs:(Dtrs,
       [Hd_dtr,Non_hd_dtr1,Non_hd_dtr2]))
===>
cat> (Hd_dtr,
      synsem:loc:cat:(head:(verb,
			 vform:fin,
			 aux:plus,
			 inv:plus),
                   val:(subj:[Subj],
			spr:[],
			comps:[Comp]))),
cat> (Non_hd_dtr1,
      synsem:(Subj,
	   loc:cat:head:noun,
	   non_loc:(inher:(slash:[],
                           wh:[]),
		    to_bind:slash:[]))),
cat> (Non_hd_dtr2,
      synsem:(Comp,
	   non_loc:inher:(slash:Slash,
                          wh:Wh))).


%% HEAD-MARKER RULE

hd_marker rule
(hd_marker_ph,
 phon:combine_phonologies(Dtrs),
 synsem:(loc:cat:(marking:Marking,
	       val:Val),
      non_loc:Non_loc),
 hd_dtr:Hd_dtr,
 dtrs:(Dtrs,
       [Non_hd_dtr,Hd_dtr]))
===>
cat> (Non_hd_dtr,
      word,
      synsem:(loc:cat:(head:marker,
		    marking:Marking,
		    val:(subj:[],
			 spr:[],
			 comps:[])),
	   non_loc:(inher:slash:[],
		    to_bind:slash:[]))),	      
cat> (Hd_dtr,
      hd_subj_ph,                            % perhaps too specific!
      synsem:(loc:cat:(head:(verb,
			  vform:fin,
			  inv:minus),
		    val:(Val,
			 subj:[],
			 spr:[],
			 comps:[])),
	   non_loc:Non_loc)).



%% PREPOS_PH

prepos_ph rule
(prepos_ph,
 phon:combine_phonologies(Dtrs),
 synsem:non_loc:inher:wh:[],
 hd_dtr:Hd_dtr,
 dtrs:(Dtrs,
       [Non_hd_dtr,Hd_dtr]))
===>
cat> (Non_hd_dtr,
      synsem:non_loc:inher:wh:[]),
cat> (Hd_dtr,
      synsem:non_loc:inher:wh:[],
      subj_gap:minus).


%% MC_SUBJ_QUES

mc_subj_ques rule
(mc_subj_ques,
 synsem:non_loc:inher:wh:[],
 hd_dtr:Hd_dtr,
 dtrs:[Non_hd_dtr,Hd_dtr])
===>
cat> (Non_hd_dtr,
      synsem:non_loc:inher:wh:ne_list),
cat> (Hd_dtr,
      synsem:non_loc:inher:wh:[],
      subj_gap:plus).


%% MC_SAI_QUES

mc_sai_ques rule
(mc_sai_ques,
 phon:combine_phonologies(Dtrs),
 hd_dtr:Hd_dtr,
 dtrs:(Dtrs,
       [Non_hd_dtr,Hd_dtr]))
===>
cat> (Non_hd_dtr,
      synsem:non_loc:inher:wh:ne_list),
cat> (Hd_dtr,
      synsem:(loc:cat:head:inv:plus,
           non_loc:inher:wh:[])).




%% HEAD-MODIFIER RULE FOR PRENOMINAL ADJECTIVES

mod_hd rule
(mod_hd_ph,
 phon:combine_phonologies(Dtrs),
 synsem:(loc:cat:val:Val,
         non_loc:(inher:(slash:Slash,
                         wh:[]))),
 hd_dtr:Hd_dtr,
 dtrs:(Dtrs,
       [Non_hd_dtr,Hd_dtr]))
===>
cat> (Non_hd_dtr,
      synsem:(loc:cat:(head:(adj,
			     pred:minus,
			     mod:[Modified]),
		       val:(spr:[],
			    comps:[])),
	      non_loc:(inher:(slash:[],
                              wh:[]),
		       to_bind:slash:[]))),
cat> (Hd_dtr,
      synsem:(Modified,
              loc:cat:(val:Val),
	      non_loc:(inher:(slash:Slash,
                              wh:[])))).


