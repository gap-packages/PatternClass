#############################################################################
##
#A  chap4.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> a:=Seqstacks(3,3);
[ [ 2 ], [ 3, 5 ], [ 2, 4 ], [ 3 ], [ 6, 8 ], [ 5, 7 ], [ 6 ], [  ] ]
gap> aut:=GraphToAut(a,1,8);
< epsilon automaton on 6 letters with 680 states >
gap> a:=Parstacks(5,5);
[ [ 2, 7 ], [ 3, 12 ], [ 2, 4 ], [ 3, 5 ], [ 4, 6 ], [ 5 ], [ 8, 12 ], 
  [ 7, 9 ], [ 8, 10 ], [ 9, 11 ], [ 10 ], [  ] ]
gap> aut:=ConstrainedGraphToAut(a,1,12,5);
< epsilon automaton on 12 letters with 5074 states >
gap> STOP_TEST( "chap4.tst", 10000 );
