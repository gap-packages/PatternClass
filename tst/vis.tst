#############################################################################
##
#A  vis.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> hex:=[[2,3],[4],[5],[3,6],[6],[]];;
gap> tpn2dot(hex,"tpn");
"//dot\ndigraph tpn {\n\tsize=\"8,5\" rankdir=LR layout=neato \n\tin [label=\"\", shape=none]\n\tout [label=\"\", shape=none]\n// nodes context \n{\n\tnode [shape=\
circle] \n}\n\t1\n\t2\n\t3\n\t4\n\t5\n\t6\n\t1 -> 2\n\t1 -> 3\n\t2 -> 4\n\t3 -> 5\n\t4 -> 3\n\t4 -> 6\n\t5 -> 6\n\t6 -> out\n\tin -> 1\n}\n"
gap> 