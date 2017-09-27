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
#W  graphAut.gi						Michael Albert,
#W                                  Steve Linton,
#W                                  Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

#############################################################################
##
#F  IsPossibleGraphAut(aut)  
##
##  Checks if the input automaton could represent a token passing network.
##
InstallGlobalFunction(IsPossibleGraphAut, function(aut)
    
    return (IsStarClosed(aut) and Is2StarReplaceable(aut) and IsStratified(aut));
end );

#############################################################################
##
#F  IsStarClosed(aut)  
##
##  Checks if intial state and accept state are the same.
##
InstallGlobalFunction(IsStarClosed, function(aut)

    return (aut!.initial = aut!.accepting);
end );

#############################################################################
##
#F  Is2StarReplaceable(aut)  
##
##  Returns true if there is no state with transition, containing the first
##  letter, to the initial state, or if there is at least one state with such 
##  a transition, then the transition, containing the second letter, from 
##  that state has to either map to it self or another state with the same 
##  condition on its transitions.
##
InstallGlobalFunction(Is2StarReplaceable, function(aut)
    local   init,  trans,  nextLevel,  i,  v;
       
    init := aut!.initial[1];
    trans := aut!.transitions;
    
    nextLevel := [];
    for i in [1..aut!.states] do
        if (trans[1][i] = init) and (i <> init)  then
            Add(nextLevel, i);
        fi;
    od;
   
    for v in nextLevel do
        if not (trans[2][v] in nextLevel) then 
            return false;
        fi;
    od;
    
    return true;
end );

#############################################################################
##
#F  IsStratified(aut)  
##
##  Checks if automaton can be represented in a "layered" manner.
##
InstallGlobalFunction(IsStratified, function(aut)
    local   trans,  failState,  level,  toProcess,  v,  lv,  a,  w,  
            lw;
    
    trans := aut!.transitions;

    if Length(ListSinkStatesAut(aut))=0 then
        return false;
    else
        failState := ListSinkStatesAut(aut)[1];
    fi;
    
    level := [];
    level[aut!.initial[1]] := 1;
    toProcess := [];
    Add(toProcess, aut!.initial[1]);
    for v in toProcess do
        lv := level[v];
        for a in [1..aut!.alphabet] do
            if (IsBound(trans[a][v]) and (trans[a][v] <> 0)) then
                w := trans[a][v];
                if (w <> failState) then
                    if IsBound(level[w]) then
                        lw := level[w];
                        if (a < lv) and (lw <> (lv-1)) then 
                            return false;
                        fi;
                        if (a >= lv) and (lw <> a) then
                            return false;
                        fi;
                    else
                        if (a < lv) then 
                            level[w] := lv - 1;
                        else
                            level[w] := a;
                        fi;
                        Add(toProcess, w);
                    fi;
                fi;
            fi;
        od;
    od;
    
    return true;
end );
