:-op(1110,xfx,where).
:-op(900,xfx,labels_fs).


%portray_tree_label(lexicon,_SubWs,RootFS,_SubTrees,DupsIn,DupsOut,NumIn,NumOut,[34|LabelString]) :-
%  !,'$label'(LabelString,[34],DupsIn,DupsOut,NumIn,NumOut) labels_fs RootFS.

%portray_tree_label(lexicon,_,_,_,_,_,_,_,_) :- !,fail. % let TRALE handle lexical items
%portray_tree_label(empty,_,_,_,_,_,_,_,_) :- !,fail. % let TRALE handle empty categories


portray_tree_label(RuleName,SubWs,RootFS,_SubTrees,DupsIn,DupsOut,NumIn,NumOut,[34|LabelString0]) :-
   write_to_codes([RuleName|SubWs],LabelString0,LabelString),
  '$label'(LabelString,[34],DupsIn,DupsOut,NumIn,NumOut) labels_fs RootFS.


% ||||||||||||||||||||||



% Note: string variables on the RHS of 'where' can only be used *once*
% on the LHS of labels_fs, i.e., not:
% 'see('+L+','+L+')' labels_fs synsem:loc:cat:index:Ind where (L labels_fs Ind).
%
% but you can do this:
% 'see('+L1+','+L2+')' labels_fs synsem:loc:cat:index:Ind where (L1 labels_fs Ind),
%   (L2 labels_fs Ind).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

'  ||  '+CatString+'  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+','+(@A2)+','+(@A3)+')' labels_fs (synsem:loc:(cat:(RootCat,
                                                                                           head:(v,
                                                                                                 vform:nonfin),
				                                                           comps:ne_list),
				                                                           cont:(Sem,arg1:A1,arg2:A2,arg3:A3))) 
				                                                           where (CatString labels_fs RootCat).


 

/*
% Slashed signs

% Slashed true VPs are treated specially, because they do not have a semantic label

'  ||  '+'VP['+VForm+']'+'/'+SlashCatString+'  ||' labels_fs (phrase,
                                                                 synsem:(loc:cat:(head:(v,
                                                                                        vform:VForm),
                                                                                  subj:ne_list,
                                                                                  comps:e_list),
                                                                         slash:hd:cat:SlashCat)) where (SlashCatString labels_fs SlashCat).

% The label for the gap: version with syntax + semantics
'  ||  '+RootCatString+'/'+SlashCatString+'  ||  '+SlashLocString labels_fs (word,
                                                                             synsem:(loc:cat:RootCat,
                                                                                     slash:hd:(SlashLoc,
                                                                                               cat:SlashCat)))     
                                                                                               where (RootCatString labels_fs RootCat),
                                                                                                     (SlashCatString labels_fs SlashCat),


% The label for the gap: version with syntax only
'  ||  '+RootCatString+'/'+SlashCatString+'  ||  ' labels_fs (word,
                                                              synsem:(loc:cat:RootCat,
                                                                      slash:hd:(cat:SlashCat)))     
                                                                                               where (RootCatString labels_fs RootCat),
                                                                                                     (SlashCatString labels_fs SlashCat).
                                                                                                     

% The label for phrases containing a gap: syntax only
'  ||  '+RootCatString+'/'+SlashCatString+'  ||' labels_fs (phrase,
                                                            synsem:(loc:cat:RootCat,
                                                             slash:hd:cat:SlashCat))     
                                                                         where (RootCatString labels_fs RootCat),
                                                                               (SlashCatString labels_fs SlashCat).

*/

% True VPs are treated specially, because they do not have a semantic label

'  ||  '+'VP['+VForm+']'+'  ||' labels_fs (phrase,
                                    synsem:loc:cat:(head:(v,
                                                          vform:VForm),
                                                    subj:ne_list,
                                                    comps:e_list)) where true.

% Sentences do not have a semantic label

'  ||  '+'S'+'  ||' labels_fs (phrase,
                                  synsem:loc:cat:(head:v,
                                                  subj:e_list,
                                                  comps:e_list)) where true.                                                    
                                                    
% The infinitive marker does not have a semantic label
                                                    
% TO

'  ||  V[inf]'+'  ||' labels_fs (word,
                                    synsem:loc:cat:(head:(v,
				                          vform:inf))) where true.                                                     
                                                    
% Non-slashed signs: version with syntax + semantics

'  ||  '+CatString+'  ||  '+ContString labels_fs (synsem:loc:(RootCont,
                                                  cat:RootCat)) where (CatString labels_fs RootCat),
                                                                      (ContString labels_fs RootCont).

/*
% Non-slashed signs: version with syntax only

'  ||  '+CatString+'  ||  ' labels_fs (synsem:loc:cat:RootCat) where (CatString labels_fs RootCat).                                                                      
*/


% Category labels                                                                      

'A' labels_fs (head:a,
               comps:ne_list) where true.
               
'AP' labels_fs (head:a,
                comps:e_list) where true.               

'Adv' labels_fs (head:adv) where true.     

'C' labels_fs (head:c,
               comps:ne_list) where true. 

'CP' labels_fs (head:c,
                comps:e_list) where true.                

'D' labels_fs (head:d) where true.                   


'NP[it]' labels_fs (head:(n,
                          form:it)) where true. 
                                            
'NP[there]' labels_fs (head:(n,
                             form:there)) where true. 
                                                         

'NP[nom]' labels_fs (head:(n,
                           case:nom)) where true. 
                                                                      
                                                                      
'NP[acc]' labels_fs (head:(n,
                           case:acc)) where true. 
                     
'NP[case]' labels_fs (head:n) where true.                      

'P['+Form+']' labels_fs (head:(p,
                               form:Form),
                         comps:ne_list) where true.
                              
'PP['+Form+']' labels_fs (head:(p,
                                form:Form),
                          comps:e_list) where true.                       

'S' labels_fs (head:v,
               subj:e_list,
               comps:e_list) where true.                           
                          
'V['+VForm+']' labels_fs (head:(v,
                                vform:VForm),
                          comps:ne_list) where true.
                          
'VP['+VForm+']' labels_fs (head:(v,
                                vform:VForm),
                          comps:e_list) where true.                          
                          
                          
                      
                    




% Semantic labels 

% Adjectives

% likely

(@Sem)+' = '+Sem+'('+(@A1)+','+Deg+')' labels_fs (cat:head:a,
                                                  cont:(Sem,
				           likely_rel,
                                           arg1:A1,
                                           degree:Deg)) where true.

% 2-place                                           
                                           
(@Sem)+' = '+Sem+'('+(@A1)+','+(@A2)+','+Deg+')' labels_fs (cat:head:a,
                                                  cont:(Sem,
                                                     arg1:A1,
                                                     arg2:A2,
                                                     degree:Deg)) where true.                                           

% 1-place				         
				         
(@Sem)+' = '+Sem+'('+(@A1)+','+Deg+')' labels_fs (cat:head:a,
                                                  cont:(Sem,
                                           arg1:A1,
                                           degree:Deg)) where true.                                                       

% CPs

(@Sem1)+' = '+Sem+'('+(@A1)+','+(@A2)+','+(@A3)+')' labels_fs (cat:c,
                                                               cont:(Sem1,
                                                                     rel:(Sem,
                                                                          arg1:A1,
                                                                          arg2:A2,
                                                                          arg3:A3))) where true. 
 
(@Sem1)+' = '+Sem+'('+(@A1)+','+(@A2)+')' labels_fs (cat:c,
                                                     cont:(Sem1,
                                                           rel:(Sem,
                                                                arg1:A1,
                                                                arg2:A2))) where true. 
 
(@Sem1)+' = '+Sem+'('+(@A1)+')' labels_fs (cat:c,
                                           cont:(Sem1,
                                                 rel:(Sem,
                                                      arg1:A1))) where true.  

(@Sem1)+' = '+Sem labels_fs (cat:c,
                             cont:(Sem1,
                                   rel:Sem)) where true.                                                                                     
                                                                                    
% Determiners

Cont_label+'('+(@Index)+')' labels_fs (cat:head:d,
                                       cont:(Index,index),
                                       cont_label:Cont_label) where true. 
               


% Nominals

Cont_label+'('+(@Index)+')' labels_fs (cat:(head:n,
                                            spr:ne_list,
                                            comps:e_list),
                                       cont:(Index,index),
                                       cont_label:Cont_label) where true. 

Index+'('+(@Index)+')' labels_fs (cat:(head:n,
                                            spr:e_list,
                                            comps:e_list),
                                       cont:(Index,index)) where true.                                        
                                       
% PPs

Index+'('+(@Index)+')' labels_fs (cat:(head:p,
                                       comps:e_list),
                                  cont:(Index,index)) where true.                      
                     

% Verbs

% SEEM

% past tense - 1-place				                                
'past('+Sem+'('+(@A1)+'))' labels_fs (cat:(head:(v,
					         vform:fin),
				           comps:ne_list),
				      cont:(past,
				            arg1:(seem_rel,
                                                  arg1:(Sem,arg1:A1)))) where true.	

% present
Sem+'('+(@A1)+')' labels_fs (cat:(head:(v,
                                        vform:fin),
                                  comps:ne_list),
                             cont:(seem_rel,
                                   Sem,arg1:A1)) where true. 

% non-finite
(@Sem)+' = '+Sem+'('+(@A1)+')' labels_fs (cat:(head:(v,
                                                      vform:nonfin),
				               comps:ne_list),	
			                  cont:(seem_rel,
			                        Sem,arg1:A1)) where true.			                            
% MAIN VERBS                             
                             
% Past tense
                                       
% past tense - 3-place				                                
'past('+Sem+'('+(@A1)+','+(@A2)+','+(@A3)+'))' labels_fs (cat:(head:(v,
					                             vform:fin),
				       	                       comps:ne_list),
                                                          cont:(past,
                                                                arg1:(Sem,arg1:A1,arg2:A2,arg3:A3))) where true. 

% past tense - 2-place				                                
'past('+Sem+'('+(@A1)+','+(@A2)+'))' labels_fs (cat:(head:(v,
					                   vform:fin),
				       	             comps:ne_list),
                                                cont:(past,
                                                      arg1:(Sem,arg1:A1,arg2:A2))) where true.                                                                 
                                                                
% past tense - 1-place				                                
'past('+Sem+'('+(@A1)+'))' labels_fs (cat:(head:(v,
					         vform:fin),
				           comps:e_list),
				      cont:(past,
				            arg1:(Sem,arg1:A1))) where true.	                                       

% past tense - 0-place				                                
'past('+Sem+')' labels_fs (cat:(head:(v,
                                      vform:fin),
                                comps:e_list),
                           cont:(past,
				 arg1:Sem)) where true.				            

				 
% Verbs - non-finite


% non-finite - 3-place
/*
Sem+'('+(@A1)+','+(@A2)+','+(@A3)+')' labels_fs (word,synsem:loc:(cat:(head:(v,
                                                               vform:nonfin),
				                          comps:ne_list),	
			                            cont:(Sem,arg1:A1,arg2:A2,arg3:A3))) where true.

*/
% non-finite - 2-place
(@Sem)+' = '+Sem+'('+(@A1)+','+(@A2)+')' labels_fs (cat:(head:(v,
                                                  vform:nonfin),
                                            comps:ne_list),
                                       cont:(Sem,arg1:A1,arg2:A2)) where true. 		                            
			                            
% non-finite - 1-place
(@Sem)+' = '+Sem+'('+(@A1)+')' labels_fs (cat:(head:(v,
                                                      vform:nonfin),
				               comps:e_list),	
			                  cont:(Sem,arg1:A1)) where true.			                            

% non-finite - 0-place
(@Sem)+' = '+Sem labels_fs (cat:(head:(v,
                                       vform:nonfin),
				 comps:e_list),	
			    cont:Sem) where true.			                  

			    
% present - 3-place
Sem+'('+(@A1)+','+(@A2)+','+(@A3)+')' labels_fs (cat:(head:(v,
                                                            vform:fin),
                                                      comps:ne_list),
                                                 cont:(Sem,arg1:A1,arg2:A2,arg3:A3)) where true. 			    
			    
% present - 2-place
Sem+'('+(@A1)+','+(@A2)+')' labels_fs (cat:(head:(v,
                                                  vform:fin),
                                            comps:ne_list),
                                       cont:(Sem,arg1:A1,arg2:A2)) where true. 			    

% present - 1-place
Sem+'('+(@A1)+')' labels_fs (cat:(head:(v,
                                        vform:fin),
                                  comps:e_list),
                             cont:(Sem,arg1:A1)) where true. 
                                       
% present - 0-place
Sem labels_fs (cat:(head:(v,
                          vform:fin),
                    comps:e_list),
               cont:Sem) where true. 

% Auxiliaries    

% BE - copula

% past
'past('+(@A1)+')' labels_fs (cat:(head:(v,
                                        vform:fin),
                                  subj:ne_list,
                                  comps:[(loc:cat:head:a)]),
                             cont:(past,
                                   arg1:A1)) where true.
                                                                      
                                   
% present
'present('+(@A1)+')' labels_fs (cat:(head:(v,
                                        vform:fin),
                                  subj:ne_list,
                                  comps:[(loc:cat:head:a)]),
                             cont:A1) where true.                                   

% BE - progressive

% pres am, is, are
'in-prog('+(@A1)+')' labels_fs (cat:head:vform:fin,
                                cont:(in_prog_rel,
                                      arg1:A1)) where true.				                            
% was, were
'past(in-prog('+(@A1)+'))' labels_fs (cont:(past,
                                            arg1:(in_prog_rel,
                                                  arg1:A1))) where true.
				                            
% be, being
(@Sem)+' = '+'in-prog'+'('+(@A1)+')' labels_fs (cat:head:vform:nonfin,
                                                  cont:(Sem,
				                        in_prog_rel,
				                        arg1:A1)) where true.	

% HAVE

% pres have, has
'completed('+(@A1)+')' labels_fs (cat:head:vform:fin,
                                  cont:(completed_rel,
                                        arg1:A1)) where true.				                            
% had
'past(completed('+(@A1)+'))' labels_fs (cont:(past,
				              arg1:(completed_rel,
				                    arg1:A1))) where true.
				                            
% have
(@Sem)+' = '+'completed'+'('+(@A1)+')' labels_fs (cat:head:vform:base,
                                                  cont:(Sem,
				                        completed_rel,
				                        arg1:A1)) where true.	

% WILL

'future('+(@A1)+')' labels_fs (cont:(future,
				     arg1:A1)) where true.                 
               

% Everything else has no semantic label               
               
'' labels_fs (cont:_) where true.                     




/*

%%
%% Adjectives				                     
%%

% likely

'  ||  A  ||  '+Sem+'('+(@A1)+','+Deg+')' labels_fs (word,
                                               synsem:loc:(cat:(head:a,
                                                                spr:ne_list,
				                                comps:ne_list),
				                           cont:(Sem,
				                                likely_rel,
                                                                arg1:A1,degree:Deg))) where true.
                                                                
'  ||  A  ||  '+Sem+'('+(@A1)+','+Deg+')' labels_fs (word,
                                               synsem:loc:(cat:(head:a,
                                                                spr:e_list,
				                                comps:ne_list),
				                           cont:(Sem,
				                                likely_rel,
                                                                arg1:A1,degree:Deg))) where true.                                                                
				            
% 2-place				            

'  ||  A  ||  '+Sem+'('+(@A1)+','+(@A2)+','+Deg+')' labels_fs (word,
                                                         synsem:loc:(cat:(head:a,
                                                                          spr:ne_list,
                                                                          comps:ne_list),
                                                                     cont:(Sem,arg1:A1,arg2:A2,degree:Deg))) where true.  
                                                                     
% 2-place				            

'  ||  A  ||  '+Sem+'('+(@A1)+','+(@A2)+','+Deg+')' labels_fs (word,
                                                         synsem:loc:(cat:(head:a,
                                                                          spr:e_list,
                                                                          comps:ne_list),
                                                                     cont:(Sem,arg1:A1,arg2:A2,degree:Deg))) where true.                                                                      

% 2-place				         
				         
'  ||  AP  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+','+(@A2)+','+Deg+')' labels_fs (cat:(head:a,
                                                     comps:e_list),
                                                cont:(Sem,arg1:A1,arg2:A2,degree:Deg)) where true. 
                                                                     
% 1-place				         
				         
'  ||  AP  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+','+Deg+')' labels_fs (cat:(head:a,
                                                     comps:e_list),
                                                cont:(Sem,arg1:A1,degree:Deg)) where true.                                                          


%%
%% Adverbs				                     
%%

'  ||  Adv  ||  '+Deg labels_fs (word,synsem:loc:(cat:head:adv,
                                            cont:Deg)) where true.      
                                               
%%
%% Complementizers				                     
%%                                               
                                               
'  ||  C' labels_fs (word,synsem:loc:cat:head:c) where true. 

'  ||  CP  ||  '+(@Sem1)+' = '+Sem+'('+(@A1)+','+(@A2)+','+(@A3)+')' labels_fs (cat:head:c,
                                                                           cont:(Sem1,
                                                                               rel:(Sem,
                                                                                    arg1:A1,
                                                                                    arg2:A2,
                                                                                    arg3:A3))) where true. 

'  ||  CP  ||  '+(@Sem1)+' = '+Sem+'('+(@A1)+','+(@A2)+')' labels_fs (cat:head:c,
                                                                 cont:(Sem1,
                                                                       rel:(Sem,
                                                                            arg1:A1,
                                                                            arg2:A2))) where true. 

'  ||  CP  ||  '+(@Sem1)+' = '+Sem+'('+(@A1)+')' labels_fs (cat:head:c,
                                                       cont:(Sem1,
                                                             rel:(Sem,
                                                                  arg1:A1))) where true. 

%%
%% Determiners				                     
%%

'  ||  D' labels_fs (word,synsem:loc:(cat:head:d)) where true.  
 

%%%
%%% N and NP	
%%%

                                         
% NPs (nom and acc): names, pronouns, Det+N                                                   
                                               
'  ||  NP[nom]  ||  '+Index+'('+(@Index)+')' labels_fs (cat:(head:(n,
                                                             case:nom),
                                                       spr:e_list),
                                                  cont:(Index,index)) where true.                                               
                                               
'  ||  NP[acc]  ||  '+Index+'('+(@Index)+')' labels_fs (cat:(head:(n,
                                                             case:acc),
                                                        spr:e_list),
                                                  cont:(Index,index)) where true. 

% % NPs (case): names, pronouns, common nouns, Det+N                                               
                                               
'  ||  NP[case]  ||  '+Index+'('+(@Index)+')' labels_fs (cat:head:n,
                                                   cont:(Index,index)) where true.                                               

% Expletives

'  ||  NP[it]' labels_fs (cat:(head:(n,
                                 form:it))) where true. 
                                            
'  ||  NP[there]' labels_fs (cat:(head:(n,
                                    form:there))) where true.   
                                               
%%
%% Prepositions and PPs				                     
%%
                                               
'  ||  P['+Form+']' labels_fs (cat:(head:(p,
                                      form:Form),
                                comps:ne_list)) where true.
                              
'  ||  PP['+Form+']  ||  '+Index+'('+(@Index)+')' labels_fs (cat:(head:(p,
                                                                  form:Form),
                                                            comps:e_list),
                                                       cont:Index) where true.
                      
                                                            
%%%                                                                                                             
%%% Sentence
%%%				             
				             
'  ||  S' labels_fs (cat:(head:(v,
                            vform:fin),
                      subj:e_list)) where true.   

                                              
%%%
%%% Verbs, AUX, and VPs
%%%

% THE COPULA

% non-finite
'  ||  V['+VForm+']' labels_fs (cat:(head:(v,
                                       vform:(VForm,nonfin)),
                                 subj:ne_list,
                                 comps:[(loc:cat:head:a)])) where true.

% past
'  ||  V[fin]  ||  '+'past('+(@Sem)+')' labels_fs (cat:(head:(v,
					                vform:fin),
                                                  subj:ne_list,
                                                  comps:[(loc:cat:head:a)]),
                                             cont:(past,
                                                   arg1:Sem)) where true.

% present
'  ||  V[fin]  ||  '+'pres('+(@Sem)+')' labels_fs (cat:(head:(v,
					                vform:fin),
                                                  subj:ne_list,
                                                  comps:[(loc:cat:head:a)]),
                                             cont:Sem) where true.

% RAIN

% non-finite
'  ||  VP['+VForm+']  ||  '+(@Sem)+' = '+Sem labels_fs (cat:(head:(v,
                                                             vform:(VForm,nonfin)),
                                                       comps:e_list),
                                                  cont:(Sem,
                                                        rain_rel)) where true.
% present
'  ||  VP[fin]  ||  '+Sem labels_fs (cat:(head:(v,
                                          vform:fin),
                                    comps:e_list),
                               cont:(Sem,
                                     rain_rel)) where true.
                                                          
% past
'  ||  VP[fin]  ||  '+'past('+Sem+')' labels_fs (cat:(head:(v,
                                                      vform:fin),
                                                comps:e_list),
                                           cont:(past,
                                                 arg1:(Sem,
                                                       rain_rel))) where true.                                                        
                                             
                                             
% DO, DOES
 
                                                                                     
 '  V[fin]'   labels_fs (cat:(head:(v,
                                    vform:fin),
                              comps:ne_list)) where true.                                                  


'  ||  VP[fin]' labels_fs (cat:(head:(v,
                                  vform:fin),
                            subj:ne_list,
                            comps:e_list)) where true.

% VPs WHOSE HEAD IS THE COPULA (1-place adjective)
'  ||  VP['+VForm+']  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+','+(@A2)+','+Deg+')' labels_fs (cat:(head:(v,
                                                                                    vform:(VForm,nonfin)),
                                                                              comps:e_list),
                                                                         cont:(Sem,arg1:A1,arg2:A2,degree:Deg)) where true. 
                                                                         
% VPs WHOSE HEAD IS THE COPULA (1-place adjective)
'  ||  VP['+VForm+']  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+','+Deg+')' labels_fs (cat:(head:(v,
                                                                                    vform:(VForm,nonfin)),
                                                                              comps:e_list),
                                                                         cont:(Sem,arg1:A1,degree:Deg)) where true.  

                                                                         
                                                                         
% 3-place; have to be ordered before 2-place

% non-finite
'  ||  V['+VForm+']  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+','+(@A2)+','+(@A3)+')' labels_fs (cat:(head:(v,
                                                                                               vform:(VForm,nonfin)),
				                                                         comps:ne_list),	
			                                                            cont:(Sem,arg1:A1,arg2:A2,arg3:A3)) where true.
			                                
% past ; has to be ordered before present rule				                                
'  ||  V[fin]  ||  '+'past('+Sem+'('+(@A1)+','+(@A2)+','+(@A3)+'))' labels_fs (cat:(head:(v,
					                                            vform:fin),
				       	                                      comps:ne_list),
                                                                         cont:(past,
                                                                               arg1:(Sem,arg1:A1,arg2:A2,arg3:A3))) where true.   

% present; has to be ordered after past rule
'  ||  V[fin]  ||  '+Sem+'('+(@A1)+','+(@A2)+','+(@A3)+')' labels_fs (cat:(head:(v,
                                                                           vform:fin),
                                                                     comps:ne_list),
                                                                cont:(Sem,arg1:A1,arg2:A2,arg3:A3)) where true.   

                                                                                     
% 2-place; have to be ordered after 3-place

% non-finite
'  ||  VP['+VForm+']  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+','+(@A2)+')' labels_fs (cat:(head:(v,
					                                             vform:(VForm,nonfin)),
				                                               comps:e_list),	
                                                                          cont:(Sem,arg1:A1,arg2:A2)) where true.

% non-finite
'  ||  V['+VForm+']  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+','+(@A2)+')' labels_fs (cat:(head:(v,
					                                             vform:(VForm,nonfin)),
				                                               comps:ne_list),	
                                                                          cont:(Sem,arg1:A1,arg2:A2)) where true.
			                                
% past ; has to be ordered before present rule				                                
'  ||  V[fin]  ||  '+'past('+Sem+'('+(@A1)+','+(@A2)+'))' labels_fs (cat:(head:(v,
                                                                          vform:fin),
                                                                    comps:ne_list),
                                                                cont:(past,
                                                                      arg1:(Sem,arg1:A1,arg2:A2))) where true.   

% present; has to be ordered after past rule
'  ||  V[fin]  ||  '+Sem+'('+(@A1)+','+(@A2)+')' labels_fs (cat:(head:(v,
					                         vform:fin),
				       	                   comps:ne_list),
                                                      cont:(Sem,arg1:A1,arg2:A2)) where true.   


 % 1-place

                                                    
% 1-place main verbs

% SEEM

% non-finite
'  ||  V['+VForm+']  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+')' labels_fs (cat:(head:(v,
                                                                          vform:(VForm,(base;pfp;prp))),  % to exclude "to"
				                                    comps:ne_list),	
			                                       cont:(Sem,arg1:A1)) where true.
			                                
% past ; has to be ordered before present rule		  		                                
'  ||  V[fin]  ||  '+'past('+Sem+'('+(@A1)+'))' labels_fs (cat:(head:(v,
					                         vform:fin),
				                          comps:ne_list),
				                     cont:(past,
				                           arg1:(Sem,arg1:A1))) where true.

% present; has to be ordered after past rule
'  ||  V[fin]  ||  '+Sem+'('+(@A1)+')' labels_fs (cat:(head:(v,
                                                       vform:fin),
                                                 comps:ne_list),
                                            cont:(Sem,arg1:A1)) where true. 
% CANONICAL MAIN VERBS
				                                
% non-finite
'  ||  VP['+VForm+']  ||  '+(@Sem)+' = '+Sem+'('+(@A1)+')' labels_fs (cat:(head:(v,
					                                   vform:(VForm,nonfin)),
				                                     comps:e_list),	
			                                        cont:(Sem,arg1:A1)) where true.
			                                
% past ; has to be ordered before present rule				                                
'  ||  VP[fin]  ||  '+'past('+Sem+'('+(@A1)+'))' labels_fs (cat:(head:(v,
					                         vform:fin),
				                           comps:e_list),
				                      cont:(past,
				                            arg1:(Sem,arg1:A1))) where true.	
				                                        
% present; has to be ordered after past rule
'  ||  VP[fin]  ||  '+Sem+'('+(@A1)+')' labels_fs (cat:(head:(v,
                                                        vform:fin),
                                                  comps:e_list),
                                             cont:(Sem,arg1:A1)) where true.                                                                                   
                                                                       
% Auxiliaries      

% BE - progressive

% was, were - progressive
'  ||  V[fin]  ||  '+'past(in-prog('+(@A1)+'))' labels_fs (cat:(head:(v,
					                        vform:fin),
                                                          comps:ne_list),
				                     cont:(past,
				                           arg1:(in_prog_rel,
				                                 arg1:A1))) where true.	

% am, is, are - progressive
'  ||  V[fin]  ||  '+'in-prog('+(@A1)+')' labels_fs (cat:(head:(v,
					                   vform:fin),
				                    comps:ne_list),
				               cont:(in_prog_rel,
                                                     arg1:A1)) where true.				                            
				                            
% be, been - progressive
'  ||  V['+VForm+']  ||  '+(@Sem)+' = '+'in-prog'+'('+(@A1)+')' labels_fs (cat:(head:(v,
					                                        vform:(VForm,nonfin)),
				                                          comps:ne_list),
				                                     cont:(Sem,
				                                           in_prog_rel,
				                                           arg1:A1)) where true.				                            

				                                                       
% HAVE - perfect

% pres have, has
'  ||  V['+VForm+']  ||  '+'completed('+(@A1)+')' labels_fs (cat:(head:(v,
					                          vform:(VForm,fin)),
                                                            comps:ne_list),
				                       cont:(completed_rel,
                                                             arg1:A1)) where true.				                            
% had
'  ||  V[fin]  ||  '+'past(completed('+(@A1)+'))' labels_fs (cat:(head:(v,
					                          vform:fin),
				                            comps:ne_list),
				                       cont:(past,
				                             arg1:(completed_rel,
				                                   arg1:A1))) where true.
				                            
% have
'  ||  V[base]  ||  '+(@Sem)+' = '+'completed'+'('+(@A1)+')' labels_fs (cat:(head:(v,
					                                     vform:base),
				                                       comps:ne_list),
				                                  cont:(Sem,
				                                        completed_rel,
				                                        arg1:A1)) where true.	     
                                                                                    	                                                                                    
% TO

'  ||  V[inf]' labels_fs (cat:(head:(v,
				 vform:inf))) where true. 

                                                                                         
% WILL

'  ||  V['+VForm+']  ||  '+'future('+(@A1)+')' labels_fs (cat:(head:(v,
					                       vform:(VForm,fin)),
				                         comps:ne_list),
				                    cont:(future,
				                          arg1:A1)) where true.  
 
                                                                       
                                                                                                                                                                              
                                          
 
                                                                                                                                                                              

                                          
                                                
'  VP['+VForm+']' labels_fs (cat:(head:(v,
                                        vform:(VForm,(base;prp;pfp))),
                                  subj:ne_list,
                                  comps:e_list)) where true. 
 */                                             
                                                 

                                                                                            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% otherwise, fail - TRALE will generate the default label

% ||||||||||||||||||||||||||||||||-

('$label'(String,Rest,DupsIn,DupsOut,NumIn,NumOut) labels_fs FS) :- 
  select_label(FS,StringTemplate),
  !, instantiate_string(StringTemplate,String,Rest,DupsIn,DupsOut,NumIn,NumOut).

select_label(FS,StringTemplate) :-
  (StringTemplate labels_fs Desc where Body),
  term_variables(Desc,NVs), % occurrences of this in StringTemplate will be bound by bind_nvs/1 below.
  narrow_vars(Cond,NVs,((FS=Desc);(Trigger1=Trigger2))),
  ale(when(Cond,prolog(HookNVs,((Trigger1==Trigger2) -> fail ; bind_nvs(HookNVs),call(Body))))),
  Trigger1 = Trigger2,  % if Body has executed by this time, there was no delay, and there will be no failure.
  !.

instantiate_string('$label'(String,Rest,DupsIn,DupsOut,NumIn,NumOut),String,Rest,DupsIn,DupsOut,NumIn,NumOut) :- !.
instantiate_string(T1+T2,String1,Rest,DupsIn,DupsOut,NumIn,NumOut) :-
  !,instantiate_string(T1,String1,String2,DupsIn,DupsMid,NumIn,NumMid),
  instantiate_string(T2,String2,Rest,DupsMid,DupsOut,NumMid,NumOut).
instantiate_string((a_ X),XString,Rest,Dups,Dups,Num,Num) :-
  !,write_to_codes(X,XString,Rest).
instantiate_string(FS,String,Rest,Dups,Dups,Num,Num) :-
  get_type(FS,bot,Type),
  !,write_to_codes(Type,String,Rest).
instantiate_string(@FS,String,Rest,DupsIn,DupsOut,NumIn,NumOut) :-
  !, get_type(FS,bot,_),  % this really is a feature structure
  when(nonvar(DupsIn),(avl_store_once(FS,DupsIn,Num,DupsOut,NumIn),
                       write_to_codes(Num,String,Rest))),
  when((nonvar(NumIn),nonvar(DupsOut)),( Num == NumIn -> NumOut is NumIn + 1 ; NumOut = NumIn)).
instantiate_string(Literal,LitString,Rest,Dups,Dups,Num,Num) :-
  atom(Literal),
  !,format_to_chars(Literal,[],LitString,Rest).
instantiate_string(Literal,LitString,Rest,Dups,Dups,Num,Num) :-
  write_to_codes(Literal,LitString,Rest).

avl_store_once(FS,AssocIn,Val,AssocOut,InitVal) :-
  avl_fetch(FS,AssocIn,V) -> Val = V, AssocOut = AssocIn
  ; Val = InitVal, avl_store(FS,AssocIn,Val,AssocOut).

bind_nvs(NVs) :-  % labels_fs clauses are their own scope, so all NVs were fresh
  avl_to_list(NVs,NVsList),
  bind_nvs_act(NVsList).
bind_nvs_act([]).
bind_nvs_act([NV-SeenFlag|NVs]) :-
  ( SeenFlag = seen(NV) -> bind_nvs_act(NVs)
  ; % SeenFlag == unseen,
    bind_nvs_act(NVs)
  ).
    


