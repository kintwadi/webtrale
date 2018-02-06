% File: theory.pl

signature(signature).

:- [macros].
:- [lexicon].
:- [lexical_rules].
:- [principles].
:- [functions_and_relations].
:- [grammar_rules].

:- [test_items].
:- [tokenization].
%:- [visualization_most_features_hidden].
:- [visualization_most_features_shown].

:- [treelabels].



  

  
 


  

  

/*
%Flat list flag:

assert(flat_lists).         % all lists are displayed as flat
%retractall(flat_lists).    % to turn off flat lists


Start the Ubuntu-Trale as follows:

trale -fsg
*/

% In Aug 2017, Gerald recommended or ok'ed the following statements for all theory files


:- (environ('TRALE_UNICODE', true);
    format(user_error,"~n~n**ERROR: Please start trale with the option `-u' to enable unicode support, which is needed for this grammar.~n~n~n",[]),
    abort).
    

                   
% tcl                   

:- notcl_warnings.  % on = output of warnings in a TCL window, off = output to console



:- ale_flag(subtypecover,_Old,off).     % Gerald: this flag should be turned off; only the Tübingen folks want this


% Gerald Penn, 03.06.2012
%
% ALE never had support for "unfilling", at least in one reading of that term,
% until now.
%   But now it does.  We're not going to call it unfilling ,however, because
% that term has been so molested that it's going to confuse everyone.  We'll
% call it "sparse output."
%   To turn this on, use ale_flag(sparseoutput,_,on).

% Gert: this hides features whose values are most general

:- ale_flag(sparseoutput,_,on).

/*
CHART DISPLAY




chart_display :-
        ale_flag(chart_display,_,on).
        
:- chart_display.

nochart_display :-
        ale_flag(chart_display,_,off).
        
:- nochart_debug.  % this helps if somebody interrupted during chart debugging and the
                   % flag is still set to 'on
*/

% Gerald says this was put into Trale at Gert's request. So, include in all grammars!!!

% This tries to eliminate as many inconsistent rules which otherwise would result from EFD closure computation.
:-ale_flag(ruleindexscope,_,localresolve).


%%% Comment the following out in order to be asked for additional parses each time. If you don't do that, you get all the windows at once, which may fill up your whole screen.

% Do not ask any questions!
%:-ale_flag(another,_,autoconfirm).

/*
%%% Procedural constraint using cuts in order to do cases. The cases need to be ordered from most specific to most general. The final case can be very general.

phrase *> (P,        % this variable refers to the phrase as a whole, since we
           head_dtr:H) goal pied_piping(P,H).   % want to feed it into the procedural attachment.

% On the right hand side above, we need to identify all the signs that play a role in pied-piping

pied_piping((@vp,wh:e_list),(wh:e_list)) if !.
pied_piping((pp,wh:Wh),(comps:wh:Wh)) if !.
pied_piping(((@np;@ap),wh:Wh),(spr:wh:Wh)) if true.

% Gerald: all the relations can be made into functions, even those that make use of cuts. Then you get default functions.

% Gerald: Stefan uses a lot of if-A-than-B-else-C (shallow cuts). If Trale can prove A, then it does not backtrack into A (but it will backtrack into B or C). The choice of A is committed.

Example:


(word,
 ... verb) *> V
goal (V = vform:pas) -> V = (subcat:S,
                            arg_st:[_|S])
                       ;
                       V = (subcat:S,
                            arg_st:S).

You can list as many cases as you like:

(word,
 ... verb) *> V
goal (V = vform:pas) -> V = (subcat:S,
                            arg_st:[_|S])
     ;
     (V = vform:fin) -> whatever should hold of the second case
     ;
     (V = vform:psp) -> whatever should hold of the third case
     ; %everything except for the VFORMS above
     V = (subcat:S,
          arg_st:S).
     
     

Gerald: if you get unwanted duplicate solutions, then try using cuts.


%%%

multifile and discontiguous

In all files that have macros, at the top you issue a

multifile macro/2.

directive.


discontiguous means that within ONE file, not all the macros may be contiguous.

*/

%% fr: added October 29th, 2017

% words have phonology

phonology
forall Word ---> FS do
 FS = phon:[(a_ Word)].


% output of lexical rules has phonology
% phonology3 requires defining @pattern_to_word
% macro is defined in macros.pl; def. relation defined in
% functions_and_relations.pl

phonology3
forall _ lex_rule (_ **> FS morphs (_ became Pattern)) do
     FS = phon:[@pattern_to_word(Pattern)].










