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
#W  simpleAuts.gd                       Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

################################################################################
##
#F  GapGen(k)
##
## Returns the list of all lists of gap sizes possible for k. 
##
## This is a helper function.
##
###########################
##  NOT IN DOCUMENTATION ##
###########################
DeclareGlobalFunction( "GapGen" );

################################################################################
##
#F  LengthBoundAut(aut,min,i,k)
##
## Constructs the automaton that accepts all words of aut of lengths between 
## (and including) min and i.
##
DeclareGlobalFunction( "LengthBoundAut" );

################################################################################
##
#F  ShiftAut(i,k)
##
## Returns the bounded class automaton but with the alphabet shifted (by value)
## up by i, to at most k. (excluding the empty perm and the perm of length 1)
##
DeclareGlobalFunction( "ShiftAut" );

################################################################################
##
#F  NextGap(gap,rank)
##
## Knowing the gap sizes, and the rank of the point, NextGap calculates the next
## gap sizes when we add the point of that rank to the permutation.
##
DeclareGlobalFunction( "NextGap" );

################################################################################
##
#F  GapAut(k)
##
## Returns the automaton, which has an alphabet of k, the set of states is the  
## set of all possible gaps, the transition function is defined by the gap and 
## the rank (see NextGap), the inital state is the emptyset of gap states, the
## accept states are the inital state and the state where the gap sizes is [0].
## This automaton is just an extended form of the bounded class automaton of k,
## the language is the same.
##
DeclareGlobalFunction( "GapAut" );

################################################################################
##
#F  SumAut(sum,k)
##
## Constructs the automaton that accepts the prefixes of rank encoded permutations.
## The prefixes end in gap sizes which have total sum equal to sum.
##
DeclareGlobalFunction( "SumAut" );

################################################################################
##
#F  GapSumAut(gap,sum,k)
##
## Constructs the automaton that accepts the prefixes of rank encoded permutations.
## The prefixes end with a gap of size gap and the sum of gap sizes before (or below
## in the plot) that gap has to equal to sum.
##
DeclareGlobalFunction( "GapSumAut" );

################################################################################
##
#F  NonSimpleAut(k)
##
## Constructs the automaton that accepts all non-simple permutations with highest
## rank being k in their rank encoding.
##
DeclareGlobalFunction( "NonSimpleAut" );

################################################################################
##
#F  SimplePermAut(k)
##
## Constructs the automaton of all simple permutations with rank encoding at 
## most k. 
##
DeclareGlobalFunction( "SimplePermAut" );

################################################################################
##
#F  ExceptionalBoundedAutomaton(k)
##
##  Returns the automaton that accepts exceptional permutations with rank 
##  encoding at most k. 
##
DeclareGlobalFunction( "ExceptionalBoundedAutomaton" );


################################################################################
#### IsExceptionalPerm could possibly improved by building an automaton
#### that only accepts exceptional permutations of all lengths and then
#### check whether the input is accepted by such an automaton.
################################################################################
################################################################################
##
#F  IsExceptionalPerm(perm)
##
## First checks whether perm has even length, then (if it does) compares it
## against the 4 different types of exceptional permutations in their rank
## encoding.
##
DeclareGlobalFunction( "IsExceptionalPerm" );
