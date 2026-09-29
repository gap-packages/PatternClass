LoadPackage("graphvizforgap");

# hex:=[[2,3],[4],[5],[3,6],[6],[]];
# hex2:=[ [ 2, 6 ], [ 3, 9 ], [ 2, 4 ], [ 3, 5 ], [ 4 ], [ 7, 9 ], [ 6, 8 ], [ 7 ], [  ] ];
# tpn := tpn2dot(hex,"tpn");
# tpn2 := tpn2dot(hex2,"tpn2");

tpn2dot := function( tpn, name )
local f, innode, outnode, nodes, isin, n, m,i;
    f := GraphvizDigraph(name);
    GraphvizSetAttrs(f, rec(rankdir:="LR", size:="\"8,5\"", layout:="neato"));

    innode := GraphvizAddNode(f, "in");
    GraphvizSetAttr(innode, "shape", "none");
    GraphvizSetAttr(innode, "label", "\"\"");

    outnode := GraphvizAddNode(f, "out");
    GraphvizSetAttr(outnode, "shape", "none");
    GraphvizSetAttr(outnode, "label", "\"\"");

    nodes := GraphvizAddContext(f, "nodes");
    GraphvizSetAttr(nodes, "node [shape=circle]");

# THIS IS SUPER INEFFICIENT and only here because adding nodes after edges currently doesn't work
    for i in [1 .. Size(tpn)] do
        GraphvizAddNode(f,String(i));
    od;

    isin := [1 .. Size(tpn)];
    for n in [1 .. Size(tpn)] do
# Add this back in once issue has been resolved
#        GraphvizAddNode(nodes, String(n));
        if IsEmpty(tpn[n]) then
            GraphvizAddEdge(f, String(n), "out");
        else
            for m in tpn[n] do
                GraphvizAddEdge(f, String(n), String(m));
                if m in isin then
                    Remove(isin, Position(isin, m));
                fi;
            od;
        fi;
    od;
    for i in isin do
        GraphvizAddEdge(f, "in", String(i));
    od;
    return AsString(f);

end;


# trans := rec( accepting := [ 2 ], initial := 1, states := 3, 
#   transitions := [ [ 1, 2, 1, 2 ], [ 1, 2, 2, 2 ], [ 2, 2, 1, 3 ], 
#       [ 2, 2, 2, 3 ], [ 1, 1, 3, 3 ], [ 2, 2, 3, 3 ] ] );


# trans2 := rec( accepting := [ 1 .. 3 ], initial := 4, states := 4, 
#   transitions := [ [ 1, 1, 4, 4 ], [ 0, 1, 4, 1 ], [ 1, 2, 1, 1 ], 
#       [ 1, 1, 1, 2 ], [ 2, 3, 1, 1 ], [ 1, 1, 2, 3 ], [ 1, 1, 3, 3 ], 
#       [ 2, 2, 4, 4 ], [ 0, 2, 4, 2 ], [ 2, 3, 2, 2 ], [ 2, 2, 2, 3 ], 
#       [ 2, 2, 3, 3 ], [ 3, 3, 4, 4 ], [ 0, 3, 4, 3 ], [ 3, 3, 3, 3 ] ] );

transducer2dot := function(transducer, name)
    local f, accept, i, start, innode, startnode;
    f := GraphvizDigraph(name);
    GraphvizSetAttrs(f, rec(rankdir:="LR", size:="\"8,5\"", layout:="dot"));

    accept := GraphvizAddContext(f, "accept");
    GraphvizSetAttr(accept, "node [shape=doublecircle]");
    for i in transducer.accepting do
        GraphvizAddNode(accept, String(i));
    od;

    start := GraphvizAddContext(f,"start");
    innode := GraphvizAddNode(start, "in");
    GraphvizSetAttr(innode, "shape", "none");
    GraphvizSetAttr(innode, "label","\"\"");
    startnode := GraphvizAddNode(start, String(transducer.initial));
    GraphvizAddEdge(start, innode, startnode);

    for i in transducer.transitions do

        GraphvizSetAttr(GraphvizAddEdge(f, String(i[3]), String(i[4])), "label", Concatenation("\"", String(i[1]), "|", String(i[2]), "\""));
    od;
    return AsString(f);
end;

# Splash(transducer2dot(trans,"trans"));
# Splash(transducer2dot(trans2,"trans2"));
# # Display(transducer2dot(trans2,"trans2"));