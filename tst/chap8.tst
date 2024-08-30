#############################################################################
##
#A  chap8.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
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
gap> OnePointDelete([2,4,6,8,1,3,5,7]);
[ 2, 4, 6, 8, 1, 3, 5, 7 
 ] is an exceptional permutation and needs 2 point deletion.
fail
gap> OnePointDelete([1,2,4,6,8,3,5,7]);
[ 1, 2, 4, 6, 8, 3, 5, 7 ] is not simple.
fail
gap> TwoPointDelete([2,4,6,8,1,3,5,7]);
[ [ 2, 3, 4, 1, 1, 1 ] ]
gap> TwoPointDelete([2,3,4,5,1,1,1,1]);
[ [ 2, 3, 4, 1, 1, 1 ] ]
gap> TwoPointDelete([7,5,3,1,8,6,4,2]);
[ [ 5, 3, 1, 3, 2, 1 ] ]
gap> TwoPointDelete([5,1,6,2,7,3,8,4]);
[ [ 4, 1, 3, 1, 2, 1 ] ]
gap> TwoPointDelete([4,8,3,7,2,6,1,5]);
[ [ 3, 5, 2, 3, 1, 1 ] ]
gap> TwoPointDelete([1,2,4,6,8,3,5,7]);
The input permutation is not an exceptional permutation.
fail
gap> PointDeletion([5,2,3,1,2,1]);
[ [ 2, 3, 1, 2, 1 ], [ 4, 1, 2, 2, 1 ] ]
gap> PointDeletion([5,2,4,1,6,3]);
[ [ 2, 3, 1, 2, 1 ], [ 4, 1, 2, 2, 1 ] ]
gap> PointDeletion([2,4,6,8,1,3,5,7]);
[ [ 2, 3, 4, 1, 1, 1 ] ]
gap> PointDeletion([2,3,4,5,1,1,1,1]);
[ [ 2, 3, 4, 1, 1, 1 ] ]
gap> PointDeletion([1,2,3,4,5]);
[ 1, 2, 3, 4, 5 ] is not simple.
fail
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
gap> IsMinusDecomposable([1,2,6,5,4,3]);
false
gap> PermDirectSum([2,4,1,3],[2,5,4,1,3]);
[ 2, 4, 1, 3, 6, 9, 8, 5, 7 ]
gap> PermDirectSum([2,3,1,1],[2,4,3,1,1]);
[ 2, 3, 1, 1, 2, 4, 3, 1, 1 ]
gap> PermSkewSum([2,4,1,3],[2,5,4,1,3]);
[ 7, 9, 6, 8, 2, 5, 4, 1, 3 ]
gap> PermSkewSum([2,3,1,1],[2,4,3,1,1]);
[ 7, 8, 6, 6, 2, 4, 3, 1, 1 ]
gap> STOP_TEST( "chap8.tst", 10000 );
