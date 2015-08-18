#############################################################################
##
##
#W  autGraphs.gd						Michael Albert,
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
#V  HashSet
##
DeclareGlobalVariable("HashSet");

#############################################################################
##
#F  GraphToAut(g,innode,outnode)  
##
##  Returns an automaton representing the input token passing network.
##
DeclareGlobalFunction( "GraphToAut" );

#############################################################################
##
#F  ConstrainedGraphToAut(g,innode,outnode,capacity)
##
##  Returns an automaton representing the input token passing network, with
##  limited capacity.
##
DeclareGlobalFunction( "ConstrainedGraphToAut" );

#############################################################################
##
#F  Parstacks(m,n) 
##
##  Constructs a token passing network with 2 different sized stacks (m,n) 
##  positioned parallel.
##
DeclareGlobalFunction( "Parstacks" );

#############################################################################
##
#F  Seqstacks(arg) 
##
##  Builds a token passing network containing a series (length of arg) of 
##  stacks of size arg[i].
##
DeclareGlobalFunction( "Seqstacks" );

#############################################################################
##
#F  BufferAndStack(n,m) 
##
##  Produces a token passing network containing a buffer of size n, followed
##  by a stack of size m.
##
DeclareGlobalFunction( "BufferAndStack" );