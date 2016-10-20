#############################################################################
##
#A  chap3.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> RankEncoding([3, 2, 5, 1, 6, 7, 4, 8, 9]);
[ 3, 2, 3, 1, 2, 2, 1, 1, 1 ]
gap> RankDecoding(last);
[ 3, 2, 5, 1, 6, 7, 4, 8, 9 ]
gap> SequencesToRatExp([[1,1,1,1,1],[2,1,2,2,1],[3,2,1,2,1],[4,2,3,2,1]]);
aaaaaUbabbaUcbabaUdbcba
gap> STOP_TEST( "chap3.tst", 10000 );
