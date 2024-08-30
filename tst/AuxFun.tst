#############################################################################
##
#A  AuxFun.tst            PatternClass package                 Ruth Hoffmann
##
gap> START_TEST("PatternClass");
gap> LoadPackage("patternclass",false);
true
gap> SetAssertionLevel(1);
gap> a1:=RationalExpression("(bUcUd)*ab*");
(bUcUd)*ab*
gap> a2:=RationalExpression("(acUd)*(aU@)");
(acUd)*(aU@)
gap> NDIntersectionAutomaton(a1,a2);
Error, The arguments must be two automata over the same alphabet
gap> a2:=RationalExpression("(acUd)*(aUb)");
(acUd)*(aUb)
gap> NDIntersectionAutomaton(a1,a2);
< epsilon automaton on 5 letters with 9 states >
gap> NDUnionAutomata(a1,a2);
Error, The arguments must be two automata
gap> a1:=RatExpToAut(RationalExpression("(bUcU@)*ab*"));
< deterministic automaton on 3 letters with 3 states >
gap> a2:=RatExpToAut(RationalExpression("(acUd)*(@Ub)"));
< deterministic automaton on 4 letters with 4 states >
gap> NDUnionAutomata(a1,a2);
Error, The arguments must be two automata over the same alphabet
gap> a1:=RatExpToAut(RationalExpression("(bUcUdU@)*ab*"));
< deterministic automaton on 4 letters with 3 states >
gap> a2:=RatExpToAut(RationalExpression("(acUd)*(@Ub)"));
< deterministic automaton on 4 letters with 4 states >
gap> NDProductOfLanguages(a1,a2);
< epsilon automaton on 5 letters with 7 states >
gap> a1:=RatExpToAut(RationalExpression("(bUcU@)*ab*"));
< deterministic automaton on 3 letters with 3 states >
gap> a2:=RatExpToAut(RationalExpression("(acUd)*(@Ub)"));
< deterministic automaton on 4 letters with 4 states >
gap> NDUnionAutomata(a1,a2);
Error, The arguments must be two automata over the same alphabet
gap> STOP_TEST( "AuxFun.tst", 10000 );
