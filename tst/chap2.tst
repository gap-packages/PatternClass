#############################################################################
##
#A  chap2.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> Parstacks(3,5);
[ [ 2, 5 ], [ 3, 10 ], [ 2, 4 ], [ 3 ], [ 6, 10 ], [ 5, 7 ], [ 6, 8 ], 
  [ 7, 9 ], [ 8 ], [  ] ]
gap> Parstacks(3,5);
[ [ 2, 5 ], [ 3, 10 ], [ 2, 4 ], [ 3 ], [ 6, 10 ], [ 5, 7 ], [ 6, 8 ], 
  [ 7, 9 ], [ 8 ], [  ] ]
gap> Seqstacks(3,4,3,3);
[ [ 2 ], [ 3, 5 ], [ 2, 4 ], [ 3 ], [ 6, 9 ], [ 5, 7 ], [ 6, 8 ], [ 7 ], 
  [ 10, 12 ], [ 9, 11 ], [ 10 ], [ 13, 15 ], [ 12, 14 ], [ 13 ], [  ] ]
gap> BufferAndStack(4,4);
[ [ 2 .. 5 ], [ 6 ], [ 6 ], [ 6 ], [ 6 ], [ 7, 10 ], [ 6, 8 ], [ 7, 9 ], 
  [ 8 ], [  ] ]
gap> STOP_TEST( "chap2.tst", 10000 );
