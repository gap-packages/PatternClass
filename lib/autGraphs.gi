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
#W  autGraphs.gi						Michael Albert,
#W                                      Steve Linton,
#W                                      Ruth Hoffmann
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

#############################################################################
##
#F  GraphToAut(g,innode,outnode)  
##
##  Returns an automaton representing the input token passing network.
##
InstallGlobalFunction(GraphToAut, function(g,innode,outnode) 
    local   states,  ht,  tm,  ins,  k,  reported,  s,  i,  y,  t,  
            he,  x,  init, a;

    states := [[]];
    ht := SparseHashTable( s->HashKeyBag(s,57,0,4+4*Length(s)) );
    AddHashEntry(ht,[],1);
    tm := List([1..Length(g)], x-> [[]]);
    ins := g[innode];
    k := 1;
    reported := 0;
    while k <= Length(states) do
        if Length(states)-reported > 100000 then
            Info(InfoAutomataSL,2,"Processing ",k," out of ",Length(states));
            reported := Length(states);
        fi;
        s := states[k];
        for i in [1..Length(s)] do
            for y in g[s[i]] do
                if y <> outnode then
                    if not y in s then
                        t := ShallowCopy(s);
                        t[i] := y;
                        MakeImmutable(t);
                        he := GetHashEntry(ht,t);
                        if he = fail then
                            Add(states,t);
                            AddHashEntry(ht,t,Length(states));
                            he := Length(states);
                            for x in tm do
                                Add(x,[]);
                            od;
                        fi;
                        AddSet(tm[Length(tm)][k],he);
                    fi;
                else
                    t := s{[1..i-1]};
                    t{[i..Length(s)-1]} := s{[i+1..Length(s)]};
                    MakeImmutable(t);
                    he := GetHashEntry(ht,t);
                    if he = fail then
                        Add(states,t);
                        AddHashEntry(ht,t,Length(states));
                        he := Length(states);
                        for x in tm do
                            Add(x,[]);
                        od;
                    fi;
                    AddSet(tm[i][k],he);
                fi;
            od;
        od;
        for x in [innode] do
            if not x in s then
                t := ShallowCopy(s);
                Add(t,x);
                MakeImmutable(t);
                he := GetHashEntry(ht,t);
                if he = fail then
                    Add(states,t);
                    AddHashEntry(ht,t,Length(states));
                    he := Length(states);
                    for y in tm do
                        Add(y,[]);
                    od;
                fi;
                AddSet(tm[Length(tm)][k],he);
            fi;
        od;
        if outnode in ins then
            AddSet(tm[Length(s)+1][k],k);
        fi;
        k := k+1;
    od;
    for i in [1..Length(tm)-1] do
        if ForAll(tm[i], x->Length(x) = 0) then
            Unbind(tm[i]);
        fi;
    od;
    tm := Compacted(tm);
    init := 1;
    Info(InfoAutomataSL, 1, "Constructed automaton for ",Length(g),
         " vertex graph ", Length(states), " states, ",Length(tm)-1," Symbols");
    a := Automaton("epsilon", Length(states), Length(tm),tm,[init],[init]);
    a!.statenames := states;

    return a;
end );

#############################################################################
##
#F  ConstrainedGraphToAut(g,innode,outnode,capacity)
##
##  Returns an automaton representing the input token passing network, with
##  limited capacity.
##
InstallGlobalFunction(ConstrainedGraphToAut, function(g,innode,outnode,capacity)
    local   states,  ht,  tm,  ins,  k,  reported,  s,  i,  y,  t,  
            he,  x,  init, a;

    states := [[]];
    ht := SparseHashTable( s->HashKeyBag(s,57,0,4+4*Length(s)) );
    AddHashEntry(ht,[],1);
    tm := List([1..Length(g)], x-> [[]]);
    ins := g[innode];
    k := 1;
    reported := 0;
    while k <= Length(states) do
        if Length(states)-reported > 100000 then
            Info(InfoAutomataSL,2,"Processing ",k," out of ",Length(states));
            reported := Length(states);
        fi;
        s := states[k];
        for i in [1..Length(s)] do
            for y in g[s[i]] do
                if y <> outnode then
                    if not y in s then
                        t := ShallowCopy(s);
                        t[i] := y;
                        MakeImmutable(t);
                        he := GetHashEntry(ht,t);
                        if he = fail then
                            Add(states,t);
                            AddHashEntry(ht,t,Length(states));
                            he := Length(states);
                            for x in tm do
                                Add(x,[]);
                            od;
                        fi;
                        AddSet(tm[Length(tm)][k],he);
                    fi;
                else
                    t := s{[1..i-1]};
                    t{[i..Length(s)-1]} := s{[i+1..Length(s)]};
                    MakeImmutable(t);
                    he := GetHashEntry(ht,t);
                    if he = fail then
                        Add(states,t);
                        AddHashEntry(ht,t,Length(states));
                        he := Length(states);
                        for x in tm do
                            Add(x,[]);
                        od;
                    fi;
                    AddSet(tm[i][k],he);
                fi;
            od;
        od;
        for x in [innode] do
            if Length(s) < capacity and not x in s then
                t := ShallowCopy(s);
                Add(t,x);
                MakeImmutable(t);
                he := GetHashEntry(ht,t);
                if he = fail then
                    Add(states,t);
                    AddHashEntry(ht,t,Length(states));
                    he := Length(states);
                    for y in tm do
                        Add(y,[]);
                    od;
                fi;
                AddSet(tm[Length(tm)][k],he);
            fi;
        od;
        k := k+1;
    od;
    init := 1;
    Info(InfoAutomataSL, 1, "Constructed automaton for ",Length(g),
         " vertex graph ", Length(states), " states, ",Length(tm)-1," Symbols");
    a := Automaton("epsilon", Length(states), Length(tm),tm,[init],[init]);
    a!.statenames := states;

    return a;
end );

#############################################################################
##
#F  Parstacks(m,n) 
##
##  Constructs a token passing network with 2 different sized stacks (m,n) 
##  positioned parallel.
##
InstallGlobalFunction(Parstacks, function(m,n)
    local g,i;

    g := List([1..2+m+n], x->[]);
    g[1] := [2,2+m];
    g[2] := [3,2+m+n];
    for i in [3..m] do
        g[i] := [i-1,i+1];
    od;
    g[m+1] := [m];
    g[m+2] := [m+3,m+n+2];
    for i in [m+3..m+n] do
        g[i] := [i-1,i+1];
    od;
    g[m+n+1] := [m+n];

    return g;
end );

#############################################################################
##
#F  Seqstacks(arg) 
##
##  Builds a token passing network containing a series (length of arg) of 
##  stacks of size arg[i].
##
InstallGlobalFunction(Seqstacks, function(arg)
    local   g,  next,  m,  i;

    if IsList(arg[1]) and Length(arg)=1 then
        arg := arg[1];
    fi;
    g := [];
    g[1] := [2];
    next := 2;
    for m in arg do
        g[next] := [next+1,next+m];
        g[next+m-1] := [next+m-2];
        for i in [next+1..next+m-2] do
            g[i] := [i-1,i+1];
        od;
        next := next+m;
    od;
    Add(g,[]);

    return g;
end );

#############################################################################
##
#F  BufferAndStack(n,m) 
##
##  Produces a token passing network containing a buffer of size n, followed
##  by a stack of size m.
##
InstallGlobalFunction(BufferAndStack, function(n,m)
    local   gamma,  i;

    gamma := [];
    gamma[1] := [2..n+1];
    for i in [2..n+1] do
        gamma[i] := [n+2];
    od;
    gamma[n+2] := [n+3, n+m+2];
    for i in [n+3..n+m] do
        gamma[i] := [i-1,i+1];
    od;
    gamma[n+m+1] := [n+m];
    gamma[n+m+2] := [];

    return gamma;
end );
