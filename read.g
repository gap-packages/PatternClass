#############################################################################
##
#W    read.g               An attempt at the                    Ruth Hoffmann
#W                        patternclass Package
##

#############################################################################
##
#R  Read the install files.
##
ReadPackage( "patternclass", "lib/automata.gi" );
ReadPackage( "patternclass", "lib/basics.gi" );
ReadPackage( "patternclass", "lib/transducers.gi" );
ReadPackage( "patternclass", "lib/autStatistics.gi" );
ReadPackage( "patternclass", "lib/autGraphs.gi" );
ReadPackage( "patternclass", "lib/classAndBasis.gi" );
ReadPackage( "patternclass", "lib/graphAut.gi" );
ReadPackage( "patternclass", "lib/decomp.gi" );
ReadPackage( "patternclass", "lib/inversion.gi" );
ReadPackage( "patternclass", "lib/simpleChains.gi" );
ReadPackage( "patternclass", "lib/simpleAuts.gi" );
ReadPackage( "patternclass", "lib/SubAut.gi" );

## This is highly experimental code on grid classes and not automatically loaded
## if you choose to load it, you are doing it so at your own risk.
# ReadPackage( "patternclass", "lib/grid/gridClass.gi" );

#E  read.g . . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
