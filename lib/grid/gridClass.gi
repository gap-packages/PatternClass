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
InstallGlobalFunction(IsZeroPMOneMatrix, function(m)
local i,j;

for i in [1..Length(m)] do
    for j in [1..Length(m[1])] do
        if not(m[i][j] in [0,1,-1]) then
            return false;
        fi;
    od;
od;
return true;
end );

################################################################################
##
#F  TurnToPMM(matrix)
##
## Takes a 0/+1/-1 matrix and turns it into its partial multiplication matrix.
## Returns the PMM and its column and row signs.
##
InstallGlobalFunction(TurnToPMM, function(m)
local i,j,res,tmp1,tmp2,mat;

res:=[];
mat:=NullMat(Length(m)*2,Length(m[1])*2);

if not(IsZeroPMOneMatrix(m)) then
    return fail;
fi;
for i in [1..Length(m)] do
    for j in [1..Length(m[1])] do
        if m[i][j] = 1 then
            mat{[2*i-1..2*i]}{[2*j-1..2*j]}:=[[0,1],[1,0]];
        elif m[i][j] = 0 then
            mat{[2*i-1..2*i]}{[2*j-1..2*j]}:=[[0,0],[0,0]];
        elif m[i][j] = -1 then
            mat{[2*i-1..2*i]}{[2*j-1..2*j]}:=[[-1,0],[0,-1]];
        fi;
    od;
od;

tmp1:=[];
for i in [1..Length(mat[1])] do
    Add(tmp1,(-1)^i);
od;
tmp2:=[];
for i in [1..Length(mat)] do
    Add(tmp2, (-1)^i);
od;
Add(res,mat);
Add(res,tmp1);
Add(res,tmp2);
return res;

end );
################################################################################
##
#F  HasColumnRowSigns(matrix)
##
## Takes a 0/+1/-1 matrix and checkes whether it could be a partial
## multiplication matrix. HasColumnRowSigns returns column and row signs for mat.
##
InstallGlobalFunction(HasColumnRowSigns, function(mat)
local row, col, first, i, j, res;

row:=ListWithIdenticalEntries(Length(mat),0);
col:=ListWithIdenticalEntries(Length(mat[1]),0);

first:=PositionNot(mat[1],0);

if mat[1][first] = 1 then
    col[first]:=1;
    row[1]:=1;
else
    col[first]:=-1;
    row[1]:=1;
fi;

for i in [1..Length(mat)] do
    for j in [1..Length(mat[1])] do
        if not(mat[i][j] = 0) then
            if mat[i][j] = 1 then
                if row[i] = 0 and col[j] = 0 then   #SPECIAL CASE when a possible second free choice
                                                    #could happen, but shouldn't.
                    if mat[i]{[j+1..Length(mat[1])]} = ListWithIdenticalEntries(Length(mat[1])-j,0) and
                       Flat(mat{[i+1..Length(mat)]}[j]) = ListWithIdenticalEntries(Length(mat)-i,0) then
                        row[i]:=1;
                        col[j]:=1;
                    elif not(mat[i]{[j+1..Length(mat[1])]} = ListWithIdenticalEntries(Length(mat[1])-j,0)) then
                        first:=PositionNot(col,0);
                        while first < Length(col) and mat[i][first] = 0 do
                            first:=PositionNot(col{[first+1..Length(col)]},0)+first;
                        od;
                        if first <= Length(col) and mat[i][first] = 1 then
                            row[i]:=col[first];
                            col[j]:=col[first];
                        elif first <= Length(col) and mat[i][first] = -1 then
                            row[i]:=-col[first];
                            col[j]:=-col[first];
                        elif first > Length(col) then
                            row[i]:=1;
                            col[j]:=1;
                        fi;
                    elif not(Flat(mat{[i+1..Length(mat)]}[j]) = ListWithIdenticalEntries(Length(mat)-i,0)) then
                        first:=PositionNot(row,0);
                        while first < Length(row) and mat[first][j] = 0 do
                            first:=PositionNot(row{[first+1..Length(row)]},0)+first;
                        od;
                        if first <= Length(row) and mat[first][j] = 1 then
                            row[i]:=row[first];
                            col[j]:=row[first];
                        elif first <= Length(row) and mat[first][j] = -1 then
                            row[i]:=-row[first];
                            col[j]:=-row[first];
                        elif first > Length(row) then
                            row[i]:=1;
                            col[j]:=1;
                        fi;
                    fi;
                elif row[i] = 0 and col[j] in [1,-1] then

                    row[i]:=col[j];
                elif col[j] = 0 and row[i] in [1,-1] then

                    col[j]:=row[i];
                elif not(row[i] = col[j]) and not(col[j] = 0 or row[i] = 0) then
                    return false;
                fi;
            else
                if row[i] = 0 and col[j] = 0 then   #SPECIAL CASE when a possible second free choice
                                                    #could happen, but shouldn't.
                    if mat[i]{[j+1..Length(mat[1])]} = ListWithIdenticalEntries(Length(mat[1])-j,0) and
                       Flat(mat{[i+1..Length(mat)]}[j]) = ListWithIdenticalEntries(Length(mat)-i,0) then
                        row[i]:=1;
                        col[j]:=-1;
                    elif not(mat[i]{[j+1..Length(mat[1])]} = ListWithIdenticalEntries(Length(mat[1])-j,0)) then
                        first:=PositionNot(col,0);
                        while first < Length(col) and mat[i][first] = 0 do
                            first:=PositionNot(col{[first+1..Length(col)]},0)+first;
                        od;
                        if first <= Length(col) and mat[i][first] = 1 then
                            row[i]:=col[first];
                            col[j]:=-col[first];
                        elif first <= Length(col) and mat[i][first] = -1 then
                            row[i]:=-col[first];
                            col[j]:=col[first];
                        elif first > Length(col) then
                            row[i]:=-1;
                            col[j]:=1;
                        fi;
                    elif not(Flat(mat{[i+1..Length(mat)]}[j]) = ListWithIdenticalEntries(Length(mat)-i,0)) then
                        first:=PositionNot(row,0);
                        while first < Length(row) and mat[first][j] = 0 do
                            first:=PositionNot(row{[first+1..Length(row)]},0)+first;
                        od;
                        if first <= Length(col) and mat[first][j] = 1 then
                            row[i]:=row[first];
                            col[j]:=-row[first];
                        elif first <= Length(col) and mat[i][first] = -1 then
                            row[i]:=-row[first];
                            col[j]:=row[first];
                        elif first > Length(row) then
                            row[i]:=-1;
                            col[j]:=1;
                        fi;
                    fi;
                elif row[i] = 0 and col[j] in [1,-1] then
                    row[i]:=-col[j];
                elif col[j] = 0 and row[i] in [1,-1] then
                    col[j]:=-row[i];
                elif row[i] = col[j] and not(col[j] = 0 or row[i] = 0) then
                    return false;
                fi;
            fi;
        fi;
    od;
od;

return [col,Reversed(row)];

end );


################################################################################
##
#F  IsPMMWithColRowSigns(pmm)
##
## Input is a list containing a 0/+1/-1 matrix and its column and row signs.
## It checkes whether the entries of the matrix correspond to the multiplication
## of the relevant signs or 0.
##
InstallGlobalFunction(IsPMMWithColRowSigns, function(pmm)
local i,j;

if not(IsZeroPMOneMatrix(pmm[1])) then
    return false;
fi;

for i in [1..Length(pmm[2])] do
    for j in [1..Length(pmm[3])] do
        if not((pmm[2][i]*pmm[3][j] = pmm[1][-j][i]) or (pmm[1][-j][i]=0)) then
            return false;
        fi;
    od;
od;

return true;

end );

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
InstallGlobalFunction(GridDecoding, function(matrix,word)
local matcr,index,i,values;

if IsPMMWithColRowSigns(matrix) then
    matcr:=StructuralCopy(matrix);
elif not(HasColumnRowSigns(matrix) = false) then
    matcr:=[StructuralCopy(matrix),HasColumnRowSigns(matrix)[1],HasColumnRowSigns(matrix)[2]];
else
    matcr:=TurnToPMM(matrix);
fi;

#
# If
##  COL = 1 then insert LEFT TO RIGHT
##  COL = -1 then insert RIGHT TO LEFT
# If
##  ROW = 1 then insert BOTTOM TO TOP
##  ROW = -1 then insert TOP TO BOTTOM

index:=[];
values:=[];
for i in [1..Length(word)] do
    if matcr[2][word[i][1]] = 1 then
        index[i]:=Length(Filtered(word{[1..Length(word)]}[1], x -> x <= word[i][1])) -
                Length(Filtered(word{[i+1..Length(word)]}[1], x -> x = word[i][1]));
    else
        index[i]:=Length(Filtered(word{[1..Length(word)]}[1], x -> x <= word[i][1])) -
                Length(Filtered(word{[1..i-1]}[1], x -> x = word[i][1]));
    fi;
    if matcr[3][word[i][2]] = 1 then
        values[i]:=Length(Filtered(word{[1..Length(word)]}[2], x -> x <= word[i][2])) -
                Length(Filtered(word{[i+1..Length(word)]}[2], x -> x = word[i][2]));
    else
        values[i]:=Length(Filtered(word{[1..Length(word)]}[2], x -> x <= word[i][2])) -
                Length(Filtered(word{[1..i-1]}[2], x -> x = word[i][2]));
    fi;
od;

return Permuted(values,SortingPerm(index));
end );

################################################################################
##
#F GridAut(matrix)
##
## Builds the automaton that accepts all words over the alphabet of the matrix.
## Where the alphabet is build by marking all non-empty entries of the matrix
## incrementally L->R T->B.
##
InstallGlobalFunction(GridAut, function(matrix)
local alph,i;

alph:=[];
for i in [1..Length(matrix)] do
    if not(Position(matrix[i],1) = fail) then
        Append(alph,Positions(matrix[i],1));
    elif not(Position(matrix[i],-1) = fail) then
        Append(alph,Positions(matrix[i],-1));
    fi;
od;

return Automaton("det",1,Length(alph),ListWithIdenticalEntries(Length(alph),[1]),[1],[1]);

end );

################################################################################
##
#F GridAlphabet(matrix)
##
## Technically just determines how many non-empty entries the matrix has and then
## sets up an alphabet on that number. It is a useful small function though.
## Convention of alphabet is L-R, T-B, rather than the 'normal', in sense of
## working through the cells in euclidian coordinate fashion.
##
InstallGlobalFunction(GridAlphabet, function(mat)
local alph,count,x,y,i,j;

count:=0;
for i in [1..Length(mat)] do
    for j in [1..Length(mat[1])] do
        if mat[i][j] <> 0 then
            count:=count+1;
        fi;
    od;
od;

return [1..count];

end );

################################################################################
##
#F CoordinatesToAlphabetInOrder(coordinates)
##
## Takes a list of coordinates and translates them into the the word in the
## alphabet (with the GridAlphabet convention) such that the Automaton can
## recognise the word.
##
InstallGlobalFunction(CoordinatesToAlphabetInOrder, function(coords)
local alph,count,x,y;

alph:=ListWithIdenticalEntries(Length(coords),0);
count:=1;
for y in [Maximum(coords{[1..Length(coords)]}[2]),Maximum(coords{[1..Length(coords)]}[2])-1..1] do
    for x in [1..Maximum(coords{[1..Length(coords)]}[1])] do
        if [x,y] in coords then
            alph[Position(coords,[x,y])]:=count;
            count:=count+1;
        fi;
    od;
od;

return alph;
end );

################################################################################
##
#F MatToCoordinates(matrix)
##
## Returns the 'coordinates'/indeces of the non-empty entries of the matrix.
##
InstallGlobalFunction(MatToCoordinates, function(mat)
local coords, i, j;

coords:=[];
for i in [1..Length(mat)] do
    for j in [1..Length(mat[1])] do
        if mat[i][j] <> 0 then
            Add(coords,[j,Length(mat)-i+1]);
        fi;
    od;
od;

return coords;
end );

################################################################################
##
#F WordToGridCoordinates(matrix,word)
##
## Translates the word over the automaton alphabet into the word over the indeces
## 'coordinates' of the non-empty entries of the matrix.
##
InstallGlobalFunction(WordToGridCoordinates, function(mat,word)
local coords,res,i;

coords:=MatToCoordinates(mat);

res:=[];

for i in [1..Length(word)] do
    Add(res,coords[word[i]]);
od;

return res;

end );

################################################################################
##
#F CoordinatesToWord(matrix,wordincoordinates)
##
## Translates the given word in coordinates to a word over the matrix automaton
## alphabet.
##
InstallGlobalFunction(CoordinatesToWord, function(mat,wcoords)
local coords, res, i;

coords:=MatToCoordinates(mat);

res:=[];
for i in [1..Length(wcoords)] do
    Add(res,Position(coords,wcoords[i]));
od;

return res;

end );

################################################################################
##
#F PMMTox3Mat(matrix)
##
## Turns a m x n partial multiplication matrix into the 3m x 3n equivalent matri
##
InstallGlobalFunction(PMMTox3Mat, function(mat)
local dims,resmat,i,j,colrow,rescr;

if HasColumnRowSigns(mat) = false then
    Print("Input matrix is not PMM.\n");
    return fail;
fi;

dims:=DimensionsMat(mat);
resmat:=NullMat(3*dims[1],3*dims[2]);

for i in [1..dims[1]] do
    for j in [1..dims[2]] do
        if mat[i][j] = 1 then
            resmat{[3*i-2..3*i]}{[3*j-2..3*j]}:=[[0,0,1],[0,1,0],[1,0,0]];
        elif mat[i][j] = -1 then
            resmat{[3*i-2..3*i]}{[3*j-2..3*j]}:=[[-1,0,0],[0,-1,0],[0,0,-1]];
        elif mat[i][j] = 0 then
            resmat{[3*i-2..3*i]}{[3*j-2..3*j]}:=[[0,0,0],[0,0,0],[0,0,0]];
        else
            Print("This matrix does not contain only 0,1,-1's.\n");
            return fail;
        fi;
    od;
od;

colrow:=HasColumnRowSigns(mat);
rescr:=[[],[]];
rescr[1]:=Flat(List(colrow[1], i-> [i,i,i]));
rescr[2]:=Flat(List(colrow[2], i-> [i,i,i]));


return [resmat,rescr[1],rescr[2]];
end );



################################################################################
##
#F PMMTox3Trans(matrix)
##
## Builds transducer that translates all words that correspond to the permutations,
## that are griddable by the input matrix, to the words over the x3 matrix alphabet.
##
InstallGlobalFunction(PMMTox3Trans, function(inmat)
local mat,signs,inalp,i,j,outalp,x,y,from,to,trans,count,aut;

if IsMatrix(inmat[1]) then
    mat:=inmat[1];
    signs:=[inmat[2],inmat[3]];
else
    mat:=inmat;
    signs:=HasColumnRowSigns(mat);
    if signs = false then
        Print("Input matrix is not a partial multiplication matrix\n");
        return fail;
    fi;
fi;

inalp:=[];
for i in [1..Length(mat)] do
    for j in [1..Length(mat[1])] do
        if mat[i][j] <> 0 then
            Add(inalp,[j,Length(mat)-i+1]);
        fi;
    od;
od;

outalp:=[];
for x in [1..Length(inalp)] do
    if signs[1][inalp[x][1]] = 1 then
        if signs[2][inalp[x][2]] = 1 then
            Append(outalp,[[3*inalp[x][1]-2,3*inalp[x][2]-2],
                           [3*inalp[x][1]-1,3*inalp[x][2]-1],
                           [3*inalp[x][1],3*inalp[x][2]]]);
        else
            Append(outalp,[[3*inalp[x][1]-2,3*inalp[x][2]],
                           [3*inalp[x][1]-1,3*inalp[x][2]-1],
                           [3*inalp[x][1],3*inalp[x][2]-2]]);
        fi;
    else
        if signs[2][inalp[x][2]] = 1 then
            Append(outalp,[[3*inalp[x][1],3*inalp[x][2]-2],
                           [3*inalp[x][1]-1,3*inalp[x][2]-1],
                           [3*inalp[x][1]-2,3*inalp[x][2]]]);
        else
            Append(outalp,[[3*inalp[x][1],3*inalp[x][2]],
                           [3*inalp[x][1]-1,3*inalp[x][2]-1],
                           [3*inalp[x][1]-2,3*inalp[x][2]-2]]);
        fi;
    fi;
od;

###
### We are not using GridAlphabetConvention on the out alphabet because
### we need it here in the specific order of insertion according to the
### matrix row and column signs.
###
count:=1;
for y in [3*Length(mat), 3*Length(mat)-1..1] do
    for x in [1..3*Length(mat[1])] do
        if [x,y] in outalp then
            outalp[Position(outalp,[x,y])] := count;
            count:=count+1;
        fi;
    od;
od;

inalp:=GridAlphabet(mat);

trans:=[];
for x in [1..Length(inalp)] do
    for y in [1..3] do
        to:=y+3*x-2;
        for from in [1..Length(outalp)+1] do
            if from <= to or from > 1+3*x then
                Add(trans,[inalp[x],outalp[to-1],from,to]);
            fi;
       od;
    od;
od;

return Transducer(Length(outalp)+1,1,trans,[1..Length(outalp)+1]);

end );

################################################################################
##
#F x3ToOffSetMat(matrixwithcolumnrowsigns)
##
## Takes the x3 matrix with row and column signs and returns the one point
## extension matrix, which allows for points to lie off the diagonal.
##
InstallGlobalFunction(x3ToOffSetMat, function(matcr)
local mat,resmat,i,j,col,row;

mat:=matcr[1];

resmat:=NullMat(Length(mat)*5/3,Length(mat[1])*5/3);

for i in [1..Length(mat)] do
    for j in [1..Length(mat[1])] do
        if not(mat[i][j] = 0) then
            if i mod 3 = 0 then
                if j mod 3 = 0 then
                    resmat[5*(i/3)][5*(j/3)]:=mat[i][j];
                elif j mod 3 = 1 then
                    resmat[5*(i/3)][1+5*((j-1)/3)]:=mat[i][j];
                else
                    resmat[5*(i/3)][3+5*((j-2)/3)]:=mat[i][j];
                fi;
            elif i mod 3 = 1 then
                if j mod 3 = 0 then
                    resmat[1+5*((i-1)/3)][5*(j/3)]:=mat[i][j];
                elif j mod 3 = 1 then
                    resmat[1+5*((i-1)/3)][1+5*((j-1)/3)]:=mat[i][j];
                else
                    resmat[1+5*((i-1)/3)][3+5*((j-2)/3)]:=mat[i][j];
                fi;
            else
                if j mod 3 = 0 then
                    resmat[3+5*((i-2)/3)][5*(j/3)]:=mat[i][j];
                elif j mod 3 = 1 then
                    resmat[3+5*((i-2)/3)][1+5*((j-1)/3)]:=mat[i][j];
                else
                    resmat[3+5*((i-2)/3)][3+5*((j-2)/3)]:=mat[i][j];
                fi;
            fi;
        fi;
    od;
od;

for i in [2,5..Length(mat)-1] do
    for j in [2,5..Length(mat[1])-1] do
        if mat[i][j] = 1 then
            resmat[2+5*((i-2)/3)][2+5*((j-2)/3)]:=1;
            resmat[4+5*((i-2)/3)][4+5*((j-2)/3)]:=1;
        elif mat[i][j] = -1 then
            resmat[2+5*((i-2)/3)][4+5*((j-2)/3)]:=1;
            resmat[4+5*((i-2)/3)][2+5*((j-2)/3)]:=1;
        else
            resmat[2+5*((i-2)/3)][2+5*((j-2)/3)]:=1;
            resmat[4+5*((i-2)/3)][4+5*((j-2)/3)]:=1;
            resmat[2+5*((i-2)/3)][4+5*((j-2)/3)]:=1;
            resmat[4+5*((i-2)/3)][2+5*((j-2)/3)]:=1;
        fi;
    od;
od;

col:=ShallowCopy(matcr[2]);
for i in [1..Length(resmat[1])] do
    if i mod 5 in [2,4] then
        Add(col,1,i);
    fi;
od;

row:=ShallowCopy(matcr[3]);
for j in [1..Length(resmat)] do
    if j mod 5 in [2,4] then
        Add(row,1,j);
    fi;
od;

return [resmat,col,row];

end );

################################################################################
##
#F  MatrixUnion(mats)
##
## Takes the input list of matrices mats and concatenates these matrices into
## a larger matrix that contains mats on its diagonal.
##
InstallGlobalFunction(MatrixUnion, function(args)
local res,tmp,i,j,sumdims,dims;

dims:=[];

for i in [1..Length(args)] do
    Add(dims, DimensionsMat(args[i]));
od;

sumdims:=[];
for i in [1..Length(dims)] do
    Add(sumdims,[Sum(dims{[1..i]}[1]),Sum(dims{[1..i]}[2])]);
od;

res:=NullMat(sumdims[Length(sumdims)][1],sumdims[Length(sumdims)][2]);

for i in [1..Length(args)] do
    if not(Length(args[i])=0) then
        res{[sumdims[-i][1]-dims[i][1]+1..sumdims[-i][1]]}{[(sumdims[i][2]-dims[i][2]+1)..sumdims[i][2]]}:=args[i];
    fi;
od;

return res;

end );

################################################################################
##
#F  Find22Mats(mat)
##
## Inspects all 2x2 blocks in the matrix mat if a [[0,1],[1,0]] is seen then
## in the returned matrix a 1 is written, for [[-1,0],[0,-1]] there is a -1, if
## [[0,0],[0,0]] then 0 else we write 9.
##
InstallGlobalFunction(Find22Mats, function(mat)
local searchmats,markedmat,i,j,tmp;

searchmats:=[ [[0,1],[1,0]] , [[-1,0],[0,-1]] , [[0,0],[0,0]] ];
markedmat:=[];

for i in [1..Length(mat)-1] do
    tmp:=[];
    for j in [1..Length(mat[1])-1] do
        if mat{[i..i+1]}{[j..j+1]} = searchmats[1] then
            Add(tmp,1);
        elif mat{[i..i+1]}{[j..j+1]} = searchmats[2] then
            Add(tmp,-1);
        elif mat{[i..i+1]}{[j..j+1]} = searchmats[3] then
            Add(tmp,0);
        else
            Add(tmp,9);
        fi;
    od;
    Add(markedmat,tmp);
od;

Add(markedmat,ListWithIdenticalEntries(Length(markedmat[1]),0));
for i in [1..Length(markedmat)] do
    Add(markedmat[i],0);
od;

markedmat[Length(markedmat)][Length(markedmat[1])] := 9;

return markedmat;
end );

################################################################################
##
#F  CheckMarkedMat(mat)
##
## CheckMarkedMat goes through the marked matrix returned by Find22Mats and
## notes which rows and columns do not contain consecutive 9's, only 0's & 9's
## and whether there is an entry on a row or column that could interfere with
## the collapsing of the 2x2 blocks.
##
InstallGlobalFunction(CheckMarkedMat, function(mat)
local tmp,i,j,check,res;

res:=[];

tmp:=[];
for i in [1..Length(mat)] do
    check:=true;
    for j in [1..Length(mat[1])-1] do
        if mat[i][j] = 9 and mat[i][j+1] = 9 then
            check:=false;
        fi;
    od;
    Add(tmp,check);
od;

Add(res,tmp);

tmp:=[];
for j in [1..Length(mat[1])] do
    check:=true;
    for i in [1..Length(mat)-1] do
        if mat[i][j] = 9 and mat[i+1][j] = 9 then
            check:=false;
        fi;
    od;
    Add(tmp,check);
od;
Add(res,tmp);

for i in [1..Length(mat)] do
    if res[1][i] and not(1 in mat[i] or -1 in mat[i]) and (9 in mat[i]) then
        res[1][i] := false;
    fi;
od;

for j in [1..Length(mat[1])] do
    if res[2][j] and not(1 in mat{[1..Length(mat)]}[j] or
            -1 in mat{[1..Length(mat)]}[j]) and (9 in mat{[1..Length(mat)]}[j]) then
        res[2][j] := false;
    fi;
od;

for i in [1..Length(mat)] do
    for j in [1..Length(mat[1])] do
        if mat[i][j] in [-1,1] and (not(res[1][i]) or not(res[2][j])) then
            res[1][i]:=false;
            res[2][j]:=false;
        fi;
    od;
od;

return res;
end );


################################################################################
##
#F  MatrixReduction(mat)
##
## MatrixReduction collapses 2x2 blocks with either 0's or other collapsable
## 2x2 on their cols and rows.
##
InstallGlobalFunction(MatrixReduction, function(mat)
local marked,checklist,newdims,res,tmp,i,j;

marked:=Find22Mats(mat);
checklist:=CheckMarkedMat(marked);

res:=StructuralCopy(mat);

for i in [Length(checklist[1]),Length(checklist[1])-1 .. 1] do
    if checklist[1][i] then
        Remove(marked,i+1);
        Remove(checklist[1],i+1);
        res[i]:=ListWithIdenticalEntries(Length(mat[1]),0);
        Remove(res,i+1);
    fi;
od;

for j in [Length(checklist[2]),Length(checklist[2])-1 .. 1] do
    if checklist[2][j] then
        Remove(checklist[2],j+1);
        res{[1..Length(res)]}{[j..j]}:=NullMat(Length(res),1);
        for i in [1..Length(marked)] do
            Remove(marked[i],j+1);
            Remove(res[i],j+1);
        od;
    fi;
od;

for i in [1..Length(checklist[1])] do
    if checklist[1][i] then
        for j in [1..Length(res[1])] do
            if marked[i][j] = 1 then
                res[i][j]:=1;
            elif marked[i][j] = -1 then
                res[i][j]:=-1;
            fi;
        od;
    fi;
od;
return res;
end );

################################################################################
##
#F  RemoveZeroColumnsRows(mat)
##
## RemoveZeroColumnsRows returns a matrix that contains no columns or rows with
## only 0 entries.
##
InstallGlobalFunction(RemoveZeroColumnsRows, function(mat)
local i,j,res,dims;

res:=StructuralCopy(mat);
dims:=[Length(res),Length(res[1])];
for i in [dims[1], dims[1]-1 .. 1 ] do
    if res[i] = ListWithIdenticalEntries(dims[2],0) then
        Remove(res,i);
    fi;
od;

dims:=[Length(res),Length(res[1])];
for j in [dims[2], dims[2]-1 .. 1] do
    if Flat(res{[1..dims[1]]}[j]) = ListWithIdenticalEntries(dims[1],0) then
        for i in [1..dims[1]] do
            Remove(res[i],j);
        od;
    fi;
od;


return res;

end );
################################################################################
##
#F  mover(grid,max)
##
## Helper function to move (increment) the grid lines by one.
##
InstallGlobalFunction(mover, function(list,max)
local n,ind;

n:=Length(list);
if list[n] = max then
    ind:=Position(list,max);
    if ind = 1 then
        return list;
    else
        list[ind-1]:=list[ind-1]+1;
        list{[ind..n]} := ListWithIdenticalEntries(n+1-ind,list[ind-1]);
    fi;
else
    list[n]:=list[n]+1;
fi;

return list;
end );

################################################################################
##
#F  IsInCell(perm,cell,cellval)
##
## Helper checker for a specific cell, where we are checking whether perm has
## values within the cell boundaries and whether these values are in the correct
## monotonicity, based on cellval.
##
InstallGlobalFunction(IsInCell, function(perm,cell,cellval)
local a,b,c,d,status,i;

a:=cell[1][1];
b:=cell[1][2];
c:=cell[2][1];
d:=cell[2][2];

status:=0;
#if a=b then
#    return true;
#fi;
for i in [a..b-1] do
    if c <= perm[i] and perm[i] < d then
        if status = 0 then
            status:=1;
            last:=perm[i];
        elif status = 1 then
            if perm[i] > last then
                status:=2;
                last:=perm[i];
            else
                status:=-2;
                last:=perm[i];
            fi;
        elif status = 2 then
            if perm[i] > last then
                last:=perm[i];
            else
                return false;
            fi;
        elif status = -2 then
            if perm[i] < last then
                last:=perm[i];
            else
                return false;
            fi;
        fi;
    fi;
od;

if (status = 1 and not(cellval = 0)) or
   (status / 2 = cellval) or
   (status = 0 and not(cellval=0)) then
    return true;
else
    return false;
fi;

end );

################################################################################
##
#F  IsInGrid(perm,grid,mat)
##
## Checks whether perm is griddable by a specific grid, with mat indicating the
## monotonicity in the cells.
##
InstallGlobalFunction(IsInGrid, function(perm,grid,mat)
local i,j,tmp;

tmp:=StructuralCopy(grid);

Add(tmp[1],1,1);
Add(tmp[1],Maximum(perm)+1);
Add(tmp[2],1,1);
Add(tmp[2],Maximum(perm)+1);


for i in [1..Length(tmp[1])-1] do
    for j in [1..Length(tmp[2])-1] do
        if not(IsInCell(perm,[[tmp[1][i],tmp[1][i+1]],[tmp[2][j],tmp[2][j+1]]],
           mat[-j][i])) then
            return false;
        fi;
    od;
od;

return true;

end );

################################################################################
##
#F  IsGriddable(perm,mat)
##
## Checkes whether a specific permutation perm is griddable by mat. This is based
## at the moment on a brute-force algorithm that goes through all possible
## griddings until a gridding is found.
##
InstallGlobalFunction(IsGriddable, function(perm,mat)
local hori,vert,max,res;

hori:=ListWithIdenticalEntries(Length(mat)-1,1);
max:=Maximum(perm)+1;
res:=false;
while not(res) and not(hori = ListWithIdenticalEntries(Length(hori),max)) do
    vert:=ListWithIdenticalEntries(Length(mat[1])-1,1);
    res:=IsInGrid(perm,[vert,hori],mat);
    while not(res) and not(vert = ListWithIdenticalEntries(Length(vert),max)) do
        mover(vert,max);
        res:=IsInGrid(perm,[vert,hori],mat);
    od;
    mover(hori,max);
od;

#res:=IsInGrid(perm,[vert,hori],mat);

return res;

end );

################################################################################
##
#F  BoundedGridPerms(mat,n)
##
## Outputs all permutations, of length n, gridded by mat. Currently brute-force
## algorithm, producing all permutations of length n. Checking all whether they
## are griddable by mat and then returns only the permutations that are.
##
InstallGlobalFunction(BoundedGridPerms, function(mat,n)
local list,bool;

list:=List(Elements(SymmetricGroup(n)), i -> ListPerm(i,n));

bool:=List(list, i -> IsGriddable(i,mat));
#a:=Positions(bool,true);
#qPrint(list,"\n");

return list{Positions(bool,true)};

end );

################################################################################
##
#F Griddings
##
## Returns all possible griddings (in form of gridline coordinates) of perm
## in mat.
InstallGlobalFunction(Griddings, function(perm,mat)
local hori,vert,max,grids,a,b;

hori:=ListWithIdenticalEntries(Length(mat)-1,1);
max:=Maximum(perm)+1;
grids:=[];

while not(hori = ListWithIdenticalEntries(Length(hori),max)) do
    vert:=ListWithIdenticalEntries(Length(mat[1])-1,1);
    if IsInGrid(perm,[vert,hori],mat) then
        a:=ShallowCopy(vert);
        b:=ShallowCopy(hori);
        Add(grids,[a,b]);
    fi;
    while not(vert = ListWithIdenticalEntries(Length(vert),max)) do
        mover(vert,max);
        if IsInGrid(perm,[vert,hori],mat) then
            a:=ShallowCopy(vert);
            b:=ShallowCopy(hori);
            Add(grids,[a,b]);
        fi;
    od;
    mover(hori,max);
od;


return grids;

end );
