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
#W  simpleChains.gi                       Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science,
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

################################################################################
##
#F  OnePointDelete(perm)
##
## OnePointDelete removes single points in the simple permutation and returns
## a list of the resulting simple permutations, in their rank encoding.
##
InstallGlobalFunction(OnePointDelete, function(perm)
local i,p,t,j,plist,p1;

if IsSimplePerm(perm) and not(IsExceptionalPerm(perm)) then
    if IsRankEncoding(perm) then
        p:=RankDecoding(perm);
    else
        p:=ShallowCopy(perm);
    fi;
    plist:=[];
    for i in [1..Length(p)] do
        p1:=ShallowCopy(p);
        t:=Remove(p1,i);
        for j in [1..Length(p1)] do
            if p1[j] > t then
                p1[j]:=p1[j]-1;
            fi;
        od;
        if IsSimplePerm(p1) then
            Add(plist,p1);
        fi;
    od;
    Apply(plist,RankEncoding);
    return plist;
elif IsExceptionalPerm(perm) then
    Print(perm, " is an exceptional permutation and needs 2 point deletion.\n");
    return fail;
else
    Print(perm, " is not simple.\n");
    return fail;
fi;
end );

################################################################################
##
#F  TwoPointDelete(perm)
##
## TwoPointDelete removes two points of the input exceptional permutation and
## returns the list of the unique resulting permutation, in its rank encoding.
##
InstallGlobalFunction(TwoPointDelete, function(perm)
local m,p;

if IsExceptionalPerm(perm) then
    m:=Length(perm)/2;
    if IsRankEncoding(perm) then
        p:=StructuralCopy(perm);
    else
        p:=RankEncoding(perm);
    fi;
    if p{[1..m]}=[2..m+1] then
        Remove(p,Length(p));
        Remove(p,m);
        return [p];
    elif Reversed(p{[1..m]})=[1,3..2*m-1] then
        Remove(p,m+1);
        Remove(p,1);
        return [p];
    else
        Remove(p,2);
        Remove(p,1);
        return [p];
    fi;
else
    Print("The input permutation is not an exceptional permutation.\n");
    return fail;
fi;
end );

################################################################################
##
#F  PointDeletion(perm)
##
## PointDeletion, takes any simple permutation does not matter whether
## exceptional or not and removes the right number of points.
##
InstallGlobalFunction(PointDeletion, function(perm)

if IsSimplePerm(perm) then
    if IsExceptionalPerm(perm) then
        return TwoPointDelete(perm);
    else
        return OnePointDelete(perm);
    fi;
else
    Print(perm, " is not simple.\n");
    return fail;
fi;

end );

########
## Experimental, undocumented code to get the language of simple permutations
## with one more point.
########
################################################################################
##
#F NonSimpleOnePointAdditionTransducer(length,k)
##
## Constructs an transducer that when applied to an language, finds all the words
## with an additional letter which seem are not simple permutations.
##
InstallGlobalFunction(NonSimpleOnePointAdditionTransducer, function(length,k)
local nostates,init,accept,trans,i,n;


nostates:=2*k+7;
init:=1;
accept:=[k+4..nostates];
trans:=[];

Append(trans,[[0,0,1,2],[0,1,1,3],[0,1,2,k+4],[0,length+1,2,k+5]]);
for i in [1..k] do
    Append(trans,[[i,i,3,k+6],[i,i+1,3,k+7],[i,i,k+6,k+6],[i,i+1,k+7,k+7],[i,i,2,2]]);

    Add(trans,[i,i,2,3+i]);
    Append(trans,[[0,i,3+i,k+7+i],[0,i+1,3+i,k+7+i]]);

    if not(i=k) then
        for n in [1..k] do
            if n <= i then
                Add(trans,[n,n,k+7+i,k+8+i]);
            else
                Add(trans,[n,n+1,k+7+i,k+7+i]);
            fi;
        od;
    else
        for n in [1..k] do
            Add(trans,[n,n,k+7+i,k+7+i]);
        od;
    fi;
od;

return Transducer(nostates,init,trans,accept);

end );


################################################################################
##
#F OneStepSimplePermsAut(perms)
##
## Takes in a list of rank encoded simple permutations, of the same length and
## returns the simple permutations that are have one additional point and are
## encoded using the same alphabet.
##
InstallGlobalFunction(OneStepSimplePermsAut, function(perms)
local l,k,i,a,t1,b,t2,c,res,alph1,expaut,tmp,tmp1,a1;

l:=Length(perms[1]);
k:=0;
for i in perms do
    if Maximum(i) > k then
        k:=Maximum(i);
    fi;
od;


#(T_sn(C^R))^R
a:=MinimalAutomaton(ReversedAutomaton(RatExpToAut(SequencesToRatExp(perms))));
t1:=NonSimpleOnePointAdditionTransducer(l,k);
b:=MinimalAutomaton(ReversedAutomaton(MinimalAutomaton(CombineAutTransducer(a,t1))));;

#(T_i(C^R))^R n S_l+1
t2:=TransposedTransducer(DeletionTransducer(l+1));;
c:=IntersectionAutomaton(MinimalAutomaton(ReversedAutomaton(MinimalAutomaton(
    CombineAutTransducer(a,t2)))),BoundedClassAutomaton(l+1));;

#L(C)
tmp:=IntersectionAutomaton(ComplementDA(b),c);

#
# Union of L(C) with exceptional perms to get whole language, might not
# be needed though.
#
alph1:=AlphabetOfAutomatonAsList(tmp);

expaut:=ExceptionalBoundedAutomaton(Length(alph1));

tmp1:=MinimalAutomaton(UnionAutomata(expaut,tmp));

a1:=ExpandAlphabet(BoundedClassAutomaton(k),AlphabetOfAutomaton(tmp));
res:=IntersectionAutomaton(tmp1,a1);

return res;

end );
