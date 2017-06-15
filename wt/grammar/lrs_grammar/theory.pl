

%:- [setup].

% If this constraint is missing, then derived words do not have
% a phonology.

phonology
forall Word ---> FS do
 FS = phon:[(a_ Word)].

%phonology2
%forall _ lex_rule (_ **> FS morphs (_ became Pattern)) do
%  FS = phon:[(a_ Pattern)].

% comment: 
% phonology3 requires defining @pattern_to_word in definite_clauses.pl

phonology3
forall _ lex_rule (_ **> FS morphs (_ became Pattern)) do
  FS = phon:[@pattern_to_word(Pattern)].


%%%%%%% signature file
signature(signature).



%%%%%%% lexicon files
:- [lexicon_auxiliaries].
:- [lexicon_adjectives].
:- [lexicon_main_verbs].
:- [lexicon_nouns].
:- [lexicon_prepositions].
:- [lexicon_pronouns].
:- [lexicon_misc].



%%%%%%% the lex rule file
:- [lexical_rules].

%%%%%%% the rule file
:- [rules].

%%%%%% the constraint file
:- [constraints].

%%%%%% definite clause file
:- [definite_clauses].

%%%%%%% the file that contains instructions for the graphical output
%:- [grale_specs].

%%%%%%% the file that contains the test items
:- [test_items].



