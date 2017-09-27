###############################################################################
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
#W  decomp.gd						Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

################################################################################
##
#F IsPlusDecomposable(perm)
##
## IsPlusDecomposable uses the fact that there has to be an interval 1..x where 
## x<n (n=length of the permutation) in the permutation that is a rank encoding,
## to check whether perm is a plus-decomposable permutation.
##
## Side Note: The permutation [1,2] (encoded as [1,1]) is seen as a
## plus-decomposable permutation, as it displays the characteristics of such
## a permutation, eventhough it is also a simple permutation.
##
DeclareGlobalFunction( "IsPlusDecomposable" );

################################################################################
##
#F IsMinusDecomposable(perm)
##
## IsMinusDecomposable checks whether the permutation perm is minus decomposable
## by checking whether the complement of the permutation is plus decomposable.
##
## Side Note: The permutation [2,1] (encoded as [2,1]) is seen as a
## minus-decomposable permutation, as it displays the characteristics of such
## a permutation, eventhough it is also a simple permutation.
##
DeclareGlobalFunction( "IsMinusDecomposable" );

################################################################################
##
#F IsSimplePerm(perm)
##
## IsSimplePerm checks whether the permutation perm is simple, i.e. there are no
## non-trivial intervals within perm.
##
DeclareGlobalFunction( "IsSimplePerm" );

################################################################################
##
#F PlusIndecomposableAut(aut)
##
## The PlusIndecomposableAutomaton accepts the language of all 
## plus-indecomposable permutations of the encoded class accepted by aut.
##
DeclareGlobalFunction( "PlusIndecomposableAut" );
################################################################################
DeclareSynonym("PlusIndecompAut",PlusIndecomposableAut );

################################################################################
##
#F PlusDecomposableAut(aut)
##
## The PlusDecomposableAutomaton accepts the language of all 
## plus-decomposable permutations of the encoded class accepted by aut.
##
DeclareGlobalFunction( "PlusDecomposableAut" );
################################################################################
DeclareSynonym("PlusDecompAut",PlusDecomposableAut );

################################################################################
##
#F LdkAut(d,k)
##
## LdkAut is an auxiliary function to build an intermediate automaton, which 
## will be used to build the automaton that accepts all minus-decomposable 
## permutations of a class. The LdkAut automaton accepts the language 
## {{1,..d}^d {d+1,..k}^+} .
##
DeclareGlobalFunction( "LdkAut" );

################################################################################
##
#F LAut(k)
##
## LAut is another auxiliary function to build an intermediate automaton, which 
## will be used to build the automaton that accepts all minus-decomposable 
## permutations of a class. LAut is the union of LdkAut over the range of d in
## [1..k-1] .
##
DeclareGlobalFunction( "LAut" );

################################################################################
##
#F MinusDecomposableAut(aut)
##
## MinusDecomposableAut finds the regular language that is build by all simple
## permutations of the encoded class accepted by aut.
##
DeclareGlobalFunction( "MinusDecomposableAut" );
################################################################################
DeclareSynonym("MinusDecompAut",MinusDecomposableAut);

################################################################################
##
#F MinusIndecomposableAut(aut)
##
## MinusIndecomposableAut(aut) finds the automaton that accepts the subset of 
## minus-indecomposable permutations of the class accepted by aut.
##
DeclareGlobalFunction( "MinusIndecomposableAut" );
################################################################################
DeclareSynonym("MinusIndecompAut",MinusIndecomposableAut);

################################################################################
##
#F PermDirectSum(perm1,perm2)
##
## PermDirectSum calculates and returns the resulting permutation of the direct 
## sum of the permutations perm1 and perm2.  
##
DeclareGlobalFunction( "PermDirectSum" );

################################################################################
##
#F PermSkewSum(perm1,perm2)
##
## PermSkewSum calculates and returns the resulting permutation of the skew 
## sum of the permutations perm1 and perm2.  
##
DeclareGlobalFunction( "PermSkewSum" );

################################################################################
##
#F ClassDirectSum(aut1,aut2)
##
## ClassDirectSum builds the automaton of a class that represents the resulting 
## class of the direct sum of the regular classes aut1 and aut2.
##
DeclareGlobalFunction( "ClassDirectSum" );

################################################################################
##
#F  Inflation(decomposition)
##
## Inflation takes the list of permutations that stand for the box decomposition
## representing a permutation, and calculates that permutation.
##
DeclareGlobalFunction( "Inflation" );


################################################################################
##
#F  IsInterval(list)
##
## IsInterval takes in any sublist of a permutation and checkes whether it is
## an interval.
##
DeclareGlobalFunction( "IsInterval" );

################################################################################
##
#F  BlockDecomposition(perm)
##
## BlockDecomposition takes a plus- and minus-indecomposable permutation and 
## decomposes it into its maximal maximal intervals, which are preceded by the
## simple permutation that represents the positions of the intervals.
## If a plus- or minus-decomposable permutation is input, then the decomposition
## will not be the unique decomposition, by the definition of plus- or minus-
## decomposable permutations.
##
DeclareGlobalFunction( "BlockDecomposition" );
