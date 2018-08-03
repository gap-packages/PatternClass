################################################################################
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
#W  inversion.gi						Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science,
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

################################################################################
##
#F InversionAut(k)
##
## InversionAut builds the automaton that accepts all permutations under the
## rank encoding with exactly k inversions.
##
##
InstallGlobalFunction(InversionAut,function(k)
local siz,alph,strt,acc,trans,temp,i,aut;

siz:=k+3;
alph:=k+1;
strt:=[1];
acc:=[k+2];

trans:=[];
temp:=[1..k];
Append(temp,ListWithIdenticalEntries(2,k+2));
Add(temp,siz);
Add(trans,temp);
for i in [2..alph] do
    temp:=[i..k+1];
    Append(temp,ListWithIdenticalEntries(i+1,siz));
    Add(trans,temp);
od;

aut:=Automaton("det",siz,alph,trans,strt,acc);

return MinimalAutomaton(IntersectionAutomaton(aut,BoundedClassAutomaton(k+1)));

end );

################################################################################
##
#F InversionAutOfClass(aut,inv)
##
## InvserionAutOfClass returns the automaton that accepts all permutations under
## the rank encoding, lying in the regular class aut, that have exactly inv
## inversions.
##
InstallGlobalFunction(InversionAutOfClass,function(a,inv)
local iaut,aaut;

iaut:=InversionAut(inv);

if AlphabetOfAutomaton(a) < AlphabetOfAutomaton(iaut) then
    aaut:=ExpandAlphabet(a,AlphabetOfAutomaton(iaut));
elif AlphabetOfAutomaton(a) > AlphabetOfAutomaton(iaut) then
    iaut:=ExpandAlphabet(iaut,AlphabetOfAutomaton(a));
    aaut:=a;
else
    aaut:=a;
fi;

return IntersectionAutomaton(iaut,aaut);

end );

################################################################################
##
#F LoopFreeAut(aut)
##
## LoopFreeAut returns the subautomaton of aut that contains no loops of the
## form (i,i,x) where i is a state and x is any letter in the alphabet.
##
InstallGlobalFunction(LoopFreeAut,function(a)
local trans,j,i;

trans:=List(a!.transitions, ShallowCopy);

for j in [1..Length(trans[1])] do
    for i in [1..Length(trans)] do
        Add(trans[i],a!.states+1);
        if trans[i][j]=j then
            trans[i][j]:=a!.states+1;
        fi;
    od;
od;


return Automaton("det",a!.states+1,a!.alphabet,trans,a!.initial,a!.accepting);

end );

################################################################################
##
#F LoopVertexFreeAut(aut)
##
## LoopVertexFreeAut builds the subautomaton of aut that does not contain the
## vertices and their transitions in aut that loop to themselves.
##
InstallGlobalFunction(LoopVertexFreeAut,function(a)
local acc,ll,trans,i,j,x,sink;

acc:=FinalStatesOfAutomaton(a);
ll:=[];
trans:=List(a!.transitions, ShallowCopy);
sink:=a!.states+1;

for i in [1..Length(trans)] do
    for j in [1..Length(trans[i])] do
        if trans[i][j]=j then
            Add(ll,j);
        fi;
        Add(trans[i],sink);
    od;
od;

for x in [1..a!.states] do
    if x in ll then
        for i in [1..Length(trans)] do
       	    Unbind(trans[i][x]);
        od;
    else
        for i in [1..Length(trans)] do
            if trans[i][x] in ll then
                trans[i][x]:=sink;
            fi;
        od;
    fi;
od;

return MinimalAutomaton(Automaton("nondet",a!.states+1,a!.alphabet,trans,a!.initial,a!.accepting));

end );
