#############################################################################
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 2 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
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

if Length(q) = 1 then
    return MinimalAutomaton(SubPermAut(p));
fi;

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

#############################################################################
##
#F  IsSubPerm(perm,perm)
##
##  Checks whether the second permutation is a subpermutation of the first.
##
InstallGlobalFunction(IsSubPerm, function(p,q)

local penc,qenc,paut,maxrank,h,revpaut,subaut;

penc := RankEncoding(p);
qenc := Reversed(RankEncoding(q));

maxrank := Maximum(penc);

if maxrank < Maximum(qenc) then
    return false;
fi;

penc := SequencesToRatExp([penc]);
paut := RatExpToAut(penc);

h := InvolvementTransducer(maxrank);
revpaut := MinimalAutomaton(ReversedAutomaton(paut));
subaut := MinimalAutomaton(CombineAutTransducer(revpaut,h));

return IsAcceptedWord(subaut,qenc);

end);
