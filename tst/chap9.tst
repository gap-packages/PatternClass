#############################################################################
##
#A  chap9.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
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
gap> InversionAutOfClass(BoundedClassAutomaton(7),4);
< epsilon automaton on 8 letters with 20 states >
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
gap> STOP_TEST( "chap9.tst", 10000 );
