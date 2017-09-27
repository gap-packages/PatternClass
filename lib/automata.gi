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
#W  automata.gi						Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

################################################################################
##
#F NDIntersectionAutomaton(aut1,aut2)
##
## A faster automata intersection algorithm, which does not turn the automata 
## deterministic.
##
InstallGlobalFunction(NDIntersectionAutomaton,function( a1, a2 )

local  HashPair, ht, init, states, m, s1, s2, t1, t2, t, i, st, a, x, y, nst, he, finals, p, q, numofinitst,m1,m2;

#These checks are from the original code
if IsAutomaton( a1 )  then
	;
elif IsRationalExpression( a1 )  then
	a1 := RatExpToAut( a1 );
else
	Error( "The first argument must be an automaton or a rational expression" );
fi;
if IsAutomaton( a2 )  then
	;
elif IsRationalExpression( a2 )  then
	a2 := RatExpToAut( a2 );
else
	Error( "The second argument must be an automaton or a rational expression" );
fi;
    
if a1!.type = "epsilon" then
	m1 := AlphabetOfAutomaton(a1)-1;
else    
	m1 := AlphabetOfAutomaton(a1);
fi;
if a2!.type = "epsilon" then
	m2 := AlphabetOfAutomaton(a2)-1;
else    
	m2 := AlphabetOfAutomaton(a2);
fi;
if m1 <> m2 then
	Error( "The arguments must be two automata over the same alphabet" );
fi;

if a1!.type <> "epsilon" then
	a1 := Automaton("epsilon", a1!.states, a1!.alphabet+1, Concatenation(a1!.transitions,[ListWithIdenticalEntries(a1!.states,[])]), a1!.initial, a1!.accepting);
fi;
if a2!.type <> "epsilon" then
	a2 := Automaton("epsilon", a2!.states, a2!.alphabet+1, Concatenation(a2!.transitions,[ListWithIdenticalEntries(a2!.states,[])]), a2!.initial, a2!.accepting);
fi;

HashPair := function ( s )
	return HashKeyBag( s, 57, 0, 3*GAPInfo.BytesPerVariable );
end;
ht := SparseHashTable( HashPair );
init := [ ];
for s1 in a1!.initial do
	for s2 in a2!.initial do
		Add(init, [ s1, s2 ]);
		AddHashEntry( ht, [ s1, s2 ], Length( init ) );
	od;
od;

numofinitst:=Length(init);

states := init;
m := a1!.alphabet;
i := 1;
t1 := a1!.transitions;
t2 := a2!.transitions;
t := List( [ 1 .. m ], function ( x ) return [  ]; end );

while i <= Length( states ) do
	st := states[i];
	for a in [ 1 .. m ]  do
        t[a][i] := [ ];
		if a = m then
			for x in t1[a][st[1]] do
				nst := [ x, st[2] ];
				MakeImmutable( nst );
				he := GetHashEntry( ht, nst );
				if he = fail  then
					Add( states, nst );
					he := Length( states );
					AddHashEntry( ht, nst, he );
				fi;
				Add(t[a][i], he);
			od;
			for x in t2[a][st[2]] do
				nst := [ st[1], x ];
				MakeImmutable( nst );
				he := GetHashEntry( ht, nst );
				if he = fail  then
					Add( states, nst );
					he := Length( states );
					AddHashEntry( ht, nst, he );
				fi;
				Add(t[a][i], he);
			od;
		else
	        for x in t1[a][st[1]] do
    	        for y in t2[a][st[2]] do
        	        nst := [ x, y ];
            	    MakeImmutable( nst );
					he := GetHashEntry( ht, nst );
                   	if he = fail  then
	                    Add( states, nst );
    	                he := Length( states );
        	            AddHashEntry( ht, nst, he );
                    fi;
                	Add(t[a][i], he);
	            od;
   	        od;
		fi;
	od;
	i := i + 1;
od;
finals := [  ];
for p in a1!.accepting  do
	for q in a2!.accepting  do
        he := GetHashEntry( ht, [ p, q ] );
        if he <> fail then
            AddSet( finals, he );
        fi;
	od;
od;

init := [ ];
for s1 in a1!.initial do
	for s2 in a2!.initial do
		he := GetHashEntry( ht, [ s1, s2 ] );
		if he <> fail then
			Add( init, he );
		fi;
	od;
od;

return Automaton( "epsilon", Length( states ), AlphabetOfAutomatonAsList( a1 ), t, [ 1 .. numofinitst ], finals );

end );

################################################################################
##
#F NDUnionAutomata(aut1,aut2)
##
## A faster automata union algorithm, which does not turn the automata 
## deterministic.
##
InstallGlobalFunction(NDUnionAutomata,function( A, B )
local  QA, T, a, i, I, F, mA,mB;

if not (IsAutomatonObj( A ) and IsAutomatonObj( B ))  then
	Error( "The arguments must be two automata" );
fi;

if A!.type = "epsilon" then
	mA := AlphabetOfAutomaton(A)-1;
else	
	mA := AlphabetOfAutomaton(A);
fi;
if B!.type = "epsilon" then
	mB := AlphabetOfAutomaton(B)-1;
else	
	mB := AlphabetOfAutomaton(B);
fi;
if mA <> mB then
	Error( "The arguments must be two automata over the same alphabet" );
fi;

QA := A!.states;
T := List( A!.transitions, ShallowCopy );
if A!.type <> "epsilon" and B!.type = "epsilon" then
	Add(T,[]);
fi;	

for a  in [ 1 .. B!.alphabet ]  do
	for i  in [ 1 .. B!.states ]  do
		if B!.transitions[a][i] = 0  then
			T[a][QA + i] := 0;
		else
			T[a][QA + i] := QA + B!.transitions[a][i];
		fi;
	od;
od;
if A!.type = "epsilon" and B!.type <> "epsilon" then
	for i in [1..B!.states] do
		Add(T[mA+1],0);
	od;
fi;	
I := ShallowCopy( A!.initial );
Append( I, QA + B!.initial );

F := ShallowCopy( A!.accepting );
Append( F, QA + B!.accepting );

if A!.type = "epsilon" or B!.type = "epsilon" then
	return Automaton( "epsilon", QA + B!.states, mA+1, T, I, F );
else
	return Automaton( "nondet", QA + B!.states, AlphabetOfAutomatonAsList( A ), T, I, F );
fi;
end ); 

################################################################################
##
#F NDProductOfLanguages(aut1,aut2)
##
## A faster automata concatenation algorithm, which does not turn the automata 
## deterministic.
##
InstallGlobalFunction(NDProductOfLanguages, function ( a1, a2 )
local  T, a, q, s, A,x,m,m1,m2;
    
if a1!.type = "epsilon" then
	m1 := AlphabetOfAutomaton(a1)-1;
else    
	m1 := AlphabetOfAutomaton(a1);
fi;
if a2!.type = "epsilon" then
	m2 := AlphabetOfAutomaton(a2)-1;
else
	m2 := AlphabetOfAutomaton(a2);
fi;
if m1 <> m2 then
	Error( "The arguments must be two automata over the same alphabet" );
fi;

if a1!.type = "det" then
	T := List( a1!.transitions, function ( l ) return List( l, function ( q ) return [ q ]; end ); end );
else
	T := List( a1!.transitions, ShallowCopy );
fi; 

if a1!.type <> "epsilon"  then
	Add( T, List( [ 1 .. a1!.states], function ( i ) return [  ]; end ) );
fi; 
for a in [ 1 .. a2!.alphabet ]  do
	for q in [ 1 .. a2!.states ]  do
		if a2!.transitions[a][q] = 0  then
			Add( T[a], [  ] );
		else
			x := a2!.transitions[a][q] + a1!.states;
			if IsList(x) then
				Add(T[a],x);
			else    
				Add(T[a],[x]);
			fi;
		fi;
	od;
od;
m := Length(T);

if a2!.type <> "epsilon" then
	for q in [1 .. a2!.states] do
		Add(T[m],[]);
	od;
fi;

for q in a1!.accepting  do
	for s in a2!.initial  do
		Add( T[m][q], a1!.states + s );
	od;
od;
A := Automaton( "epsilon", a1!.states + a2!.states, m, T, ShallowCopy( a1!.initial ), List( a2!.accepting, function ( q ) return q + a1!.states; end ) );

return A;

end );
