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
#W  autStatistics.gi						Michael Albert,
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
#F  NumberAcceptedWords(aut,len) 
##
##  Returns the number of words of length len accepted by aut.
##
InstallGlobalFunction(NumberAcceptedWords, function(aut,len)
    local mat;

    mat := AutStateTransitionMatrix(aut);
    mat := mat^len;

    return Sum(mat[aut!.initial[1]]{aut!.accepting});
end );

#############################################################################
##
#F  AutStateTransitionMatrix(aut) 
##
##  Produces a matrix with the number of transitions between states of aut.
##
InstallGlobalFunction(AutStateTransitionMatrix, function(aut)
    local   tm,  mat,  row,  i,  x;

    if (not IsDeterministicAutomaton(aut)) then
        Error("AutStateTransitionMatrix can only be applied to determistic automata.");
    fi;
    
    tm := aut!.transitions;
    mat := NullMat(aut!.states, aut!.states, Integers);
    for row in tm do
        for i in [1..Length(row)] do
            x := row[i];
            if x <> 0 then
                mat[i][x] := mat[i][x] +1;
            fi;
        od;
    od;

    return mat;
end );

#############################################################################
##
#F  AcceptedWords(arg) 
##
##  Returns all words of integer length that are accepted by the inputed aut.
##
InstallGlobalFunction(AcceptedWords, function(arg)
    local   r;
    
    r := AcceptedWordsR(arg[1],arg[2]);
    Apply(r, Reversed);

    return r;
end );

#############################################################################
##
#F  AcceptedWordsR(arg) 
##
##  Returns all words, written in reverse, of integer length that are 
##  accepted by the inputed aut,
##
##
InstallGlobalFunction(AcceptedWordsR, function(arg)
    local   a,  s,  l,  accepted,  c,  newS,  acc,  w;
    
    if (2 = Length(arg)) then
        a := NFAtoDFA(arg[1]);
        s := a!.initial[1];
        return AcceptedWordsR(a,arg[2],s);
    fi;
    
    a := arg[1];
    l := arg[2];
    s := arg[3];
    
    if (l = 0) then
        if s in a!.accepting then 
            return [[]];
        else
            return [];
        fi;
    fi;
    
    accepted := [];
    
    for c in [1..a!.alphabet] do
        if IsBound(a!.transitions[c][s]) then
            newS := a!.transitions[c][s];
            if (newS <> 0) then
                acc := AcceptedWordsR(a, l-1, newS);
                for w in acc do Add(w,c); od;
                Append(accepted, acc);
            fi;
        fi;
    od;
    
    return accepted;
end );

#############################################################################
##
#F  Spectrum(arg) 
##
## Returns a list of integers indicating how many words of each length are 
## accepted by the inputed automaton. Default list size is 15.
##
InstallGlobalFunction(Spectrum, function(arg)
    local   tm,  mat,  row,  i,  x,  spec,  m1, aut,length;
    
    aut:=arg[1];
    if IsBound(arg[2]) then
        length := arg[2];
    else
        length := 15;
    fi;
    tm := aut!.transitions;
    mat := NullMat(aut!.states, aut!.states, Integers);
    for row in tm do
        for i in [1..Length(row)] do
            x := row[i];
            if x <> 0 then
                mat[i][x] := mat[i][x] +1;
            fi;
        od;
    od;
    spec := [];
    m1 := mat;
    row := m1[aut!.initial[1]];
    for i in [1..length] do
        Add(spec,Sum(row{aut!.accepting}));
        row := row* m1;
    od;

    return spec;
end );
