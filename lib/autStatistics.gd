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
#W  autStatistics.gd						Michael Albert,
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
#F  NumberAcceptedWords(aut,len) 
##
##  Returns the number of words of length len accepted by aut.
##
DeclareGlobalFunction( "NumberAcceptedWords" );

#############################################################################
##
#F  AutStateTransitionMatrix(aut) 
##
##  Produces a matrix with the number of transitions between states of aut.
##
DeclareGlobalFunction( "AutStateTransitionMatrix" );

#############################################################################
##
#F  AcceptedWords(arg) 
##
##  Returns all words of integer length that are accepted by the inputed aut.
##
DeclareGlobalFunction( "AcceptedWords" );

#############################################################################
##
#F  AcceptedWordsR(arg) 
##
##  Returns all words, written in reverse, of integer length that are 
##  accepted by the inputed aut,
##
##
DeclareGlobalFunction( "AcceptedWordsR" );
#############################################################################
DeclareSynonym("AcceptedWordsReversed",AcceptedWordsR );
#############################################################################
##
#F  Spectrum(arg) 
##
## Returns a list of integers indicating how many words of each length are 
## accepted by the inputed automaton. Default list size is 15.
##
DeclareGlobalFunction( "Spectrum" );
