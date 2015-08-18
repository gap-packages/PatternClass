################################################################################
##
#M Row count method
##
## This method allows us to count negative indices in lists. It is useful for 
## indexing gridding matices where the index of the entry/cell is associated with
## the coordinates in the x,y plot. So cols and rows are interchanged and rows
## are counted from bottom to top.
##
InstallMethod(ELM_LIST, [IsList and IsFinite , IsInt], function(l,x)if x > 0 then return l[x]; else return l[Length(l)+1+x]; fi; end);

################################################################################
##
#F  IsZeroPMOneMatrix(matrix)
##
## Checker whether the input matrix only consists of 0s, 1s and -1s.
##
DeclareGlobalFunction( "IsZeroPMOneMatrix" );

DeclareSynonym("IsZeroOneMatrix",IsZeroPMOneMatrix );

################################################################################
##
#F  TurnToPMM(matrix)
##
## Takes a 0/+1/-1 matrix and turns it into its partial multiplication matrix.
## Returns the PMM and its column and row signs.
##
DeclareGlobalFunction( "TurnToPMM" );

################################################################################
##
#F  HasColumnRowSigns(matrix)
##
## Takes a 0/+1/-1 matrix and checkes whether it could be a partial 
## multiplication matrix. HasColumnRowSigns returns column and row signs for mat.
##
DeclareGlobalFunction( "HasColumnRowSigns" );

################################################################################
##
#F  IsPMMWithColRowSigns(pmm)
##
## Input is a list containing a 0/+1/-1 matrix and its column and row signs.
## It checkes whether the entries of the matrix correspond to the multiplication
## of the relevant signs or 0.
##
DeclareGlobalFunction( "IsPMMWithColRowSigns" );

DeclareSynonym("IsPMMColRow",IsPMMWithColRowSigns );

################################################################################
##
#F  GridDecoding(matrix,word)
##
## Input is a 0/+1/-1 matrix, with or without colum/row signs and a word
## of the alphabet {[i,j] : M(i,j) in {1,-1} }. Using the decoding described in
## Geometric grid classes of permutations or On partial well-coder for monotone
## grid classes of permutations the result is a permutation. 
##
##
DeclareGlobalFunction( "GridDecoding" );

################################################################################
##
#F GridAut(matrix)
##
## Builds the automaton that accepts all words over the alphabet of the matrix.
## Where the alphabet is build by marking all non-empty entries of the matrix 
## incrementally L->R T->B.
##
DeclareGlobalFunction( "GridAut" );

################################################################################
##
#F GridAlphabet(matrix)
##
## Technically just determines how many non-empty entries the matrix has and then
## sets up an alphabet on that number. It is a useful small function though.
## Convention of alphabet is L-R, T-B, rather than the 'normal', in sense of 
## working through the cells in euclidian coordinate fashion.
##
DeclareGlobalFunction( "GridAlphabet" );

################################################################################
##
#F CoordinatesToAlphabetInOrder(coordinates)
##
## Takes a list of coordinates and translates them into the the word in the 
## alphabet (with the GridAlphabet convention) such that the Automaton can 
## recognise the word.
##
DeclareGlobalFunction( "CoordinatesToAlphabetInOrder" );

################################################################################
##
#F MatToCoordinates(matrix)
##
## Returns the 'coordinates'/indeces of the non-empty entries of the matrix.
##
DeclareGlobalFunction( "MatToCoordinates" );

################################################################################
##
#F WordToGridCoordinates(matrix,word)
##
## Translates the word over the automaton alphabet into the word over the indeces
## 'coordinates' of the non-empty entries of the matrix.
##
DeclareGlobalFunction( "WordToGridCoordinates" );

################################################################################
##
#F CoordinatesToWord(matrix,wordincoordinates)
##
## Translates the given word in coordinates to a word over the matrix automaton
## alphabet.
##
DeclareGlobalFunction( "CoordinatesToWord" );

################################################################################
##
#F PMMTox3Mat(matrix)
##
## Turns a m x n partial multiplication matrix into the 3m x 3n equivalent matri
##
DeclareGlobalFunction( "PMMTox3Mat" );

################################################################################
##
#F PMMTox3Trans(matrix)
##
## Builds transducer that translates all words that correspond to the permutations,
## that are griddable by the input matrix, to the words over the x3 matrix alphabet.
##
DeclareGlobalFunction( "PMMTox3Trans" );

################################################################################
##
#F x3ToOffSetMat(matrixwithcolumnrowsigns)
##
## Takes the x3 matrix with row and column signs and returns the one point 
## extension matrix, which allows for points to lie off the diagonal.
##
DeclareGlobalFunction( "x3ToOffSetMat" );

################################################################################
##
#F  MatrixUnion(mats)
##
## Takes the input list of matrices mats and concatenates these matrices into 
## a larger matrix that contains mats on its diagonal.
##
DeclareGlobalFunction( "MatrixUnion" );

################################################################################
##
#F  Find22Mats(mat)
##
## Inspects all 2x2 blocks in the matrix mat if a [[0,1],[1,0]] is seen then 
## in the returned matrix a 1 is written, for [[-1,0],[0,-1]] there is a -1, if 
## [[0,0],[0,0]] then 0 else we write 9.
##
DeclareGlobalFunction( "Find22Mats" );

################################################################################
##
#F  CheckMarkedMat(mat)
##
## CheckMarkedMat goes through the marked matrix returned by Find22Mats and 
## notes which rows and columns do not contain consecutive 9's, only 0's & 9's 
## and whether there is an entry on a row or column that could interfere with 
## the collapsing of the 2x2 blocks.
##
DeclareGlobalFunction( "CheckMarkedMat" );

################################################################################
##
#F  MatrixReduction(mat)
##
## MatrixReduction collapses 2x2 blocks with either 0's or other collapsable 
## 2x2 on their cols and rows.
##
DeclareGlobalFunction( "MatrixReduction" );

################################################################################
##
#F  RemoveZeroColumnsRows(mat)
##
## RemoveZeroColumnsRows returns a matrix that contains no columns or rows with
## only 0 entries.
##
DeclareGlobalFunction( "RemoveZeroColumnsRows" );

################################################################################
##
#F  mover(grid,max)
##
## Helper function to move (increment) the grid lines by one.
##
DeclareGlobalFunction( "mover" );

################################################################################
##
#F  IsInCell(perm,cell,cellval)
##
## Helper checker for a specific cell, where we are checking whether perm has
## values within the cell boundaries and whether these values are in the correct
## monotonicity, based on cellval.
##
DeclareGlobalFunction( "IsInCell" );

################################################################################
##
#F  IsInGrid(perm,grid,mat)
##
## Checks whether perm is griddable by a specific grid, with mat indicating the 
## monotonicity in the cells.
##
DeclareGlobalFunction( "IsInGrid" );

################################################################################
##
#F  IsGriddable(perm,mat)
##
## Checkes whether a specific permutation perm is griddable by mat. This is based
## at the moment on a brute-force algorithm that goes through all possible 
## griddings until a gridding is found.
##
DeclareGlobalFunction( "IsGriddable" );

################################################################################
##
#F  BoundedGridPerms(mat,n)
##
## Outputs all permutations, of length n, gridded by mat. Currently brute-force
## algorithm, producing all permutations of length n. Checking all whether they
## are griddable by mat and then returns only the permutations that are.
##
DeclareGlobalFunction( "BoundedGridPerms" );

################################################################################
##
#F Griddings
##
## Returns all possible griddings (in form of gridline coordinates) of perm 
## in mat.
DeclareGlobalFunction( "Griddings" );
