#############################################################################
##
#A  chap10.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> a:=Automaton("det",4,3,[[2,4,3,3],[4,4,1,4],[3,1,2,4]],[1],[2]);
< deterministic automaton on 3 letters with 4 states >
gap> b:=LoopFreeAut(a);
< deterministic automaton on 3 letters with 5 states >
gap> Display(b);
   |  1  2  3  4  5  
--------------------
 a |  2  4  5  3  5  
 b |  4  4  1  5  5  
 c |  3  1  2  5  5  
Initial state:   [ 1 ]
Accepting state: [ 2 ]
gap> a:=Automaton("det",4,3,[[2,4,3,3],[4,4,1,4],[3,1,2,4]],[1],[2]);
< deterministic automaton on 3 letters with 4 states >
gap> b:=LoopVertexFreeAut(a);
< deterministic automaton on 3 letters with 3 states >
gap> Display(b);
   |  1  2  3  
--------------
 a |  2  2  1  
 b |  2  2  2  
 c |  3  2  2  
Initial state:   [ 3 ]
Accepting state: [ 1 ]
gap> STOP_TEST( "chap10.tst", 10000 );
