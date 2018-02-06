% File: grammar_rules.pl

% --------------------------
% III. Phrase Structure Rules
% --------------------------

% HEAD SUBJECT RULE

hd_subj_rule rule
(hd_subj_ph,
 phon: append(Phon1,Phon2),
 synsem:(loc:(cat:(subj:[],
	           spr:[],
		   comps:[],
                   subj_label:[],
                   spr_label:[],
                   comps_labels:[]))),
 head_dtr:Head_Dtr,
 dtrs:[Non_Head_Dtr,Head_Dtr])
===>
  cat> (Non_Head_Dtr,
        phon:Phon1,
        synsem:Subj),
  cat> (Head_Dtr,
        phon:Phon2,
	synsem:(loc:(cat:(subj:[Subj],
	                  spr:[],
			  comps:[])))).



% HEAD SPECIFIER RULE

hd_spr_rule rule
(hd_spr_ph,
 phon: append(Phon1,Phon2),
 synsem:(loc:(cat:(subj:Subj,
	           spr:[],
                   comps:[],
                   subj_label:Subj_label,
                   spr_label:[],
                   comps_labels:[]),
	      cont:Cont)),
 head_dtr:Head_Dtr,
 dtrs:[Non_Head_Dtr,Head_Dtr])
===>
  cat> (Non_Head_Dtr,
        phon:Phon1,
        synsem:Specifier),
  cat> (Head_Dtr,
        phon:Phon2,
	synsem:(loc:(cat:(subj:Subj,
	                  spr:[Specifier],
			  comps:[],
                          subj_label:Subj_label),
		     cont:Cont))).

% HEAD COMPLEMENT RULES

% 1 complement

hd_comp_rule1 rule
(hd_comp_ph,
 phon: append(Phon1,Phon2),
 synsem:(loc:(cat:(subj:Subj,
                     spr:Spr,
                     comps:[],
                   subj_label:Subj_label,
                   spr_label:Spr_label,
                   comps_labels:[]),
              cont:Cont)),
 head_dtr:HeadDtr,
 dtrs:[Head_Dtr,Non_Head_Dtr])
===>
  cat> (HeadDtr,
        word,
        phon:Phon1,
        synsem:(loc:(cat:(subj:Subj,
                          spr:Spr,
                          comps:[Comp],
                         subj_label:Subj_label,
                         spr_label:Spr_label),
                       cont:Cont))),
  cat> (Non_Head_Dtr,
        phon:Phon2,
        synsem:Comp).

% 2 complements

hd_comp_rule2 rule
(hd_comp_ph,
 phon: append(append(Phon1,Phon2),Phon3),
 synsem:(loc:(cat:(subj:Subj,
                     spr:Spr,
                     comps:[],
                   subj_label:Subj_label,
                   spr_label:Spr_label,
                   comps_labels:[]),
              cont:Cont)),
 head_dtr:HeadDtr,
 dtrs:[Head_Dtr,Non_Head_Dtr1,Non_Head_Dtr2])
===>
  cat> (HeadDtr,
        word,
        phon:Phon1,
        synsem:(loc:(cat:(subj:Subj,
                          spr:Spr,
                          comps:[Comp1,Comp2],
                         subj_label:Subj_label,
                         spr_label:Spr_label),
                       cont:Cont))),
  cat> (Non_Head_Dtr1,
        phon:Phon2,
        synsem:Comp1),
  cat> (Non_Head_Dtr2,
        phon:Phon3,
        synsem:Comp2).

