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
#W  SubAut.gd					      	Michael Albert,
#W                                      Steve Linton,
#W                                      Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2017 School of Computer Science,
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

#############################################################################
##
#F  SubPermAut(perm)
##
##  Returns an automaton accepting all encoded subpermutations of perm.
##
DeclareGlobalFunction( "SubPermAut" );

#############################################################################
##
#F  knSuperPermAutomaton(perm,int,int)
##
##  Returns an automaton accepting all encoded superpermutations involving perm
##  up to rank k and length n.
##
DeclareGlobalFunction( "SuperPermknAutomaton" );

#############################################################################
##
#F  InbetweenPermAutomaton(perm,perm)
##
##  Returns an automaton accepting all encoded rpermutations between the
##  two parameters.
##
DeclareGlobalFunction( "InbetweenPermAutomaton" );

#############################################################################
##
#F  InbetweenPermSet(perm,perm)
##
##  Returns the set of all permutations between the
##  two parameters.
##
DeclareGlobalFunction( "InbetweenPermSet" );

#############################################################################
##
#F  IsSubPerm(perm,perm)
##
##  Checks whether the second permutation is a subpermutation of the first.
##
DeclareGlobalFunction( "IsSubPerm" );
