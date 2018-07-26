#############################################################################
##
#A  chap7.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> PermComplement([3,2,8,6,7,1,5,4]);
[ 6, 7, 1, 3, 2, 8, 4, 5 ]
gap> PermComplement([1]);
[ 1 ]
gap> PermComplement([1,2]);
[ 2, 1 ]
gap> IsRankEncoding([3,2,6,4,4,1,2,1]);
true
gap> IsRankEncoding([3,2,6,4,5,1,2,1]);
false
gap> a:=MinimalAutomaton(GraphToAut(Seqstacks(2,2),1,6));
< deterministic automaton on 3 letters with 3 states >
gap> IsAcceptedWord(a,[ 3, 3, 3, 1, 3, 1, 2, 1 ]);
true
gap> STOP_TEST( "chap7.tst", 10000 );
