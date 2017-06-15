

%% Verb looking for expletive "it" as subject

t(1,"it has snowed", 1).
t(2,"there has snowed", 0).
t(3,"robin has snowed", 0).

%% Verb looking for expletive "there" as subject

t(4,"it is a cake", 0).
t(5,"there is a cake", 1).
t(6,"robin is a cake", 0).

%% Verb looking for a referential subject

t(7,"it leapt", 1).
t(8,"there leapt", 0).
t(9,"robin leapt", 1).

%%%% Add test items with expletives in object position!!!


t(10,"robin eats her breakfast", 1).
t(11,"robin ate her breakfast", 1).
t(12,"robin eat her breakfast", 0).
t(13,"robin eating her breakfast", 0).
t(14,"robin eaten her breakfast", 0).

t(15,"robin is eating her breakfast", 1).
t(16,"robin is ate her breakfast", 0).
t(17,"robin is eat her breakfast", 0).
t(18,"robin is eaten her breakfast", 0).
t(19,"robin eating is her breakfast", 0).

t(20,"robin was eating her breakfast", 1).
t(21,"robin was ate her breakfast", 0).
t(22,"robin was eat her breakfast", 0).
t(23,"robin was eaten her breakfast", 0).
t(24,"robin eating was her breakfast", 0).

t(25,"robin has eaten her breakfast", 1).
t(26,"robin has ate her breakfast", 0).
t(27,"robin has eat her breakfast", 0).
t(28,"robin has eating her breakfast", 0).
t(29,"robin eaten has her breakfast", 0).

t(30,"robin had eaten her breakfast", 1).
t(31,"robin had ate her breakfast", 0).
t(32,"robin had eat her breakfast", 0).
t(33,"robin had eating her breakfast", 0).
t(34,"robin eaten had her breakfast", 0).

t(35,"robin has been eating her breakfast", 1).
t(36,"robin has be eating her breakfast", 0).
t(37,"robin has is eating her breakfast", 0).
t(38,"robin has being eating her breakfast", 0).
t(39,"robin been has eating her breakfast", 0).

t(40,"robin had been eating her breakfast", 1).
t(41,"robin had be eating her breakfast", 0).
t(42,"robin had is eating her breakfast", 0).
t(43,"robin had being eating her breakfast", 0).
t(44,"robin been had eating her breakfast", 0).

t(45,"robin will eat her breakfast", 1).
t(46,"robin will eats her breakfast", 0).
t(47,"robin will eating her breakfast", 0).
t(48,"robin will eaten her breakfast", 0).
t(49,"robin eat will her breakfast", 0).

t(50,"robin will be eating her breakfast", 1).
t(51,"robin will is eating her breakfast", 0).
t(52,"robin will been eating her breakfast", 0).
t(53,"robin will being eating her breakfast", 0).
t(54,"robin be will eating her breakfast", 0).

t(55,"robin will have eaten her breakfast", 1).
t(56,"robin will has eaten her breakfast", 0).
t(57,"robin will having eaten her breakfast", 0).
t(58,"robin will had eaten her breakfast", 0).
t(59,"robin have will eaten her breakfast", 0).

t(60,"robin will have been eating her breakfast", 1).
t(61,"robin will have eating been her breakfast", 0).
t(62,"robin will been have eating her breakfast", 0).
t(63,"robin will been eating have her breakfast", 0).
t(64,"robin will eating have been her breakfast", 0).
t(65,"robin will eating been have her breakfast", 0).

t(66,"robin does eat her breakfast",1).
t(67,"robin did eat her breakfast",1).
t(68,"robin does ate eating her breakfast",0).
t(69,"robin does eating eating her breakfast",0).
t(70,"robin does eaten eating her breakfast",0).
t(71,"robin does be eating her breakfast",0).
t(72,"robin does have eaten her breakfast",0).

t(73,"i smoke",1).
t(74,"you smoke",2).
t(75,"he smokes",1).
t(76,"she smokes",1).
t(77,"it smokes",1).
t(78,"robin smokes",1).
t(79,"we smoke",1).
t(80,"they smoke",1).

t(81,"i smokes",0).
t(82,"you smokes",0).
t(83,"he smoke",0).
t(84,"she smoke",0).
t(85,"it smoke",0).
t(86,"robin smoke",0).
t(87,"we smokes",0).
t(88,"they smokes",0).

t(89,"robin ate my cake",1).
t(90,"robin ate my",0).
t(91,"robin ate my my",0).
t(92,"robin ate you cake",0).
t(93,"robin ate leslie s cake",1).
t(94,"robin ate my leslie s cake",0).

t(95,"this person",1).
t(96,"this persons",0).
t(97,"this people",0).
t(98,"those people",1).
t(99,"which person",1).
t(100,"which persons",1).
t(101,"which people",1).

t(102,"this person is coming",1).
t(103,"this person are coming",0).
t(104,"those people is coming",0).
t(105,"those people are coming",1).

t(106,"i doubt this person is coming",1).
t(107,"i doubt this person are coming",0).
t(108,"i doubt those people is coming",0).
t(109,"i doubt those people are coming",1).

t(110,"this person i doubt is coming",1).
t(111,"this person i doubt  are coming",0).
t(112,"those people i doubt  is coming",0).
t(113,"those people i doubt  are coming",1).

t(114,"which person do you doubt is coming",1).
t(115,"which people do you doubt is coming",0).
t(116,"which person do you doubt are coming",0).
t(117,"which people do you doubt are coming",1).

t(118,"i consider those people unreliable",1).
t(119,"i consider those people beyond belief",2).
t(120,"i consider those people a threat",1).
t(121,"i consider those people to have abandoned any claims",1).

t(122,"i consider those people asleep",1).
t(123,"i consider those people former",0).
t(124,"i consider those people alleged",0).

t(125,"i met an unreliable person",1).
t(126,"i met a former senator",1).
t(127,"i met an alleged murderer",1).
t(128,"i met an asleep person",0).

t(129,"my next visit to paris",1).
t(130,"robin s next visit to paris",1).
t(131,"the king of england s next visit to paris",1).
t(132,"my best friend s wife s next visit to paris",1).

t(133,"robin baked leslie a cake",1).
t(134,"that student of chemistry",1).

t(135,"that robin met leslie annoys me",1).
t(136,"that robin met leslie irritates me",1).
t(137,"that robin met leslie amuses me",1).
t(138,"that robin met leslie surprises me",1).
t(139,"that robin met leslie disturbs me",1).

t(140,"it annoys me that robin met leslie",1).
t(141,"it irritates me that robin met leslie",1).
t(142,"it amuses me that robin met leslie",1).
t(143,"it surprises me that robin met leslie",1).
t(144,"it disturbs me that robin met leslie",1).

t(145,"who do you doubt is coming",1).

% Verbs with PP-complements

t(146,"leslie showed the letter to kim",1).

% Short and long passive

t(147,"the letter was shown to kim",1).
t(148,"the letter was shown to kim by leslie",1).

% Questions

t(149,"who smokes",1).
t(150,"who does kim call",1).
t(151,"who kim call",0).
t(152,"who kim called",0).

t(153,"which senator did kim call",1).







