#############################################################################
##
#A  vis.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("visualisation");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> hex:=[[2,3],[4],[5],[3,6],[6],[]];;
gap> hex2:=[ [ 2, 6 ], [ 3, 9 ], [ 2, 4 ], [ 3, 5 ], [ 4 ], [ 7, 9 ], [ 6, 8 ], [ 7 ], [  ] ];;
gap> tpn := TPN2dot(hex,"Network");
Error, Variable: 'TPN2dot' must have a value
gap> tpn2 := TPN2dot(hex2,"Network2");
Error, Variable: 'TPN2dot' must have a value
gap> trans := rec( accepting := [ 2 ], initial := 1, states := 3, transitions := [ [ 1, 2, 1, 2 ], [ 1, 2, 2, 2 ], [ 2, 2, 1, 3 ], [ 2, 2, 2, 3 ], [ 1, 1, 3, 3 ], [ 2, 2, 3, 3 ] ] );;
gap> trans2 := rec( accepting := [ 1 .. 3 ], initial := 4, states := 4, transitions := [ [ 1, 1, 4, 4 ], [ 0, 1, 4, 1 ], [ 1, 2, 1, 1 ], [ 1, 1, 1, 2 ], [ 2, 3, 1, 1 ], [ 1, 1, 2, 3 ], [ 1, 1, 3, 3 ], [ 2, 2, 4, 4 ], [ 0, 2, 4, 2 ], [ 2, 3, 2, 2 ], [ 2, 2, 2, 3 ], [ 2, 2, 3, 3 ], [ 3, 3, 4, 4 ], [ 0, 3, 4, 3 ], [ 3, 3, 3, 3 ] ] );'
rec( accepting := [ 1 .. 3 ], initial := 4, states := 4, 
  transitions := [ [ 1, 1, 4, 4 ], [ 0, 1, 4, 1 ], [ 1, 2, 1, 1 ], 
      [ 1, 1, 1, 2 ], [ 2, 3, 1, 1 ], [ 1, 1, 2, 3 ], [ 1, 1, 3, 3 ], 
      [ 2, 2, 4, 4 ], [ 0, 2, 4, 2 ], [ 2, 3, 2, 2 ], [ 2, 2, 2, 3 ], 
      [ 2, 2, 3, 3 ], [ 3, 3, 4, 4 ], [ 0, 3, 4, 3 ], [ 3, 3, 3, 3 ] ] )
Syntax error: Character literal must not include <newline> in stream:1
trans2 := rec( accepting := [ 1 .. 3 ], initial := 4, states := 4, transitions\
 := [ [ 1, 1, 4, 4 ], [ 0, 1, 4, 1 ], [ 1, 2, 1, 1 ], [ 1, 1, 1, 2 ], [ 2, 3, \
1, 1 ], [ 1, 1, 2, 3 ], [ 1, 1, 3, 3 ], [ 2, 2, 4, 4 ], [ 0, 2, 4, 2 ], [ 2, 3\
, 2, 2 ], [ 2, 2, 2, 3 ], [ 2, 2, 3, 3 ], [ 3, 3, 4, 4 ], [ 0, 3, 4, 3 ], [ 3,\
 3, 3, 3 ] ] );'
                                                                              \
                                                                              \
                                                                              \
                                                                              \
               ^
gap> vist := Transducer2dot(trans,"trans");
Error, Variable: 'Transducer2dot' must have a value
gap> vist2 := Transducer2dot(trans2,"trans2");
Error, Variable: 'Transducer2dot' must have a value
gap> END_TEST("PatternClass");
Error, Variable: 'END_TEST' must have a value
