#############################################################################
##
##
#W  SubAut.gi						Michael Albert,
#W                                      Steve Linton,
#W                                      Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2017 School of Computer Science,
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

#############################################################################
##
#F  SubPermAut(perm)
##
##  Returns an automaton containing all subpermutations of perm.
##
InstallGlobalFunction(SubPermAut, function(p)
local penc,paut,maxrank,h,revpaut,subaut,wordlist,i,resaut;

penc := RankEncoding(p);

maxrank := Maximum(penc);

penc := SequencesToRatExp([penc]);
paut := RatExpToAut(penc);

h := InvolvementTransducer(maxrank);

revpaut := MinimalAutomaton(ReversedAutomaton(paut));

subaut := MinimalAutomaton(CombineAutTransducer(revpaut,h));

wordlist := [];

for i in [1..Length(p)] do
    Append(wordlist,AcceptedWordsReversed(subaut,i));
od;

resaut := SequencesToRatExp(wordlist);

return MinimalAutomaton(RatExpToAut(resaut));

end);

#############################################################################
##
#F  knSuperPermAutomaton(perm,int,int)
##
##  Returns an automaton accepting all encoded superpermutations involving perm
##  up to rank k and length n.
##
InstallGlobalFunction(SuperPermknAutomaton, function(p,k,n) #n is max length
    local penc,paut,h,revpaut,subaut,wordlist,i,resaut;

    penc := RankEncoding(p);
    penc := SequencesToRatExp([penc]);
    paut := RatExpToAut(penc);

    h := TransposedTransducer(InvolvementTransducer(k));

    revpaut := MinimalAutomaton(ReversedAutomaton(paut));

    subaut := MinimalAutomaton(CombineAutTransducer(revpaut,h));

    wordlist := [];

    for i in [Length(p)..n] do
        Append(wordlist,AcceptedWordsReversed(subaut,i));
    od;

    resaut := SequencesToRatExp(wordlist);

    return MinimalAutomaton(RatExpToAut(resaut));

end);

#############################################################################
##
#F  InbetweenPermAutomaton(perm,perm)
##
##  Returns an automaton accepting all encoded permutations between the
##  two parameters.
##
InstallGlobalFunction(InbetweenPermAutomaton,function(p,q)
local pAut,qAut,k;

k := Maximum(RankEncoding(p));

pAut := SubPermAut(p);
qAut := SuperPermknAutomaton(q,k,Length(p));

return MinimalAutomaton(IntersectionAutomaton(pAut,qAut));

end);

#############################################################################
##
#F  InbetweenPermSet(perm,perm)
##
##  Returns the set of all permutations between the
##  two parameters.
##
InstallGlobalFunction(InbetweenPermSet,function(p,q)
local aut, result, m, n, i, tmp;

aut := InbetweenPermAutomaton(p,q);
m := Length(p);
n := Length(q);

result := [];

for i in [n..m] do
	tmp := AcceptedWords(aut,i);
	Apply(tmp,RankDecoding);
	Append(result,tmp);
od;

return result;

end);
