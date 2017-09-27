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
#W  graphAut.gd						Michael Albert,
#W                                  Steve Linton,
#W                                  Ruth Hoffmann
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
DeclareGlobalFunction( "IsPossibleGraphAut" );

#############################################################################
##
#F  IsStarClosed(aut)  
##
##  Checks if intial state and accept state are the same.
##
DeclareGlobalFunction( "IsStarClosed" );

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
DeclareGlobalFunction( "Is2StarReplaceable" );

#############################################################################
##
#F  IsStratified(aut)  
##
##  Checks if automaton can be represented in a "layered" manner.
##
DeclareGlobalFunction( "IsStratified" );
