#############################################################################
##
#A  chap6.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> trans:=Transducer(3,1,[[1,2,1,2],[1,2,2,2],[2,2,1,3],[2,2,2,3],[1,1,3,3],[2,2,3,3]],[2]);
rec( accepting := [ 2 ], initial := 1, states := 3, 
  transitions := [ [ 1, 2, 1, 2 ], [ 1, 2, 2, 2 ], [ 2, 2, 1, 3 ], 
      [ 2, 2, 2, 3 ], [ 1, 1, 3, 3 ], [ 2, 2, 3, 3 ] ] )
gap> DeletionTransducer(5);
rec( accepting := [ 1 .. 5 ], initial := 6, states := 6, 
  transitions := [ [ 1, 1, 6, 6 ], [ 1, 0, 6, 1 ], [ 2, 1, 1, 1 ], 
      [ 1, 1, 1, 2 ], [ 3, 2, 1, 1 ], [ 1, 1, 2, 3 ], [ 4, 3, 1, 1 ], 
      [ 1, 1, 3, 4 ], [ 5, 4, 1, 1 ], [ 1, 1, 4, 5 ], [ 1, 1, 5, 5 ], 
      [ 2, 2, 6, 6 ], [ 2, 0, 6, 2 ], [ 3, 2, 2, 2 ], [ 2, 2, 2, 3 ], 
      [ 4, 3, 2, 2 ], [ 2, 2, 3, 4 ], [ 5, 4, 2, 2 ], [ 2, 2, 4, 5 ], 
      [ 2, 2, 5, 5 ], [ 3, 3, 6, 6 ], [ 3, 0, 6, 3 ], [ 4, 3, 3, 3 ], 
      [ 3, 3, 3, 4 ], [ 5, 4, 3, 3 ], [ 3, 3, 4, 5 ], [ 3, 3, 5, 5 ], 
      [ 4, 4, 6, 6 ], [ 4, 0, 6, 4 ], [ 5, 4, 4, 4 ], [ 4, 4, 4, 5 ], 
      [ 4, 4, 5, 5 ], [ 5, 5, 6, 6 ], [ 5, 0, 6, 5 ], [ 5, 5, 5, 5 ] ] )
gap> TransposedTransducer(last);
rec( accepting := [ 1 .. 5 ], initial := 6, states := 6, 
  transitions := [ [ 1, 1, 6, 6 ], [ 0, 1, 6, 1 ], [ 1, 2, 1, 1 ], 
      [ 1, 1, 1, 2 ], [ 2, 3, 1, 1 ], [ 1, 1, 2, 3 ], [ 3, 4, 1, 1 ], 
      [ 1, 1, 3, 4 ], [ 4, 5, 1, 1 ], [ 1, 1, 4, 5 ], [ 1, 1, 5, 5 ], 
      [ 2, 2, 6, 6 ], [ 0, 2, 6, 2 ], [ 2, 3, 2, 2 ], [ 2, 2, 2, 3 ], 
      [ 3, 4, 2, 2 ], [ 2, 2, 3, 4 ], [ 4, 5, 2, 2 ], [ 2, 2, 4, 5 ], 
      [ 2, 2, 5, 5 ], [ 3, 3, 6, 6 ], [ 0, 3, 6, 3 ], [ 3, 4, 3, 3 ], 
      [ 3, 3, 3, 4 ], [ 4, 5, 3, 3 ], [ 3, 3, 4, 5 ], [ 3, 3, 5, 5 ], 
      [ 4, 4, 6, 6 ], [ 0, 4, 6, 4 ], [ 4, 5, 4, 4 ], [ 4, 4, 4, 5 ], 
      [ 4, 4, 5, 5 ], [ 5, 5, 6, 6 ], [ 0, 5, 6, 5 ], [ 5, 5, 5, 5 ] ] )
gap> InvolvementTransducer(3);
rec( accepting := [ 1 .. 4 ], initial := 4, states := 4, 
  transitions := [ [ 1, 1, 1, 2 ], [ 1, 0, 1, 3 ], [ 2, 1, 1, 1 ], 
      [ 2, 0, 1, 3 ], [ 3, 2, 1, 1 ], [ 3, 0, 1, 1 ], [ 1, 1, 2, 4 ], 
      [ 1, 0, 2, 1 ], [ 2, 2, 2, 4 ], [ 2, 0, 2, 2 ], [ 3, 2, 2, 2 ], 
      [ 3, 0, 2, 2 ], [ 1, 1, 3, 2 ], [ 1, 0, 3, 3 ], [ 2, 1, 3, 1 ], 
      [ 2, 0, 3, 3 ], [ 3, 1, 3, 3 ], [ 3, 0, 3, 3 ], [ 1, 1, 4, 4 ], 
      [ 1, 0, 4, 1 ], [ 2, 2, 4, 4 ], [ 2, 0, 4, 2 ], [ 3, 3, 4, 4 ], 
      [ 3, 0, 4, 4 ] ] )
gap> a:=Automaton("det",1,1,[[1]],[1],[1]);
< deterministic automaton on 1 letters with 1 states >
gap> t:=Transducer(2,1,[[1,2,1,2],[2,1,1,2],[1,1,2,1],[2,2,2,1]],[1]);
rec( accepting := [ 1 ], initial := 1, states := 2, 
  transitions := [ [ 1, 2, 1, 2 ], [ 2, 1, 1, 2 ], [ 1, 1, 2, 1 ], 
      [ 2, 2, 2, 1 ] ] )
gap> res:=CombineAutTransducer(a,t);
< non deterministic automaton on 2 letters with 2 states >
gap> x:=Parstacks(2,2);
[ [ 2, 4 ], [ 3, 6 ], [ 2 ], [ 5, 6 ], [ 4 ], [  ] ]
gap> xa:=GraphToAut(x,1,6);
< epsilon automaton on 5 letters with 66 states >
gap> ma:=MinimalAutomaton(xa);
< deterministic automaton on 4 letters with 9 states >
gap> ba:=BasisAutomaton(ma);
< non deterministic automaton on 4 letters with 9 states >
gap> ma:=MinimalAutomaton(last);
< deterministic automaton on 4 letters with 9 states >
gap> ca:=ClassAutomaton(ma);
< non deterministic automaton on 4 letters with 12 states >
gap> BoundedClassAutomaton(6);
< deterministic automaton on 6 letters with 6 states >
gap> BoundedClassAutomaton(12);
< deterministic automaton on 12 letters with 12 states >
gap> a:=BoundedClassAutomaton(4);
< deterministic automaton on 4 letters with 4 states >
gap> ba:=BasisAutomaton(a);
< non deterministic automaton on 4 letters with 3 states >
gap> ma:=MinimalAutomaton(ba);
< deterministic automaton on 4 letters with 3 states >
gap> ca:=ClassAutomaton(ma);
< non deterministic automaton on 4 letters with 4 states >
gap> MinimalAutomaton(ca);
< deterministic automaton on 4 letters with 4 states >
gap> ClassAutFromBaseEncoding([[2,1]],4);
< deterministic automaton on 4 letters with 2 states >
gap> ClassAutFromBase([[2,1]],4);
< deterministic automaton on 4 letters with 2 states >
gap> ClassAutFromBaseEncoding([[4,1,1,1]],4);
< deterministic automaton on 4 letters with 7 states >
gap> ClassAutFromBase([[4,1,2,3]],4);
< deterministic automaton on 4 letters with 7 states >
gap> aut:=Automaton("det",3,2,[[2,2,3],[3,3,3]],[1],[3]);
< deterministic automaton on 2 letters with 3 states >
gap> ExpandAlphabet(aut,4);
< deterministic automaton on 4 letters with 3 states >
gap> Display(last);
   |  1  2  3  
--------------
 a |  2  2  3  
 b |  3  3  3  
 c |           
 d |           
Initial state:   [ 1 ]
Accepting state: [ 3 ]
gap> ClassDirectSum(BoundedClassAutomaton(4),BoundedClassAutomaton(3));
< deterministic automaton on 4 letters with 4 states >
gap> ClassDirectSum(BoundedClassAutomaton(3),BoundedClassAutomaton(6));
< deterministic automaton on 6 letters with 6 states >
gap> a:=BoundedClassAutomaton(5);
< deterministic automaton on 5 letters with 5 states >
gap> Spectrum(a);
[ 1, 2, 6, 24, 120, 600, 3000, 15000, 75000, 375000, 1875000, 9375000, 
  46875000, 234375000, 1171875000 ]
gap> Spectrum(a,10);
[ 1, 2, 6, 24, 120, 600, 3000, 15000, 75000, 375000 ]
gap> NumberAcceptedWords(a,10);
375000
gap> AutStateTransitionMatrix(a);
[ [ 1, 1, 1, 1, 1 ], [ 1, 1, 1, 1, 1 ], [ 0, 2, 1, 1, 1 ], [ 0, 0, 3, 1, 1 ], 
  [ 0, 0, 0, 4, 1 ] ]
gap> AcceptedWords(a,4);
[ [ 1, 1, 1, 1 ], [ 1, 1, 2, 1 ], [ 1, 2, 1, 1 ], [ 1, 2, 2, 1 ], 
  [ 1, 3, 1, 1 ], [ 1, 3, 2, 1 ], [ 2, 1, 1, 1 ], [ 2, 1, 2, 1 ], 
  [ 2, 2, 1, 1 ], [ 2, 2, 2, 1 ], [ 2, 3, 1, 1 ], [ 2, 3, 2, 1 ], 
  [ 3, 1, 1, 1 ], [ 3, 1, 2, 1 ], [ 3, 2, 1, 1 ], [ 3, 2, 2, 1 ], 
  [ 3, 3, 1, 1 ], [ 3, 3, 2, 1 ], [ 4, 1, 1, 1 ], [ 4, 1, 2, 1 ], 
  [ 4, 2, 1, 1 ], [ 4, 2, 2, 1 ], [ 4, 3, 1, 1 ], [ 4, 3, 2, 1 ] ]
gap> AcceptedWordsR(a,4);
[ [ 1, 1, 1, 1 ], [ 1, 2, 1, 1 ], [ 1, 1, 2, 1 ], [ 1, 2, 2, 1 ], 
  [ 1, 1, 3, 1 ], [ 1, 2, 3, 1 ], [ 1, 1, 1, 2 ], [ 1, 2, 1, 2 ], 
  [ 1, 1, 2, 2 ], [ 1, 2, 2, 2 ], [ 1, 1, 3, 2 ], [ 1, 2, 3, 2 ], 
  [ 1, 1, 1, 3 ], [ 1, 2, 1, 3 ], [ 1, 1, 2, 3 ], [ 1, 2, 2, 3 ], 
  [ 1, 1, 3, 3 ], [ 1, 2, 3, 3 ], [ 1, 1, 1, 4 ], [ 1, 2, 1, 4 ], 
  [ 1, 1, 2, 4 ], [ 1, 2, 2, 4 ], [ 1, 1, 3, 4 ], [ 1, 2, 3, 4 ] ]
gap> a:=BoundedClassAutomaton(5);
< deterministic automaton on 5 letters with 5 states >
gap> ba:=BasisAutomaton(a);
< non deterministic automaton on 5 letters with 3 states >
gap> AutStateTransitionMatrix(ba);
Error, AutStateTransitionMatrix can only be applied to determistic automata.
gap> STOP_TEST( "chap6.tst", 10000 );
