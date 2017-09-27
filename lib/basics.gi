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
#W  basics.gi						Michael Albert,
#W                                  Steve Linton,
#W                                  Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

################################################################################
##
#F PermComplement(perm)
##
## The complement of a permutation [p_1, p_2, ..., p_n] is the permutation 
## [n+1-p_1, n+1-p_2, ... , n+1-p_n] .
## PermComplement calculates the complement of the input permutation which
## has to be input in the non-rank-encoded form.
##
InstallGlobalFunction(PermComplement, function(list)
    local p, i;

    p:=[];

    for i in [1..Length(list)] do
    	Add(p, Length(list)+1-list[i]);
    od;

    return p;

end );

################################################################################
##
#F ComplementAutomaton(aut)
##
## The complement automaton accepts the complement language of aut. In other 
## words it accepts all the complements of the words that are accepted by aut.
##
InstallGlobalFunction(ComplementAutomaton,function(aut)
    local accept;

    accept:=[1..aut!.states];
    SubtractSet(accept,aut!.accepting);

    return Automaton(aut!.type,aut!.states,aut!.alphabet,aut!.transitions,
		aut!.initial,accept);

end );

################################################################################
##
#F IsRankEncoding(perm)
##
## IsRankEncoding checks whether the inputed list (perm) represents a rank 
## encoded permutation.
##
InstallGlobalFunction(IsRankEncoding,function(list)
    local a, m, alph, listnew, i;

    m:=Maximum(list);
    a:=BoundedClassAutomaton(m);
    alph:=AlphabetOfAutomatonAsList(a);
    listnew:=[];

    for i in [1..Length(list)] do
    	Add(listnew,alph[list[i]]);
    od;

    return IsRecognizedByAutomaton(a,listnew);

end );

################################################################################
##
#F IsAcceptedWord(aut,perm)
##
## IsAcceptedWord checks whether the list perm is a permutation output by the 
## the automaton aut. The permutation perm has to be in rank encoding.
##
InstallGlobalFunction(IsAcceptedWord,function(a,list)
    local listnew, i, alph, p;

    p:=ShallowCopy(list);
    alph:=AlphabetOfAutomatonAsList(a);
    listnew:=[];
    
    for i in [1..Length(p)] do
    	Add(listnew,alph[p[i]]);
    od;

    return IsRecognizedByAutomaton(a,listnew);

end );

