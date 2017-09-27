################################################################################
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
#W  inversion.gd						Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

################################################################################
##
#F InversionAut(k)
##
## InversionAut builds the automaton that accepts all permutations under the 
## rank encoding with exactly k inversions.
## 
##
DeclareGlobalFunction( "InversionAut" );

################################################################################
##
#F InversionAutOfClass(inv,aut)
##
## InvserionAutOfClass returns the automaton that accepts all permutations under
## the rank encoding, lying in the regular class aut, that have exactly inv 
## inversions. 
##
DeclareGlobalFunction( "InversionAutOfClass" );

################################################################################
##
#F LoopFreeAut(aut)
##
## LoopFreeAut returns the subautomaton of aut that contains no loops of the 
## form (i,i,x) where i is a state and x is any letter in the alphabet. 
##
DeclareGlobalFunction( "LoopFreeAut" );

################################################################################
##
#F LoopVertexFreeAut(aut)
##
## LoopVertexFreeAut builds the subautomaton of aut that does not contain the 
## vertices and their transitions in aut that loop to themselves.
##
DeclareGlobalFunction( "LoopVertexFreeAut" );
