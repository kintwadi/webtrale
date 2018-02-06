% generate code for generation
%:- ale_flag(pscompiling,_,parse_and_gen).   %% fr



% feature hiding and ordering
hidden_feat(dtrs).      % hide the dtrs attribute (shown by tree)


% use ghostview for drawing signatures
%graphviz_option(ps,gv).                     %% fr
%graphviz_option(svg,squiggle).


%:- ale_flag(chart_display,_,on).            %% fr

% :- nochart_debug.  % this helps if somebody interrupted during chart debugging and the                                     %% fr
                   % flag is still set to 'on'.

%nochart_display.
%chart_display.       % default

%:- german.                                   %% fr

%:- notcl_warnings.  % on = output of warnings in a TCL window, off = output to console          %% fr

%:- hrp.  % use grisu for rules          %% fr

%:- nofs. % do not print feature structures after parsing



% some flags:


% So if there is a general type A that introduces two features and the values of these features
% are different on all of its subtypes, then inequations are added to A.

% According to Gerald working with this on, type inference is NP complete.
% Makes the system slower at compile time and run time.

% Strangely enough this affects sentences with coordination. With subtype covering on
% Persian "Ali telefon kard va fout kard." does not parse, with off it does.

% The same for Danish: Bjarne spørger hvem der kommer og synger.


:- ale_flag(subtypecover,_,off).


% Gerald Penn, 03.06.2012
%
% ALE never had support for "unfilling", at least in one reading of that term,
% until now.
%   But now it does.  We're not going to call it unfilling ,however, because
% that term has been so molested that it's going to confuse everyone.  We'll
% call it "sparse output."
%   To turn this on, use ale_flag(sparseoutput,_,on).

:- ale_flag(sparseoutput,_,on).


%chart_display :-
%        ale_flag(chart_display,_,on).        %% fr

%nochart_display :-
%        ale_flag(chart_display,_,off).       %% fr


% This tries to eliminate as many inconsistent rules which otherwise would result from EFD closure computation.
%:-ale_flag(ruleindexscope,_,localresolve).

% Do not ask any questions!
:-ale_flag(another,_,autoconfirm).
