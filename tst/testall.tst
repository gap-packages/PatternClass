#############################################################################
##
#A  testall.tst            PatternClass package                 Ruth Hoffmann
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
gap> RankEncoding([3, 2, 5, 1, 6, 7, 4, 8, 9]);
[ 3, 2, 3, 1, 2, 2, 1, 1, 1 ]
gap> RankDecoding(last);
[ 3, 2, 5, 1, 6, 7, 4, 8, 9 ]
gap> SequencesToRatExp([[1,1,1,1,1],[2,1,2,2,1],[3,2,1,2,1],[4,2,3,2,1]]);
aaaaaUbabbaUcbabaUdbcba
gap> a:=Seqstacks(3,3);
[ [ 2 ], [ 3, 5 ], [ 2, 4 ], [ 3 ], [ 6, 8 ], [ 5, 7 ], [ 6 ], [  ] ]
gap> aut:=GraphToAut(a,1,8);
< epsilon automaton on 6 letters with 680 states >
gap> a:=Parstacks(5,5);
[ [ 2, 7 ], [ 3, 12 ], [ 2, 4 ], [ 3, 5 ], [ 4, 6 ], [ 5 ], [ 8, 12 ], 
  [ 7, 9 ], [ 8, 10 ], [ 9, 11 ], [ 10 ], [  ] ]
gap> aut:=ConstrainedGraphToAut(a,1,12,5);
< epsilon automaton on 12 letters with 5074 states >
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
gap> x:=Automaton("det",2,2,[[1,2],[2,2]],[1],[1]);
< deterministic automaton on 2 letters with 2 states >
gap> IsPossibleGraphAut(x);
true
gap> x:=Automaton("det",2,2,[[1,2],[1,2]],[1],[1]);
< deterministic automaton on 2 letters with 2 states >
gap> IsPossibleGraphAut(x);
false
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
gap> IsInterval([3,6,9,2]);
false
gap> IsInterval([2,6,5,3,4]);
true
gap> IsSimplePerm([2,3,4,5,1,1,1,1]);
true
gap> IsSimplePerm([2,4,6,8,1,3,5,7]);
true
gap> IsSimplePerm([3,2,8,6,7,1,5,4]);
false
gap> IsSimplePerm([1,1,1,1]);
false
gap> OnePointDelete([5,2,3,1,2,1]);
[ [ 2, 3, 1, 2, 1 ], [ 4, 1, 2, 2, 1 ] ]
gap> OnePointDelete([5,2,4,1,6,3]);
[ [ 2, 3, 1, 2, 1 ], [ 4, 1, 2, 2, 1 ] ]
gap> TwoPointDelete([2,4,6,8,1,3,5,7]);
[ [ 2, 3, 4, 1, 1, 1 ] ]
gap> TwoPointDelete([2,3,4,5,1,1,1,1]);
[ [ 2, 3, 4, 1, 1, 1 ] ]
gap> PointDeletion([5,2,3,1,2,1]);
[ [ 2, 3, 1, 2, 1 ], [ 4, 1, 2, 2, 1 ] ]
gap> PointDeletion([5,2,4,1,6,3]);
[ [ 2, 3, 1, 2, 1 ], [ 4, 1, 2, 2, 1 ] ]
gap> PointDeletion([2,4,6,8,1,3,5,7]);
[ [ 2, 3, 4, 1, 1, 1 ] ]
gap> PointDeletion([2,3,4,5,1,1,1,1]);
[ [ 2, 3, 4, 1, 1, 1 ] ]
gap> Inflation([[3,2,1],[1],[1,2],[1,2,3]]);
[ 6, 4, 5, 1, 2, 3 ]
gap> Inflation([[1,2],[1],[4,2,1,3]]);
[ 1, 5, 3, 2, 4 ]
gap> Inflation([[2,4,1,3],[2,1],[3,1,2],[1],[2,4,1,3]]);
[ 3, 2, 10, 8, 9, 1, 5, 7, 4, 6 ]
gap> BlockDecomposition([3,2,10,8,9,1,5,7,4,6]);
[ [ 2, 4, 1, 3 ], [ 2, 1 ], [ 3, 1, 2 ], [ 1 ], [ 2, 4, 1, 3 ] ]
gap> BlockDecomposition([1,2,3,4,5]);
[ [ 1, 2 ], [ 1, 2, 3, 4 ], [ 1 ] ]
gap> BlockDecomposition([5,4,3,2,1]);
[ [ 2, 1 ], [ 4, 3, 2, 1 ], [ 1 ] ]
gap> IsPlusDecomposable([3,3,2,3,2,2,1,1]);
true
gap> IsPlusDecomposable([3,2,8,6,7,1,5,4]);
false
gap> IsPlusDecomposable([3,4,2,6,5,7,1,8]);
true
gap> IsMinusDecomposable([3,3,3,3,3,3,2,1]);
true
gap> IsMinusDecomposable([3,4,5,6,7,8,2,1]);
true
gap> IsMinusDecomposable([3,2,8,6,7,1,5,4]);
false
gap> PermDirectSum([2,4,1,3],[2,5,4,1,3]);
[ 2, 4, 1, 3, 6, 9, 8, 5, 7 ]
gap> PermDirectSum([2,3,1,1],[2,4,3,1,1]);
[ 2, 3, 1, 1, 2, 4, 3, 1, 1 ]
gap> PermSkewSum([2,4,1,3],[2,5,4,1,3]);
[ 7, 9, 6, 8, 2, 5, 4, 1, 3 ]
gap> PermSkewSum([2,3,1,1],[2,4,3,1,1]);
[ 7, 8, 6, 6, 2, 4, 3, 1, 1 ]
gap> a:=InversionAut(1);
< deterministic automaton on 2 letters with 4 states >
gap> Spectrum(a);
[ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ]
gap> b:=InversionAut(5);
< deterministic automaton on 6 letters with 14 states >
gap> Spectrum(b);
[ 0, 0, 0, 3, 22, 71, 169, 343, 628, 1068, 1717, 2640, 3914, 5629, 7889 ]
gap> InversionAutOfClass(BoundedClassAutomaton(5),4);
< epsilon automaton on 6 letters with 20 states >
gap> InversionAutOfClass(BoundedClassAutomaton(5),6);
< epsilon automaton on 8 letters with 30 states >
gap> InversionAutOfClass(BoundedClassAutomaton(5),10);
< epsilon automaton on 12 letters with 50 states >
gap> PlusDecomposableAut(BoundedClassAutomaton(4));
< deterministic automaton on 4 letters with 7 states >
gap> PlusDecomposableAut(BoundedClassAutomaton(10));
< deterministic automaton on 10 letters with 19 states >
gap> PlusIndecomposableAut(BoundedClassAutomaton(4));
< deterministic automaton on 4 letters with 6 states >
gap> PlusIndecomposableAut(BoundedClassAutomaton(10));
< deterministic automaton on 10 letters with 12 states >
gap> MinusDecomposableAut(BoundedClassAutomaton(4));
< epsilon automaton on 5 letters with 28 states >
gap> MinusDecomposableAut(BoundedClassAutomaton(8));
< epsilon automaton on 9 letters with 181 states >
gap> MinusIndecomposableAut(BoundedClassAutomaton(4));
< deterministic automaton on 4 letters with 9 states >
gap> MinusIndecomposableAut(BoundedClassAutomaton(8));
< deterministic automaton on 8 letters with 31 states >
gap> NonSimpleAut(5);
< epsilon automaton on 6 letters with 187 states >
gap> NonSimpleAut(7);
< epsilon automaton on 8 letters with 771 states >
gap> NonSimpleAut(4);
< epsilon automaton on 5 letters with 85 states >
gap> SimplePermAut(3);
< deterministic automaton on 3 letters with 8 states >
gap> SimplePermAut(4);
< deterministic automaton on 4 letters with 22 states >
gap> SimplePermAut(5);
< deterministic automaton on 5 letters with 77 states >
gap> SimplePermAut(6);
< deterministic automaton on 6 letters with 266 states >
gap> IsExceptionalPerm([1,2,5,3,4]);
false
gap> IsExceptionalPerm([1,1,3,1,1]);
false
gap> IsExceptionalPerm([2,3,4,5,1,1,1,1]);
true
gap> IsExceptionalPerm([2,4,6,8,1,3,5,7]);
true
gap> IsExceptionalPerm([7,5,3,1,4,3,2,1]);
true
gap> IsExceptionalPerm([7,5,3,1,8,6,4,2]);
true
gap> IsExceptionalPerm([5,1,4,1,3,1,2,1]);
true
gap> IsExceptionalPerm([5,1,6,2,7,3,8,4]);
true
gap> IsExceptionalPerm([4,7,3,5,2,3,1,1]);
true
gap> IsExceptionalPerm([4,8,3,7,2,6,1,5]);
true
gap> ExceptionalBoundedAutomaton(6);
< deterministic automaton on 6 letters with 26 states >
gap> Spectrum(last);
[ 0, 2, 0, 2, 0, 4, 0, 2, 0, 2, 0, 0, 0, 0, 0 ]
gap> ExceptionalBoundedAutomaton(15);
< deterministic automaton on 15 letters with 104 states >
gap> Spectrum(last);
[ 0, 2, 0, 2, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0 ]
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
gap> STOP_TEST( "testall.tst", 10000 );
