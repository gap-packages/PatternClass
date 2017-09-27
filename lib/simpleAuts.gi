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
#W  simpleAuts.gi                       Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

################################################################################
##
#F  GapGen(k)
##
## Returns the list of all lists of gap sizes possible for k. 
##
InstallGlobalFunction(GapGen,function(k)
local res,i,tmp,j;
#Single gaps
res:=List([1 .. k-1],i->[i]);

for i in res do
    for j in [1 .. k-1] do
        tmp:=StructuralCopy(i);
        Add(tmp,j);
        if Sum(tmp) <= k-1 then
            Add(res,StructuralCopy(tmp));
        else
            break;
        fi;
    od;
od;

return res;

end );

################################################################################
##
#F  LengthBoundAut(aut,min,max,k)
##
## Constructs the automaton that accepts all words of aut of lengths between 
## (and including) min and max.
##
InstallGlobalFunction(LengthBoundAut,function(aut,min,max,k)

local akstates,aktrans,i,tmp,j,akaut;

akstates:=max+2;
aktrans:=[2..akstates];
Add(aktrans,akstates);
aktrans:=ListWithIdenticalEntries(k,aktrans);

akaut:=Automaton("det",akstates,k,aktrans,[1],[min+1..max+1]);

return NDIntersectionAutomaton(aut,akaut);

end );

################################################################################
##
#F  ShiftAut(i,k)
##
## Returns the bounded class automaton but with the alphabet shifted (by value)
## up by i, to at most k. (excluding the empty perm and the perm of length 1)
##
InstallGlobalFunction(ShiftAut,function(i,k)
local a, b,shifttrans;

a := BoundedClassAutomaton(k-i);
b := Automaton("det",3,k-i,ListWithIdenticalEntries(k-i,[2,3,3]),[1],[3]);
a := NDIntersectionAutomaton(a,b);

shifttrans:=ListWithIdenticalEntries(i,ListWithIdenticalEntries(NumberStatesOfAutomaton(a),0));
Append(shifttrans,TransitionMatrixOfAutomaton(a));

return Automaton(a!.type,NumberStatesOfAutomaton(a),Length(shifttrans),shifttrans,InitialStatesOfAutomaton(a),FinalStatesOfAutomaton(a));

end );

################################################################################
##
#F  NextGap(gap,rank)
##
## Knowing the gap sizes, and the rank of the point, NextGap calculates the next
## gap sizes when we add the point of that rank to the permutation.
##
InstallGlobalFunction(NextGap,function(gap,rank)
local resgap, i,a,b;

resgap:=StructuralCopy(gap);

if rank <= Sum(gap) then
    for i in [1 .. Length(gap)] do
        if rank = Sum(gap{[1 .. i]}) then
            resgap[i]:=resgap[i]-1;
            break;
        elif rank < Sum(gap{[1..i]}) then
            a:=rank - Sum(gap{[1..i-1]}) - 1;
            b:=gap[i] - a - 1;
            Add(resgap,a,i);
            resgap[i+1]:=b;
            break;
        fi;
    od;
else
    Add(resgap,rank-Sum(gap)-1);
fi;

if 0 in resgap and Length(resgap) > 1 then
    Remove(resgap,Position(resgap,0));
fi;

return resgap;

end );

################################################################################
##
#F  GapAut(k)
##
## Returns the automaton, which has an alphabet of k, the set of states is the  
## set of all possible gaps, the transition function is defined by the gap and 
## the rank (see NextGap), the inital state is the emptyset of gap states, the
## accept states are the inital state and the state where the gap sizes is [0].
## This automaton is just an extended form of the bounded class automaton of k,
## the language is the same.
##
InstallGlobalFunction(GapAut,function(k)
local sts,trans,start,accept,i,tmpt,r;

sts:=[[]];
trans:=[];
start:=[1];
accept:=[1,2];

i:=1;

while i <= Length(sts) do
    tmpt:=[];
    for r in [1 .. k] do
        if not(NextGap(sts[i],r) in sts) then
            Add(sts,NextGap(sts[i],r));
        fi;
        Add(tmpt,Position(sts,NextGap(sts[i],r)));
    od;
    Add(trans,StructuralCopy(tmpt));
    i:=i+1;
od;

return [Automaton("nondet",Length(sts),k,TransposedMat(trans),start,accept),sts];

end );

################################################################################
##
#F  SumAut(gapaut,sum,k)
##
## Constructs the automaton that accepts the prefixes of rank encoded permutations.
## The prefixes end in gap sizes which have total sum equal to sum.
##
InstallGlobalFunction(SumAut,function(gaut,sum,k)
local aut,accept,i;

aut:=gaut[1];
accept:=[];

for i in [1 .. Length(gaut[2])] do
    if Sum(gaut[2][i]) = sum then
        Add(accept,i);
    fi;
od;

return Automaton(aut!.type,aut!.states,aut!.alphabet,aut!.transitions,aut!.initial,accept);

end );

################################################################################
##
#F  GapSumAut(gapaut,gap,sum,k)
##
## Constructs the automaton that accepts the prefixes of rank encoded permutations.
## The prefixes end with a gap of size gap and the sum of gap sizes before (or below
## in the plot) that gap has to equal to sum.
##
InstallGlobalFunction(GapSumAut, function(gaut,gap,sum,k)
local aut,accept,i,j;

aut:=gaut[1];
accept:=[];

for i in [1 .. Length(gaut[2])] do
    if gap in gaut[2][i] then 
        for j in Positions(gaut[2][i],gap) do
            if j = 1 and sum = 0 then
                Add(accept,i);
            elif sum = Sum(gaut[2][i]{[1..j-1]}) then
                Add(accept,i);
            fi;
        od;
    fi;
od;

return Automaton(aut!.type,aut!.states,aut!.alphabet,aut!.transitions,aut!.initial,accept);

end );


################################################################################
##
#F  NonSimpleAut(k)
##
## Constructs the automaton that accepts all non-simple permutations with highest
## rank being k in their rank encoding.
##
InstallGlobalFunction(NonSimpleAut, function(k)
local emptylang,boundedaut,lhsaut,rhsaut,gaut,i,a,b,tmp,tmp1,tmp2,pi,sj,j;

emptylang:=Automaton("det",1,k,ListWithIdenticalEntries(k,[1]),[1],[]);
boundedaut:=BoundedClassAutomaton(k);

lhsaut:=emptylang;
rhsaut:=emptylang;

gaut:=GapAut(k);

# The interval is of unlimited length and is not at the beginning
tmp:=emptylang;
for i in [k-1, k-2 .. 1] do
    tmp:=NDUnionAutomata(ShiftAut(i,k),tmp);
    lhsaut:=ReducedNFA(EpsilonToNFA(NDUnionAutomata(NDProductOfLanguages(SumAut(gaut,i,k),tmp),lhsaut)));
#    lhsaut:=NDUnionAutomata(NDProductOfLanguages(SumAut(gaut,i,k),tmp),lhsaut);
od;
#Print(lhsaut!.states,",",Sum(List(lhsaut!.transitions,i->Sum(List(i,Length)))),"\n");

# The interval is of unlimited length and is at the beginning of the perm
for i in [1 .. k-1] do
	tmp:=ShiftAut(i,k);
    lhsaut:=ReducedNFA(EpsilonToNFA(NDUnionAutomata(lhsaut,tmp)));
#    lhsaut:=NDUnionAutomata(lhsaut,tmp);

od;

#Print(lhsaut!.states,",",Sum(List(lhsaut!.transitions,i->Sum(List(i,Length)))),"\n");

lhsaut:=NDProductOfLanguages(lhsaut,ComplementAutomaton(emptylang));

# The interval is of limited length (there are points above and to the left of it)
for a in [2 .. k-1] do
	for b in [0 .. k-1-a] do
        tmp:=GapSumAut(gaut,a,b,k);
		for i in [0 .. a-2] do
            tmp1:=LengthBoundAut(ShiftAut(b+i,k),2,a-i,k);
            tmp2:=NDProductOfLanguages(tmp,tmp1);
            rhsaut:=ReducedNFA(EpsilonToNFA(NDUnionAutomata(rhsaut,tmp2)));
#            rhsaut:=NDUnionAutomata(rhsaut,tmp2);
		od;
	od;
od;

#Print(rhsaut!.states,",",Sum(List(rhsaut!.transitions,i->Sum(List(i,Length)))),"\n\n");

rhsaut:=NDProductOfLanguages(rhsaut,ComplementAutomaton(emptylang));

# Finally not to forget about some of the plus-decomposable perms
rhsaut:=NDUnionAutomata(rhsaut,PlusDecomposableAut(boundedaut));
rhsaut:=ReducedNFA(EpsilonToNFA(NDUnionAutomata(lhsaut,rhsaut)));
#rhsaut:=NDUnionAutomata(lhsaut,rhsaut);

return NDIntersectionAutomaton(boundedaut,rhsaut);


end );

################################################################################
##
#F  SimplePermAut(k)
##
## Constructs the automaton of all simple permutations with rank encoding at 
## most k.
##
InstallGlobalFunction(SimplePermAut, function(k)
local boundedaut,resaut;

boundedaut:=BoundedClassAutomaton(k);
resaut:=NDIntersectionAutomaton(boundedaut,ComplementAutomaton(MinimalAutomaton(NonSimpleAut(k))));

return MinimalAutomaton(resaut);

end );


################################################################################
##
#F  ExceptionalBoundedAutomaton(k)
##
##  Returns the automaton that accepts exceptional permutations with rank 
##  encoding at most k.
##
InstallGlobalFunction(ExceptionalBoundedAutomaton, function(k)
local t,i,j,p,m,n,res;

res:=[];

#
# x is half the length of the permutation
#

## 2 3 4 ... x+1 1 1 1 ... 1
t:=[];
for i in [2..k] do
    p:=[2..i];
    Append(p,ListWithIdenticalEntries(i-1,1));
    Add(t,p);
od;
Append(res,t);


## x (2x-1) (x-1) (2x-3) ... 1 1
t:=[];
if (k mod 2) = 0 then
    m:=k-1;
else
    m:=k;
fi;

for i in [1,3..m] do
    p:=[i,i-2..1];
    n:=Int(Ceil(Float(i/2)));
    Append(p,[n,n-1..1]);
    Add(t,p);
od;
Append(res,t);


## (x+1) 1 x 1 ... 2 1
t:=[];
for i in [2..k] do
    p:=ListWithIdenticalEntries(i-1,1);
    for j in [i-1,i-2..1] do
        Add(p,i-j+1,j);
    od;
    Add(t,p);
od;
Append(res,t);


## (2x-1) (2x-3) ... 1 x (x-1) ... 1
t:=[];
for i in [1,3..m] do
    p:=[i,i-2..1];
    n:=Int(Ceil(Float(i/2)));
    for j in [n,n-1..1] do
        Add(p,n-j+1,j);
    od;
    Add(t,p);
od;
Append(res,t);

res:=Unique(res);

res:=RatExpToAut(SequencesToRatExp(res));

return MinimalAutomaton(res);

end );

################################################################################
#### IsExceptionalPerm could possibly improved by building an automaton
#### that only accepts exceptional permutations of all lengths and then
#### check whether the input is accepted by such an automaton.
################################################################################
################################################################################
##
#F  IsExceptionalPerm(perm)
##
## First checks whether perm has even length, then (if it does) compares it
## against the 4 different types of exceptional permutations in their rank
## encoding.
##
InstallGlobalFunction(IsExceptionalPerm, function(list)
local m,p;

if Length(list) mod 2 = 0 then 
    m:=Length(list)/2;
    if IsRankEncoding(list) then
        p:=ShallowCopy(list);
    else 
        p:=RankEncoding(list);
    fi;
    if (p{[1..m]}=[2..m+1]) and (Positions(p{[m+1..2*m]},1) = [1..m]) then
        return true;
    elif (Reversed(p{[1..m]})=[1,3..2*m-1]) and 
                (Reversed(p{[m+1..2*m]})=[1..m]) then
        return true;
    elif (p{[2,4..2*m]}=ListWithIdenticalEntries(m,1)) and 
                (Reversed(p{[1,3..2*m-1]})=[2..m+1]) then
        return true;
    elif (Reversed(p{[1,3..2*m-1]})=[1..m]) and 
                (Reversed(p{[2,4..2*m]})=[1,3..2*m-1]) then
        return true;
    else
        return false;
    fi;
else
    return false;
fi;

end );
