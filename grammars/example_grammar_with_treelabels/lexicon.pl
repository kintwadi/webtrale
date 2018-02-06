% File: lexicon.pl

% ----------
% I. Lexicon
% ----------

% A. Adjectives

available ---> @sia(available_rel).
big ---> @sia(big_rel).
happy ---> @sia(happy_rel).
hungry ---> @sia(hungry_rel).
fond ---> @pp_adj(fond_rel,of,pp_of).
likely ---> @sra(likely_rel).
tired ---> @sia(tired_rel).

% B. Adverbs

very ---> @deg(high).

% B. Complementizers

that ---> @compl(fin,proposition).   

% C. Determiners

a ---> @det(a,thd_sg,a).
an ---> @det(a,thd_sg,a).
that ---> @det(that,thd_sg,that).
the ---> @det(the,_,the).
those ---> @det(those,thd_pl,those).

% D. Nouns

% D.1 Proper names

bo ---> @name(bo).
fido ---> @name(fido).
frankfurt ---> @name(frankfurt).
kim ---> @name(kim).
lilly ---> @name(lilly).
mom ---> @name(mom).
pat ---> @name(pat).
sandy ---> @name(sandy).

% D.2 Pronouns

% D.2.1 Personal pronouns

% Nominative personal pronouns

i ---> @f_s_ppron(fst_sg,nom,speaker).
you ---> @f_s_ppron(sec,_,hearer).
he ---> @ppron(thd_sg,male,nom).
she ---> @ppron(thd_sg,female,nom).
it ---> @ppron_it(thd_sg,thing,_).
we ---> @f_s_ppron(fst_pl,nom,group_incl_speaker).
they ---> @ppron(thd_pl,group,nom).

% Accusative personal pronouns

me ---> @f_s_ppron(fst_sg,acc,speaker).
him ---> @ppron(thd_sg,male,acc).
her ---> @ppron(thd_sg,female,acc).
us ---> @f_s_ppron(fst_pl,acc,speaker).
them ---> @ppron(thd_pl,group,acc).

% Non-referential pronouns

it ---> @it.
there ---> @there.

% D.3 Common nouns

apple --->  @cn_sg(apple,apple).
apples --->  @cn_pl(apples,apples).
book --->  @cn_sg(book,book).
books --->  @cn_pl(books,books).
cat --->  @cn_sg(cat,cat).
cats --->  @cn_pl(cats,cats).
dog --->  @cn_sg(dog,dog).
dogs --->  @cn_pl(dogs,dogs).
letter --->  @cn_sg(letter,letter).
letters --->  @cn_pl(letters,letters).
professor --->  @cn_sg(professor,professor).
professors --->  @cn_pl(professors,professors).
student --->  @cn_sg(student,student).
students --->  @cn_pl(students,students).


% E. Prepositions

for ---> @arg_mark_prep(for).
on ---> @arg_mark_prep(on).
of ---> @arg_mark_prep(of).
to ---> @arg_mark_prep(to).

% F. Verbs

% F.1 Auxiliaries

%%% be

% Progressive be

be ---> @be_progr_aux_nonfin(base,np_case).
am ---> @be_progr_aux_pres(fst_sg,fin,np_nom).
are ---> @be_progr_aux_pres((sec;fst_pl;thd_pl),fin,np_nom).
is ---> @be_progr_aux_pres(thd_sg,fin,np_nom).
was ---> @be_progr_aux_past((fst_sg;thd_sg),fin,np_nom).
were  ---> @be_progr_aux_past(thd_pl,fin,np_nom).
been  ---> @be_progr_aux_nonfin(pfp,np_case).


% Copula be+AP

be ---> @be_copula_aux_ap_nonfin(base,np_case).
am ---> @be_copula_aux_ap_pres(fst_sg,fin,np_nom).
are ---> @be_copula_aux_ap_pres((sec;fst_pl;thd_pl),fin,np_nom).
is ---> @be_copula_aux_ap_pres(thd_sg,fin,np_nom).
was ---> @be_copula_aux_ap_past((fst_sg;thd_sg),fin,np_nom).
were  ---> @be_copula_aux_ap_past(non_thd_sg,fin,np_nom).
being  ---> @be_copula_aux_ap_nonfin(prp,np_case).
been  ---> @be_copula_aux_ap_nonfin(pfp,np_case).

% do

do ---> @do_aux_pres(non_thd_sg).
does ---> @do_aux_pres(thd_sg).
did ---> @do_aux_past.

% have

have ---> @have_aux_nonfin(base,_).
have ---> @have_aux_pres(non_thd_sg,fin,np_nom).
has ---> @have_aux_pres(thd_sg,fin,np_nom).
had ---> @have_aux_past(agr,fin,np_nom).

% will

will ---> @will(future).

to ---> @inf_to.

% F.2 Main verbs
amuse ---> @stv(amuse_rel).
arrive ---> @there_v(arrive_rel).
believe ---> (@orv(believe_rel)).
believe ---> @s_comp_v(believe_rel).
call ---> @stv(call_rel).
dance ---> (@siv(dance_rel),
            phon:[(a_ dance)]).
depend ---> @argm_piv(depend_on_rel,on,pp_on).
eat ---> @stv(eat_rel).
expect ---> (@orv(expect_rel)).
finish ---> @siv(finish_rel).
give ---> @dtv(give_rel).
give ---> @argm_ptv(give_rel,to,pp_to).
know ---> @stv(know_rel).
leave ---> @siv(leave_rel).
like ---> @stv(like_rel).
move ---> @siv(move_rel).
persuade ---> @ocv(persuade_rel).
nominate ---> @stv(nominate_rel).
prove ---> @stv(prove_rel).
rain ---> @rain_verb(rain_rel).
see ---> @stv(see_rel).
seem ---> (@srv(seem_rel)).
show ---> @dtv(show_rel).
show ---> @argm_ptv(show_rel,to,pp_to).
sing ---> @siv(sing_rel).
smile ---> @siv(smile_rel).
smoke ---> @siv(smoke_rel).
snore ---> @siv(snore_rel).
speak ---> @argm_piv(speak_to_rel,to,pp_to).
think ---> @s_comp_v(think_rel).
try ---> @scv(try_rel).
visit ---> @stv(visit_rel).
wait ---> @argm_piv(wait_rel,for,pp_for).
walk ---> @siv(walk_rel).









