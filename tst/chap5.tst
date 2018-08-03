#############################################################################
##
#A  chap5.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> x:=Automaton("det",4,2,[[3,4,2,4],[2,2,2,4]],[1],[2]);
< deterministic automaton on 2 letters with 4 states >
gap> IsStarClosed(x);
false
gap> x:=Automaton("det",3,2,[[3,2,1],[2,3,1]],[1],[1]);
< deterministic automaton on 2 letters with 3 states >
gap> IsStarClosed(x);
true
gap> x:=Automaton("det",3,2,[[1,2,3],[2,2,3]],[1],[2]);
< deterministic automaton on 2 letters with 3 states >
gap> Is2StarReplaceable(x);
true
gap> x:=Automaton("det",4,2,[[4,1,1,2],[1,4,2,2]],[1],[4]);
< deterministic automaton on 2 letters with 4 states >
gap> Is2StarReplaceable(x);
false
gap> x:=Automaton("det",4,2,[[1,3,1,4],[2,2,4,4]],[1],[2]);
< deterministic automaton on 2 letters with 4 states >
gap> IsStratified(x);
true
gap> x:=Automaton("det",4,2,[[1,3,2,4],[2,4,1,4]],[1],[2]);
< deterministic automaton on 2 letters with 4 states >
gap> IsStratified(x);
false
gap> x:=Automaton("det",3,2,[[3,2,1],[2,3,1]],[1],[1]);
< deterministic automaton on 2 letters with 3 states >
gap> IsStratified(x);
false
gap> x:=Automaton("det",2,2,[[1,2],[2,2]],[1],[1]);
< deterministic automaton on 2 letters with 2 states >
gap> IsPossibleGraphAut(x);
true
gap> x:=Automaton("det",2,2,[[1,2],[1,2]],[1],[1]);
< deterministic automaton on 2 letters with 2 states >
gap> IsPossibleGraphAut(x);
false
gap> STOP_TEST( "chap5.tst", 10000 );
