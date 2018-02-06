% File: test_items.pl

% Format for test items:
%
% t(Item-number,"word word ...", Num-of-solutions).  or
% t(Item-number,"word word ...", Description, Num-of-solutions,Comment-string).


% Intransitive sentences

t(3,"lilly dances",decl_cl,1,'intransitive').
t(5,"she dances",decl_cl,1,'intransitive').
t(6,"he dances",decl_cl,1,'intransitive').

% Transitive sentences

t(7,"lilly likes fido",decl_cl, 1,'transitive').
t(9,"she likes lilly",decl_cl, 1,'transitive').
t(10,"she likes him",decl_cl, 1,'transitive').

t(11,"dances lilly",decl_cl, 0,'wrong word order').
t(12,"likes lilly fido",decl_cl, 0,'wrong word order').

t(13,"lilly dances fido",decl_cl, 0,'intransitive with object').
t(14,"lilly likes",decl_cl, 0,'transitive without object').

% Complex PPs, NPs, APs

t(15,"of lilly",hd_comp_ph,1,'prepositional phrase').

t(18,"of",phrase, 0,'prepositional phrase').
t(20,"fond of",phrase, 0,'adjective phrase').

% Verbs with complex PP, NP, or APs on the right 

%t(21,"lilly is hungry",decl_cl, 1,'V+AP sentence').
%t(22,"lilly is fond of fido",decl_cl, 1,'V+AP sentence').
%t(23,"lilly is fond of",decl_cl, 0,'V+AP sentence').

t(25,"lilly speaks to fido",decl_cl, 1,'V+PP sentence').
t(26,"lilly speaks to",decl_cl, 0,'V+PP sentence').

t(27,"lilly likes fido",decl_cl, 1,'V+NP sentence').

% Two complements

t(30,"lilly shows fido frankfurt",decl_cl, 1,'V+NP+NP sentence').
t(31,"lilly shows frankfurt to fido",decl_cl, 1,'V+NP+PP sentence').

% Specifiers

t(34,"a cat",hd_spr_ph, 1,'Det+N').
t(35,"the cat",hd_spr_ph, 1,'Det+N').

% The subject must be nominative

t(47,"he dances",decl_cl,1,'nominative subject').
t(48,"she dances",decl_cl,1,'nominative subject').
t(49,"him dances",decl_cl,0,'accusative subject').
t(50,"her dances",decl_cl,0,'accusative subject').

% Objects must be accusative

t(51,"she likes i", decl_cl,0,'accusative case').
t(52,"she likes me",decl_cl, 1,'accusative case').
t(53,"she likes you",decl_cl, 1,'accusative case').
t(54,"she likes he",decl_cl, 0,'accusative case').
t(55,"she likes him",decl_cl, 1,'accusative case').
t(56,"she likes she",decl_cl, 0,'accusative case').
t(57,"she likes her",decl_cl, 1,'accusative case').
t(58,"she likes it",decl_cl, 1,'accusative case').
t(59,"she likes we",decl_cl, 0,'accusative case').
t(60,"she likes us",decl_cl, 1,'accusative case').
t(61,"she likes they",decl_cl, 0,'accusative case').
t(62,"she likes them",decl_cl, 1,'accusative case').

% Proper names

t(63,"she likes lilly",decl_cl, 1,'accusative case').
t(64,"lilly likes her",decl_cl, 1,'accusative case').

% The case of noun phrases with common nouns

t(65,"a cat",hd_spr_ph, 1,'Det+N').

% Two second complement

t(68,"lilly shows her me",decl_cl, 1,'V+NP+NP sentence').
t(69,"lilly shows her i",decl_cl, 0,'V+NP+NP sentence').
t(70,"lilly shows frankfurt to me",decl_cl, 1,'V+NP+PP sentence').
t(71,"lilly shows frankfurt to i",decl_cl, 0,'V+NP+PP sentence').


% Main clauses must be finite

t(83,"lilly dances",decl_cl,1,'main clause').
t(84,"lilly dance",decl_cl, 0,'main clause').
t(85,"lilly danced",decl_cl, 1,'main clause').
t(86,"lilly dancing",decl_cl, 0,'main clause').

% "be" + progressive VP

t(87,"is",(word,synsem:loc:cat:comps:[(loc:cat:head:vform:prp)]),1,'progressive "be"').
t(88,"lilly is dancing",decl_cl,1,'progressive "be"').
t(89,"lilly is dance",decl_cl, 0,'progressive "be"').
t(90,"lilly is danced",decl_cl, 0,'progressive "be"').
t(91,"lilly is dances",decl_cl, 0,'progressive "be"').

% "have" + perfect VP

t(92,"has",word, 1,'perfect "have"').
t(93,"lilly has danced",decl_cl,1,'perfect "have"').
t(94,"lilly has dance",decl_cl, 0,'perfect "have"').
t(95,"lilly has dances",decl_cl, 0,'perfect "have"').
t(96,"lilly has dancing",decl_cl, 0,'perfect "have"').

% "will" + base VP

t(97,"will",word, 1,'auxiliary "will"').
t(98,"lilly will dance",decl_cl,1,'auxiliary "will"').
t(99,"lilly will dances",decl_cl, 0,'auxiliary "will"').
t(100,"lilly will danced",decl_cl, 0,'auxiliary "will"').
t(101,"lilly will dancing",decl_cl, 0,'auxiliary "will"').

% Subject-verb agreement

t(102,"i dance",decl_cl,1,'subject-verb agreement').
t(103,"i dances",decl_cl,0,'subject-verb agreement').
t(104,"i danced",decl_cl,1,'subject-verb agreement').

t(105,"you dance",decl_cl,1,'subject-verb agreement').
t(106,"you dances",decl_cl,0,'subject-verb agreement').
t(107,"you danced",decl_cl,1,'subject-verb agreement').

t(108,"he dance",decl_cl,0,'subject-verb agreement').
t(109,"he dances",decl_cl,1,'subject-verb agreement').
t(110,"he danced",decl_cl,1,'subject-verb agreement').

t(111,"lilly dance",decl_cl,0,'subject-verb agreement').
t(112,"lilly dances",decl_cl,1,'subject-verb agreement').
t(113,"lilly danced",decl_cl,1,'subject-verb agreement').

t(114,"she dance",decl_cl,0,'subject-verb agreement').
t(115,"she dances",decl_cl,1,'subject-verb agreement').
t(116,"she danced",decl_cl,1,'subject-verb agreement').

t(117,"it dance",decl_cl,0,'subject-verb agreement').
t(118,"it dances",decl_cl,1,'subject-verb agreement').
t(119,"it danced",decl_cl,1,'subject-verb agreement').

t(120,"we dance",decl_cl,1,'subject-verb agreement').
t(121,"we dances",decl_cl,0,'subject-verb agreement').
t(122,"we danced",decl_cl,1,'subject-verb agreement').

t(123,"they dance",decl_cl,1,'subject-verb agreement').
t(124,"they dances",decl_cl,0,'subject-verb agreement').
t(125,"they danced",decl_cl,1,'subject-verb agreement').

t(126,"a student",phrase,1,'determiner-noun agreement').
t(127,"the student",phrase,1,'determiner-noun agreement').
t(128,"those student",phrase,0,'determiner-noun agreement').
t(129,"a students",phrase,0,'determiner-noun agreement').
t(130,"the students",phrase,1,'determiner-noun agreement').
t(131,"those students",phrase,1,'determiner-noun agreement').

t(132,"a student dances",decl_cl,1,'subject-verb agreement').
t(133,"a student dance",decl_cl,0,'subject-verb agreement').
t(134,"the student dances",decl_cl,1,'subject-verb agreement').
t(135,"the student dance",decl_cl,0,'subject-verb agreement').
t(136,"the students dance",decl_cl,1,'subject-verb agreement').
t(137,"the students dances",decl_cl,0,'subject-verb agreement').
t(138,"those students dance",decl_cl,1,'subject-verb agreement').
t(139,"those students dances",decl_cl,0,'subject-verb agreement').

t(140,"a student danced",decl_cl,1,'subject-verb agreement').
t(141,"the student danced",decl_cl,1,'subject-verb agreement').
t(142,"the students danced",decl_cl,1,'subject-verb agreement').
t(143,"those students danced",decl_cl,1,'subject-verb agreement').

t(144,"a student is dancing",decl_cl,1,'subject-verb agreement').
t(145,"the student is dancing",decl_cl,1,'subject-verb agreement').
t(146,"the students is dancing",decl_cl,0,'subject-verb agreement').
t(147,"those students is dancing",decl_cl,0,'subject-verb agreement').

t(148,"a student are dancing",decl_cl,0,'subject-verb agreement').
t(149,"the student are dancing",decl_cl,0,'subject-verb agreement').
t(150,"the students are dancing",decl_cl,1,'subject-verb agreement').
t(151,"those students are dancing",decl_cl,1,'subject-verb agreement').

t(152,"a student has danced",decl_cl,1,'subject-verb agreement').
t(153,"the student has danced",decl_cl,1,'subject-verb agreement').
t(154,"the students has danced",decl_cl,0,'subject-verb agreement').
t(155,"those students has danced",decl_cl,0,'subject-verb agreement').

t(156,"a student had danced",decl_cl,1,'subject-verb agreement').
t(157,"the student had danced",decl_cl,1,'subject-verb agreement').
t(158,"the students had danced",decl_cl,1,'subject-verb agreement').
t(159,"those students had danced",decl_cl,1,'subject-verb agreement').

t(160,"a student will dance",decl_cl,1,'subject-verb agreement').
t(161,"the student will dance",decl_cl,1,'subject-verb agreement').
t(162,"the students will dance",decl_cl,1,'subject-verb agreement').
t(163,"those students will dance",decl_cl,1,'subject-verb agreement').

% Auxiliaries: form government and word order

% Note: for the following test items we use the irregular main verb "eat",
% because - unlike "dance" - it has different forms for the past tense and the perfect.
% This way, we can illustrate, that the grammar makes the correct predictions for
% all inflectional forms.

t(164,"fido eats an apple",decl_cl, 1,'main clause').
t(165,"fido ate an apple",decl_cl, 1,'main clause').
t(166,"fido eat an apple",decl_cl, 0,'main clause').
t(167,"fido eating an apple",decl_cl, 0,'main clause').
t(168,"fido eaten an apple",decl_cl, 0,'main clause').

t(169,"fido is eating an apple",decl_cl, 1,'be+progressive').
t(170,"fido is ate an apple",decl_cl, 0,'be+progressive').
t(171,"fido is eat an apple",decl_cl, 0,'be+progressive').
t(172,"fido is eaten an apple",decl_cl, 0,'be+progressive').
t(173,"fido eating is an apple",decl_cl, 0,'be+progressive').

t(174,"fido was eating an apple",decl_cl, 1,'be+progressive').
t(175,"fido was ate an apple",decl_cl, 0,'be+progressive').
t(176,"fido was eat an apple",decl_cl, 0,'be+progressive').
t(177,"fido was eaten an apple",decl_cl, 0,'be+progressive').
t(178,"fido eating was an apple",decl_cl, 0,'be+progressive').

t(179,"fido has eaten an apple",decl_cl, 1,'have+perfect').
t(180,"fido has ate an apple",decl_cl, 0,'have+perfect').
t(181,"fido has eat an apple",decl_cl, 0,'have+perfect').
t(182,"fido has eating an apple",decl_cl, 0,'have+perfect').
t(183,"fido eaten has an apple",decl_cl, 0,'have+perfect').

t(184,"fido had eaten an apple",decl_cl, 1,'have+perfect').
t(185,"fido had ate an apple",decl_cl, 0,'have+perfect').
t(186,"fido had eat an apple",decl_cl, 0,'have+perfect').
t(187,"fido had eating an apple",decl_cl, 0,'have+perfect').
t(188,"fido eaten had an apple",decl_cl, 0,'have+perfect').

t(189,"fido has been eating an apple",decl_cl, 1,'have+be+main verb').
t(190,"fido has be eating an apple",decl_cl, 0,'have+be+main verb').
t(191,"fido has is eating an apple",decl_cl, 0,'have+be+main verb').
t(193,"fido been has eating an apple",decl_cl, 0,'have+be+main verb').

t(194,"fido had been eating an apple",decl_cl, 1,'have+be+main verb').
t(195,"fido had be eating an apple",decl_cl, 0,'have+be+main verb').
t(196,"fido had is eating an apple",decl_cl, 0,'have+be+main verb').
t(198,"fido been had eating an apple",decl_cl, 0,'have+be+main verb').

t(199,"fido will eat an apple",decl_cl, 1,'modal+bare infinitive').
t(200,"fido will eats an apple",decl_cl, 0,'modal+bare infinitive').
t(201,"fido will eating an apple",decl_cl, 0,'modal+bare infinitive').
t(202,"fido will eaten an apple",decl_cl, 0,'modal+bare infinitive').
t(203,"fido eat will an apple",decl_cl, 0,'modal+bare infinitive').

t(204,"fido will be eating an apple",decl_cl, 1,'modal+be+main verb').
t(205,"fido will is eating an apple",decl_cl, 0,'modal+be+main verb').
t(206,"fido will been eating an apple",decl_cl, 0,'modal+be+main verb').
t(208,"fido be will eating an apple",decl_cl, 0,'modal+be+main verb').

t(209,"fido will have eaten an apple",decl_cl, 1,'modal+have+main verb').
t(210,"fido will has eaten an apple",decl_cl, 0,'modal+have+main verb').
t(212,"fido will had eaten an apple",decl_cl, 0,'modal+have+main verb').
t(213,"fido have will eaten an apple",decl_cl, 0,'modal+have+main verb').

t(214,"fido will have been eating an apple",decl_cl, 1,'modal+have+be+main verb').
t(215,"fido will have eating been an apple",decl_cl, 0,'modal+have+be+main verb').
t(216,"fido will been have eating an apple",decl_cl, 0,'modal+have+be+main verb').
t(218,"fido will eating have been an apple",decl_cl, 0,'modal+have+be+main verb').
t(219,"fido will eating been have an apple",decl_cl, 0,'modal+have+be+main verb').

t(222,"fido does ate an apple",decl_cl,0,'do+main verb').
t(223,"fido does eaten an apple",decl_cl,0,'do+main verb').
t(224,"fido does eating an apple",decl_cl,0,'do+main verb').
t(225,"fido does be eating an apple",decl_cl,0,'do+main verb').
t(226,"fido does have eaten an apple",decl_cl,0,'do+main verb').
t(227,"fido does will eat an apple",decl_cl,0,'do+main verb').

% Control

% try

t(433,"lilly tried to dance",@root,1,'subject control verb "try"').
t(449,"lilly will try to have danced",@root,1,'subject control verb "try"').
t(450,"lilly will try to be dancing",@root,1,'subject control verb "try"').
t(451,"lilly will try to have been dancing",@root,1,'subject control verb "try"').

t(452,"lilly will try to visit fido",@root,1,'subject control verb "try"').

% persuade

t(453,"lilly persuaded fido to dance",@root,1,'object control verb "persuade"').
t(469,"lilly will persuade fido to visit me",@root,1,'object control verb "persuade"').

