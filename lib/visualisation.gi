#############################################################################
##
##
#W  visualisation.gi			    Ruth Hoffmann
##
#Y  Copyright (C) 2026      School of Computer Science, 
#Y                          University of St. Andrews, North Haugh,
#Y                          St. Andrews, Fife KY16 9SS, Scotland
##


#############################################################################
##
#F  TPN2dot( tpn, name )
##
##  Returns a String containing dot syntax for the visualisation of the 
##  Token Passing Network visualised, and named name.
##
InstallGlobalFunction(TPN2dot, function( tpn, name )
    local f, innode, outnode, nodes, isin, n, m,i;
    f := GraphvizDigraph(name);
    GraphvizSetAttrs(f, rec(rankdir:="LR", layout:="neato"));
    GraphvizSetAttr(f, "node [shape = circle]");

    innode := GraphvizAddNode(f, "in");
    GraphvizSetAttr(innode, "shape", "none");
    GraphvizSetAttr(innode, "label", "\"\"");

    outnode := GraphvizAddNode(f, "out");
    GraphvizSetAttr(outnode, "shape", "none");
    GraphvizSetAttr(outnode, "label", "\"\"");

    isin := [1 .. Size(tpn)];
    for n in [1 .. Size(tpn)] do
        GraphvizSetAttr(GraphvizAddNode(f, String(n)), "shape", "circle") ;
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
end);

#############################################################################
##
#F  Transducer2dot( Transducer, name )
##
##  Returns a String containing dot syntax for the visualisation of the 
##  transducer, and named name.
##
InstallGlobalFunction(Transducer2dot, function(transducer, name)
    local f, accept, i, start, innode, startnode;
    f := GraphvizDigraph(name);
    GraphvizSetAttrs(f, rec(rankdir:="LR", layout:="dot"));
    GraphvizSetAttr(f, "node [shape = circle]");

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
end);