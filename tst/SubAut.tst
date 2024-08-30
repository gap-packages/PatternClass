#############################################################################
##
#A  SubAut.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> SubPermAut([4,5,6,2,3,1,7]);
< deterministic automaton on 4 letters with 16 states >
gap> SuperPermknAutomaton([2,1,3,4],4,6);
< deterministic automaton on 4 letters with 28 states >
gap> InbetweenPermAutomaton([1,2,3,4,5,6,7],[1,2,3]);
< deterministic automaton on 1 letters with 9 states >
gap> InbetweenPermAutomaton([5,4,3,2,1],[1]);
< deterministic automaton on 5 letters with 7 states >
gap> InbetweenPermSet([1,2,3,4,5,6,7],[1,2,3]);
[ [ 1, 2, 3 ], [ 1, 2, 3, 4 ], [ 1, 2, 3, 4, 5 ], [ 1, 2, 3, 4, 5, 6 ], 
  [ 1, 2, 3, 4, 5, 6, 7 ] ]
gap> IsSubPerm([1,2,3,4,5,6,7],[1,2,3]);
true
gap> IsSubPerm([1,2,3,4,7,6,5],[5,4,3,2,1]);
false
gap> STOP_TEST( "SubAut.tst", 10000 );
