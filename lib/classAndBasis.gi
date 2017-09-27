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
#W  classAndBasis.gi						Michael Albert,
#W                                          Steve Linton,
#W                                          Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

#############################################################################
##
#F  BoundedClassAutomaton(k)  
##
##  Returns an automaton, that accepts all rank encoded permutations with
##  highest letter being k.
##

if not IsBound(MakeWriteOnceAtomic) then
    BindGlobal("MakeWriteOnceAtomic", ID_FUNC);
fi;

BOUNDED_CLASS_AUTOMATA_CACHE :=  MakeWriteOnceAtomic([]);

InstallMethod(FlushCaches, [],function()
    BOUNDED_CLASS_AUTOMATA_CACHE := MakeWriteOnceAtomic([]);
    TryNextMethod();
end);


InstallGlobalFunction(BoundedClassAutomaton, function(k)
    local   states,  alphabet,  trans,  i,  j;
    if not IsBound(BOUNDED_CLASS_AUTOMATA_CACHE[k]) then
        states := k;
        alphabet := k;
        trans := [];
        for i in [1..k] do
            trans[i] := [];
            for j in [1..i] do
                Add(trans[i],i);
            od;
            for j in [(i+1)..k] do
                Add(trans[i],j-1);
            od;
        od;
        
        BOUNDED_CLASS_AUTOMATA_CACHE[k] := 
          Automaton("det", states, alphabet, trans, [1], [1]);
    fi;
    return BOUNDED_CLASS_AUTOMATA_CACHE[k];
end );

#############################################################################
##
#F  BasisAutomaton(a)  
##
##  Returns an automaton that accepts all permutations of the basis of the 
##  input autmaton, in rank encoding.
##
InstallGlobalFunction(BasisAutomaton, function(a)
    local   a2,  b,  b2,  k,  c,  c2,  d,  e,  f,  t,  u,  g,  g2,  h,  
            i,  j,  l,  n;

    if IsEpsilonAutomaton(a) then
        a2 := EpsilonCompactedAut(a);
        b := EpsilonToNFA(a2);
        b2 := ReducedNFA(b);
    elif IsNonDeterministicAutomaton(a) then
        b2 := ReducedNFA(a);
    else
        b2 := a;
    fi;
    k := b2!.alphabet;
    c := ReversedAutomaton(b2);
    c2 := ReducedNFA(c);
    d := NFAtoDFA(c2);
    e := MinimalAutomaton(d);
    f := ComplementDA(e);
    t := DeletionTransducer(k);
    u := TransposedTransducer(t);
    g := CombineAutTransducer(f,u);
    g2 := ReducedNFA(g);
    h := NFAtoDFA(g2);
    i := MinimalAutomaton(h);
    j := ComplementDA(i);
#    l := IntersectionAutomaton(j,f);
    l := NDIntersectionAutomaton(j,f);

    Info(InfoAutomataSL,1,"Intersected with Language complement ",
         l!.states," states");
    n := MinimalAutomaton(l);

#    return MinimalAutomaton(NFAtoDFA(ReversedAutomaton(n)));
    return ReversedAutomaton(n);

end );


######
##
## This function has been improved with the one below, as there were issues if
## the alphabet exceeded length 9.
##
#############################################################################
##
#F  SequencesToRatExp(list)  
##
##   Returns a rational expression that describes all the words in list.
##
#InstallGlobalFunction(SequencesToRatExp, function(list)
#    local   k,  alph,  l;
#
#    k := Maximum(Flat(list));
#    alph := JoinStringsWithSeparator(List([1..k], String),"");
#    l := List(list, x -> JoinStringsWithSeparator(List(x,String),""));
#
#    return RationalExpression(JoinStringsWithSeparator(l, "U"),alph);
#end );

#############################################################################
##
#F  SequencesToRatExp(arg)  
##
##   Returns a rational expression that describes all the words in list.
##   Compared to the original function this should work if the alphabet has
##   more than 9 letters.
##
InstallGlobalFunction(SequencesToRatExp, function(arg)
local list,k,ra,p,tmp,i;


list:=arg[1];
if IsBound(arg[2]) then
   k := arg[2];
else
   k := Maximum(Flat(list));
fi;

ra:=[];
for p in list do
    tmp:=RationalExpression("",k);
    for i in p do
        tmp:=ProductRatExp(tmp,RatExpOnnLetters(k,[],[i]));
    od;
    #UnionRatExp(ra,tmp);
    Add(ra,tmp);
od;

#if Length(arg) = 2 then
#   k:=arg[2];
#fi;

return RationalExpression(JoinStringsWithSeparator(ra, "U"),k);

end );

#############################################################################
##
#F  ClassAutomaton(a)  
##
##  Returns an automaton accepting the rank encoded permutations of the 
##  pattern class described by the input automaton that represents the basis.
##
InstallGlobalFunction(ClassAutomaton, function(a)
    local   a2,  b,  k,  b2,  c,  c2,  d,  e,  f,  t,  u,  g,  g2,  h,  
            i,  j,  jj, jjj, l,  m,  n;
    
    if IsEpsilonAutomaton(a) then
        a2 := EpsilonCompactedAut(a);
        b := EpsilonToNFA(a2);
    else
        b := a;
    fi;
    k := b!.alphabet;
    if IsNonDeterministicAutomaton(b) then
        b2 := ReducedNFA(b);
    else
        b2 := b;
    fi;
    c := ReversedAutomaton(b2);
    c2 := ReducedNFA(c);
    d := NFAtoDFA(c2);
    e := MinimalAutomaton(d);
    f := e;
    t := InvolvementTransducer(k);
    u := TransposedTransducer(t);
    g := CombineAutTransducer(f,u);
    g2 := ReducedNFA(g);
    h := NFAtoDFA(g2);
    i := MinimalAutomaton(h);
    j := ComplementDA(i);
    jj := ReversedAutomaton(j);
    jjj := MinimalAutomaton(jj);
    l := BoundedClassAutomaton(k);
#    m := IntersectionAutomaton(jjj,l);
    m := NDIntersectionAutomaton(jjj,l);

#    n := MinimalAutomaton(m);
    n := EpsilonToNFA(m);

    return n;
end );

#############################################################################
##
#F  ClassAutFromBaseEncoding(base,k)  
##
##  Returns an automaton accepting the rank encoded permutations of the 
##  pattern class described by the basis (in rank encoding) and the highest 
##  letter k in the rank encoding.
##
InstallGlobalFunction(ClassAutFromBaseEncoding, function(base,k)
    local   r,  b,  c,  d,  e,  f;
    
    r := SequencesToRatExp(base);
    b := RatExpToAut(r);
    c := ExpandAlphabet(b,k);
    d := ClassAutomaton(c);
    e := ReversedAutomaton(d);
    f := NFAtoDFA(e);

    return MinimalAutomaton(ReversedAutomaton(f));    
end );

#############################################################################
##
#F  ClassAutFromBase(perms,k)  
##
##  Returns an automaton accepting the rank encoded permutations of the 
##  pattern class described by the basis and the highest letter k in the
##  rank encoding.
##
InstallGlobalFunction(ClassAutFromBase, function(perms,k)
    
    return ClassAutFromBaseEncoding(List(perms, RankEncoding),k);    
end );

#############################################################################
##
#F  RankDecoding(e)  
##
##  Returns the decoded permutation.
##
InstallGlobalFunction(RankDecoding, function(e)
    local   source,  result,  x;

    source := [1..Length(e)];
    result := [];
    for x in e do
        Add(result, source[x]);
        RemoveSet(source, source[x]);
    od;
    
    return result;
end );

#############################################################################
##
#F  RankEncoding(p)  
##
##  Returns a sequence that represents the rank encoding of the input
##  permutation.
##
InstallGlobalFunction(RankEncoding, function(p)
    local   source,  result,  x;
    
    source := [1..Length(p)];
    result := [];
    for x in p do
        Add(result, Position(source,x));
        RemoveSet(source,x);
    od;
    
    return result;
end );

#############################################################################
##
#F  ExpandAlphabet(a,newAlphabet)  
##
##  Returns the input automaton over n letters, where n=newAlphabet. 
##
InstallGlobalFunction(ExpandAlphabet, function(a,newAlphabet)
    local   trans,  eps,  k;
    
    trans := ShallowCopy(a!.transitions);
    if IsEpsilonAutomaton(a) then
        eps := trans[a!.alphabet];
        for k in [a!.alphabet..newAlphabet] do
            Add(trans, []);
        od;
        Add(trans, eps);
    else
        for k in [a!.alphabet+1..newAlphabet] do
            Add(trans, []);
        od;
    fi;
    
    return Automaton(a!.type, 
                   a!.states,
                   Length(trans), 
                   trans, 
                   a!.initial,
                   a!.accepting);
end );

