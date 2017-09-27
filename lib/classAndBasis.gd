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
#W  classAndBasis.gd						Michael Albert,
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

DeclareGlobalFunction( "BoundedClassAutomaton" );

#############################################################################
##
#F  BasisAutomaton(a)  
##
##  Returns an automaton that accepts all permutations of the basis of the 
##  input autmaton, in rank encoding.
##
DeclareGlobalFunction( "BasisAutomaton" );


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
#DeclareGlobalFunction( "SequencesToRatExp" );

#############################################################################
##
#F  SequencesToRatExp(arg)  
##
##   Returns a rational expression that describes all the words in list.
##
DeclareGlobalFunction( "SequencesToRatExp" );


#############################################################################
##
#F  ClassAutomaton(a)  
##
##  Returns an automaton accepting the rank encoded permutations of the 
##  pattern class described by the input automaton that represents the basis.
##
DeclareGlobalFunction( "ClassAutomaton" );

#############################################################################
##
#F  ClassAutFromBaseEncoding(base,k)  
##
##  Returns an automaton accepting the rank encoded permutations of the 
##  pattern class described by the basis (in rank encoding) and the highest 
##  letter k in the rank encoding.
##
DeclareGlobalFunction( "ClassAutFromBaseEncoding" );

#############################################################################
##
#F  ClassAutFromBase(perms,k)  
##
##  Returns an automaton accepting the rank encoded permutations of the 
##  pattern class described by the basis and the highest letter k in the
##  rank encoding.
##
DeclareGlobalFunction( "ClassAutFromBase" );

#############################################################################
##
#F  RankDecoding(e)  
##
##  Returns the decoded permutation.
##
DeclareGlobalFunction( "RankDecoding" );

#############################################################################
##
#F  RankEncoding(p)  
##
##  Returns a sequence that represents the rank encoding of the input
##  permutation.
##
DeclareGlobalFunction( "RankEncoding" );

#############################################################################
##
#F  ExpandAlphabet(a,newAlphabet)  
##
##  Returns the input automaton over n letters, where n=newAlphabet. 
##
DeclareGlobalFunction( "ExpandAlphabet" );

