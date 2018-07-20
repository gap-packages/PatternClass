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
##  You should have received a copy of the GNU General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
