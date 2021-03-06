% File: visualization-most-features-hidden.pl

synsem <<< lex_ru.
head <<< subj.
subj <<< spr.
spr <<< comps.
comps <<< subj_label.
subj_label <<< spr_label.
spr_label <<< comps_labels.
comps_labels <<< subj_index.
subj_index <<< spr_index.
spr_index <<< comps_indices.
arg1 <<< arg2.
arg2 <<< arg3.


% -------- End of feature ordering ------------

%hidden_feat(aux).
%hidden_feat(case).
%hidden_feat(comps).
%hidden_feat(comps_indices).
%hidden_feat(comps_labels).
%hidden_feat(cont).
hidden_feat(dtrs).              % shown by the tree
hidden_feat(head_dtr).
hidden_feat(lex_ru).
%hidden_feat(phon).
%hidden_feat(spr).
%hidden_feat(spr_index).
%hidden_feat(spr_label).
%hidden_feat(subj).
%hidden_feat(subj_index).
%hidden_feat(subj_label).
%hidden_feat(vform).
