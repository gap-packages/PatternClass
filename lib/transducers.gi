#############################################################################
##
##
#W  transducers.gi						Michael Albert,
#W                                      Steve Linton, 
#W                                      Ruth Hoffmann
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

#############################################################################
##
#F  Transducer(states,init,transitions,accepting) 
##
##  Returns a recording of a transducer with s states, with init being the 
##  start state, transitions of the form [in,out,from to] and the set of
##  accept states. 
##
InstallGlobalFunction(Transducer, function(states,init,transitions,accepting)

   return rec(states := states, initial := init, transitions := transitions,
               accepting := accepting);
end );

#############################################################################
##
#F  DeletionTransducer(k) 
##
##  Returns a transducer over k+1 states, which removes an entry in a 
##  permutation, written in the rank encoding and produces the new correct
##  rank encoding. 
##
InstallGlobalFunction(DeletionTransducer, function(k)
    local   states,  init,  accepting,  trans,  i,  j;

    states := k+1;
    init := k+1;
    accepting := [1..k];
    trans := [];
    for i in [1..k] do
        Add(trans,[i,i,k+1,k+1]);
        Add(trans,[i,0,k+1,i]);
        for j in [i+1..k] do
            Add(trans,[j,j-1,i,i]);
            Add(trans,[i,i,j-1,j]);
        od;
        Add(trans,[i,i,k,k]);
    od;

    return Transducer(states, init, trans, accepting);
end );

#############################################################################
##
#F  TransposedTransducer(t) 
##
##  Returns the transducer t with the input and output letters in each 
##  transition interchanged.
##
InstallGlobalFunction(TransposedTransducer, function(t)

    return Transducer(t.states, t.initial, 
                   List(t.transitions,x->[x[2],x[1],x[3],x[4]]), t.accepting);
end );

#############################################################################
##
#V HashPair
##
InstallGlobalFunction(HashPair, s->HashKeyBag(s,57,0,12));

#############################################################################
##
#F  CombineAutTransducer(aut,trans) 
##
##  Returns an automaton that represents the concatenation of the automaton
##  aut and the transducer trans.
##
InstallGlobalFunction(CombineAutTransducer, function(aut,trans)
    local   initstates,  states,  ht,  i,  ptrans,  st,  s,  a,  
            targets,  s1,  tr,  nst,  he,  newalpha,  tm,  b,  brow,  
            t,  type;

    initstates := Cartesian(aut!.initial,[trans.initial]);
    states := ShallowCopy(initstates);
    ht := SparseHashTable(HashPair);
    for i in [1..Length(states)] do
        AddHashEntry(ht, states[i],i);
    od;
    ptrans := [];
    i := 1;
    while i <= Length(states) do
        st := states[i];
        s := st[1];
        for a in [1..aut!.alphabet] do
            targets := aut!.transitions[a][s];
            if not IsList(targets) then
                if (targets <> 0) then
                    targets := [targets];
        		else
		          	targets := [];
                fi;
            fi;
            for s1 in targets do
                for tr in trans.transitions do
                    if tr[1] = a and tr[3] = st[2] then
                        nst := [s1,tr[4]];
                        MakeImmutable(nst);
                        he := GetHashEntry(ht,nst);
                        if he = fail then
                            Add(states, nst);
                            he := Length(states);
                            AddHashEntry(ht, nst, he);
                        fi;
                        Add(ptrans, [i,he,tr[2]]);
                    fi;
                od;
            od;
        od;
        
        for tr in trans.transitions do
            if tr[1] = 0 and tr[3] = st[2] then
                nst := [s,tr[4]];
                MakeImmutable(nst);
                he := GetHashEntry(ht,nst);
                if he = fail then
                    Add(states, nst);
                    he := Length(states);
                    AddHashEntry(ht, nst, he);
                fi;
                Add(ptrans, [i,he,tr[2]]);
            fi;
        od;
            
        if aut!.type = "epsilon" then
            targets := aut!.transitions[aut!.alphabet][s];
            for s1 in targets do
                nst := [s1,st[2]];
                MakeImmutable(nst);
                he := GetHashEntry(ht,nst);
                if he = fail then
                    Add(states, nst);
                    he := Length(states);
                    AddHashEntry(ht, nst, he);
                fi;
                Add(ptrans, [i,he,0]);
            od;
        fi;
        i := i+1;
    od;
    newalpha := Set(trans.transitions, tr->tr[2]);
    newalpha := [Minimum(Minimum(newalpha), 1)..Maximum(newalpha)]; 
    tm := List(newalpha, b->List([1..Length(states)],i->[]));
    for t in ptrans do
        if t[3] = 0 then
            AddSet(tm[Length(tm)][t[1]],t[2]);
        else
            AddSet(tm[t[3]][t[1]],t[2]);
        fi;
    od;
    if 0 in newalpha then
        type := "epsilon";
    else
        type := "nondet";
    fi;
    Info(InfoAutomataSL, 1, "Combined Transducer(",trans.states,") with ",
         aut!.type," aut(",aut!.states,") to make ",type," aut(",Length(states),")");

    return Automaton(type,Length(states),Length(tm),tm,
                   List(initstates, st -> GetHashEntry(ht, st)),
                   Filtered([1..Length(states)], 
                           i->states[i][1] in aut!.accepting and 
                           states[i][2] in trans.accepting));
end );

#############################################################################
##
#F  InvolvementTransducer(k) 
##
##  Returns a transducer over k+1 states that removes an arbitrary number of
##  entries in a rank encoded permutation, and produces the new applicable
##  rank encoding.
##
InstallGlobalFunction(InvolvementTransducer, function(k)
    local   IntToBlist,  states,  init,  m,  accepting,  trans,  i,  
            t,  e,  lowBits,  target,  eModified;

    states := 2^(k-1);
    init := 2^(k-1);
    m := init;
    accepting := [1..2^(k-1)];
    trans := [];
    for i in [1..2^(k-1)] do
        for e in [1..k] do
            if (e < k) then
                t := (2*i mod m);
                lowBits := (t mod 2^e)/2;
                target := t - lowBits;
            else
                target := i;
                lowBits := i mod 2^(k-1);
            fi;
            eModified := e;
            while (lowBits > 0) do
               eModified:= eModified - (lowBits mod 2);
                lowBits := QuoInt(lowBits, 2);
            od;
                            
            if (target <> 0) then 
                Add(trans, [e, eModified, i, target]);
            else
                Add(trans, [e, eModified, i, init]);
            fi;
            if (e < k) then target := target + 2^(e-1); fi;
            Add(trans, [e, 0,i, target]);
        od;
    od;

    return Transducer(states, init, trans, accepting);
end );