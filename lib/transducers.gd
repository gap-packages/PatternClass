#############################################################################
##
##
#W  transducers.gd						Michael Albert,
#W                                      Steve Linton,
#W                                      Ruth Hoffmann
##
##
#Y  Copyright (C) 2004-2015 School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##

#############################################################################
##
#F  Transducer(s,init,transitions,accepting) 
##
##  Returns a recording of a transducer with s states, with init being the 
##  start state, transitions of the form [in,out,from to] and the set of
##  accept states. 
##
DeclareGlobalFunction( "Transducer" );

#############################################################################
##
#F  DeletionTransducer(k) 
##
##  Returns a transducer over k+1 states, which removes an entry in a 
##  permutation, written in the rank encoding and produces the new correct
##  rank encoding. 
##
DeclareGlobalFunction( "DeletionTransducer" );

#############################################################################
##
#F  TransposedTransducer(t) 
##
##  Returns the transducer t with the input and output letters in each 
##  transition interchanged.
##
DeclareGlobalFunction( "TransposedTransducer" );

#############################################################################
##
#V  HashPair
##
DeclareGlobalFunction("HashPair");

#############################################################################
##
#F  CombineAutTransducer(aut,trans) 
##
##  Returns an automaton that represents the concatenation of the automaton
##  aut and the transducer trans.
##
DeclareGlobalFunction( "CombineAutTransducer" );

#############################################################################
##
#F  InvolvementTransducer(k) 
##
##  Returns a transducer over k+1 states that removes an arbitrary number of
##  entries in a rank encoded permutation, and produces the new applicable
##  rank encoding.
##
DeclareGlobalFunction( "InvolvementTransducer" );