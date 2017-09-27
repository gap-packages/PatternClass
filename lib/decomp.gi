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
#W  decomp.gi						Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

################################################################################
##
#F IsPlusDecomposable(perm)
##
## IsPlusDecomposable uses the fact that there has to be an interval 1..x where 
## x<n (n=length of the permutation) in the permutation that is a rank encoding,
## to check whether perm is a plus-decomposable permutation.
##
## Side Note: The permutation [1,2] (encoded as [1,1]) is seen as a
## plus-decomposable permutation, as it displays the characteristics of such
## a permutation, eventhough it is also a simple permutation.
##
InstallGlobalFunction(IsPlusDecomposable,function(list)
    local p, i;

    i:=1;

    if IsRankEncoding(list) then
        p:=ShallowCopy(list);
    else
	p:=RankEncoding(list);
    fi;
    
    while (i<Length(list)) do
        if IsRankEncoding(p{[1..i]}) then

	    return true;

	else
	    i:=i+1;
	fi;
    od;

    if (i=Length(list)) then

        return false;

    fi;

end );

################################################################################
##
#F IsMinusDecomposable(perm)
##
## IsMinusDecomposable checks whether the permutation perm is minus decomposable
## by checking whether the complement of the permutation is plus decomposable.
##
## Side Note: The permutation [2,1] (encoded as [2,1]) is seen as a
## minus-decomposable permutation, as it displays the characteristics of such
## a permutation, eventhough it is also a simple permutation.
##
InstallGlobalFunction(IsMinusDecomposable,function(list)
    local p;

    if IsRankEncoding(list) then
        p:=RankDecoding(list);
    else
        p:=ShallowCopy(list);
    fi;

    if (not IsPlusDecomposable(p)) then
        p:=PermComplement(p);
	if IsPlusDecomposable(p) then

	    return true;

    	else

	    return false;

	fi;
    else

	return false;

    fi;

end );

################################################################################
##
#F IsSimplePerm(perm)
##
## IsSimplePerm checks whether the permutation perm is simple, i.e. there are no
## non-trivial intervals within perm.
##
InstallGlobalFunction(IsSimplePerm,function(list)
    local i, j, p, n, l, u;

    if (not IsPlusDecomposable(list) and not IsMinusDecomposable(list)) then 
        if IsRankEncoding(list) then
            p:=RankDecoding(list);
        else
            p:=ShallowCopy(list);
    	fi;
        n:=Length(p);
    	for i in [1..n-1] do
            l:=p[i];
            u:=p[i];
    	    for j in [i+1..Minimum(n,i+n-3)] do
                l:=Minimum(l,p[j]);
                u:=Maximum(u,p[j]);
               	if u-l > Minimum(n-i,n-3) then
                    break;
            	elif u-l-(j-i)=0 then
                    return false;
            	fi;
    	    od;
        od;
        return true;
    else 
        return false;
    fi;

end );

################################################################################
##
#F PlusIndecomposableAut(aut)
##
## The PlusIndecomposableAutomaton accepts the language of all 
## plus-indecomposable permutations of the encoded class accepted by aut.
##
InstallGlobalFunction(PlusIndecomposableAut,function(aut)
    local states, acc, trans, i, j, temp, fin;

    temp:=aut;
    states:=NumberStatesOfAutomaton(temp)+2;
    fin:=FinalStatesOfAutomaton(temp);
    acc:=Concatenation([states-1],fin);
    trans:=List(TransitionMatrixOfAutomaton(temp), ShallowCopy);

    for i in [1..Length(TransitionMatrixOfAutomaton(temp))] do
    	Add(trans[i],trans[i][1],states-1);
    	Add(trans[i],states,states);
        for j in [1..Length(fin)] do
            trans[i][fin[j]]:=states;
    	od;
    od;

    return Automaton("det",states,AlphabetOfAutomatonAsList(temp),trans,[states-1],acc);
end );

################################################################################
##
#F PlusDecomposableAut(aut)
##
## The PlusDecomposableAutomaton accepts the language of all 
## plus-decomposable permutations of the encoded class accepted by aut.
##
InstallGlobalFunction(PlusDecomposableAut,function(aut)
    local res;

    res:=IntersectionAutomaton(ComplementAutomaton(PlusIndecompAut(aut)),aut);

    return MinimalAutomaton(res);

end );

################################################################################
##
#F LdkAut(d,k)
##
## LdkAut is an auxiliary function to build an intermediate automaton, which 
## will be used to build the automaton that accepts all minus-decomposable 
## permutations of a class. The LdkAut automaton accepts the language 
## {{1,..d}^d {d+1,..k}^+} .
##
InstallGlobalFunction(LdkAut,function(d,k)
    local trans, i, j;

    trans:=[];

    for i in [1..d] do
        Add(trans,[]);
	for j in [1..d] do
	    trans[i][j]:=j+1;
	od;
	Append(trans[i],[d+3,d+3,d+3]);
    od;

    for i in [d+1..k] do
    	Add(trans,[]);
	for j in [1..d+3] do
            if (j <= d) or (j = d+3) then
                trans[i][j]:=d+3;
            else
		trans[i][j]:=d+2;
            fi;
	od;
    od;


    return Automaton("det",d+3,k,trans,[1],[d+2]);

end );

################################################################################
##
#F LAut(k)
##
## LAut is another auxiliary function to build an intermediate automaton, which 
## will be used to build the automaton that accepts all minus-decomposable 
## permutations of a class. LAut is the union of LdkAut over the range of d in
## [1..k-1] .
##
InstallGlobalFunction(LAut,function(k)
local tempaut,aut,i;

tempaut:=LdkAut(1,k);
for i in [2..k-1] do
    aut:=NDUnionAutomata(tempaut,LdkAut(i,k));
    tempaut:=aut;
    Unbind(aut);
od;

return tempaut;
end );

################################################################################
##
#F MinusDecomposableAut(aut)
##
## MinusDecomposableAut finds the regular language that is build by all simple
## permutations of the encoded class accepted by aut.
##
InstallGlobalFunction(MinusDecomposableAut,function(aut)
    local res,l;

    l:=ReversedAutomaton(LAut(aut!.alphabet));
    return NDIntersectionAutomaton(l,aut);

end);

################################################################################
##
#F MinusIndecomposableAut(aut)
##
## MinusIndecomposableAut(aut) finds the automaton that accepts the subset of 
## minus-indecomposable permutations of the class accepted by aut.
##
InstallGlobalFunction(MinusIndecomposableAut,function(aut)
    local res;

    res:=IntersectionAutomaton(ComplementAutomaton(MinimalAutomaton(MinusDecompAut(aut))),aut);

    return MinimalAutomaton(res);

end );

################################################################################
##
#F PermDirectSum(perm1,perm2)
##
## PermDirectSum calculates and returns the resulting permutation of the direct 
## sum of the permutations perm1 and perm2.  
##
InstallGlobalFunction(PermDirectSum,function(p,q)
local l,i,tempp,tempq;

tempp:=StructuralCopy(p);
tempq:=StructuralCopy(q);

if IsRankEncoding(tempp) and IsRankEncoding(tempq) then
    Append(tempp,tempq);
    return tempp ;
else
    l:=Length(tempp);
    for i in [1..Length(tempq)] do
        Add(tempp,l+tempq[i]);
    od;
    return tempp;
fi;
end );

################################################################################
##
#F PermSkewSum(perm1,perm2)
##
## PermSkewSum calculates and returns the resulting permutation of the skew 
## sum of the permutations perm1 and perm2.  
##
InstallGlobalFunction(PermSkewSum,function(p,q)
local tempp,l,i;

tempp:=StructuralCopy(p);

l:=Length(q);
for i in [1..Length(tempp)] do
    tempp[i]:=tempp[i]+l;
od;
Append(tempp,q);

return tempp;

end );

################################################################################
##
#F ClassDirectSum(aut1,aut2)
##
## ClassDirectSum builds the automaton of a class that represents the resulting 
## class of the direct sum of the regular classes aut1 and aut2.
##
InstallGlobalFunction(ClassDirectSum,function(c,d)
local autc,autd;

autc:=ShallowCopy(c);
autd:=ShallowCopy(d);

if autc!.alphabet <> autd!.alphabet then
    if autc!.alphabet < autd!.alphabet then
        autc:=ExpandAlphabet(autc,autd!.alphabet);
    else
        autd:=ExpandAlphabet(autd,autc!.alphabet);
    fi;
fi;

return ProductOfLanguages(autc,autd);

end );

################################################################################
##
#F  Inflation(decomposition)
##
## Inflation takes the list of permutations that stand for the box decomposition
## representing a permutation, and calculates that permutation.
##
InstallGlobalFunction(Inflation,function(dec)
local pi,len,tlen,sig,shift,ind,pind,i,j;

pi:=dec[1];

len:=[];
tlen:=0;

for i in [2..Length(dec)] do
    tlen:=tlen+Length(dec[i]);
    Add(len,Length(dec[i]));
od;

sig:=ListWithIdenticalEntries(tlen,0);
shift:=0;

for i in [1..Length(pi)] do
    ind:=0;
    pind:=Position(pi,i);
    for j in [1..pind-1] do
    	ind:=ind+len[j];
    od;
    for j in [1..Length(dec[pind+1])] do
    	sig[j+ind]:=dec[pind+1][j]+shift;
    od;
    shift:=shift+Length(dec[pind+1]);
od;
return sig;

end );

################################################################################
##
#F  IsInterval(list)
##
## IsInterval takes in any sublist of a permutation and checkes whether it is
## an interval.
##
InstallGlobalFunction(IsInterval,function(list)
    local p,n,i,l,u,j;

    p:=StructuralCopy(list);
    n:=Length(p);
    l:=Minimum(p);

    Sort(p);

    if p = [l..l+n-1] then
        return true;
    else
        return false;
    fi;

end );

################################################################################
##
#F  BlockDecomposition(perm)
##
## BlockDecomposition takes a plus- and minus-indecomposable permutation and 
## decomposes it into its maximal maximal intervals, which are preceded by the
## simple permutation that represents the positions of the intervals.
## If a plus- or minus-decomposable permutation is input, then the decomposition
## will not be the unique decomposition, by the definition of plus- or minus-
## decomposable permutations.
##
InstallGlobalFunction(BlockDecomposition,function(list)
local p,i,j,a,temp,simp,min,max;

a:=[];
i:=1;

if IsRankEncoding(list) then
    p:=RankDecoding(list);
else
    p:=ShallowCopy(list);
fi;

#Building the intervals here. i is start of interval and counting up
#j is end of interval, counting down for each i, to get the maximal
#intervals. 
while i <= Length(p) do
      j:=Length(p);
      while j >= i do
      	    if IsInterval(p{[i..j]}) and not(p{[i..j]}=p)then
	       Add(a,p{[i..j]});
	       break;
	    else
	       j:=j-1;
	    fi;
      od;
      i:=j+1;
od;

#temp will be needed later for the simple permutation.

temp:=StructuralCopy(a);

#Changing from the truncated permutation to the appropriate interval
#permutations.

for i in [1..Length(a)] do
    a[i]:=OnTuples([1..Length(a[i])], Sortex(a[i]));
od;

#Building the simple permutation representing the positions
#of the intervals.

simp:=OnTuples([1..Length(temp)],Sortex(temp));

Add(a,simp,1);
return a;

end );
