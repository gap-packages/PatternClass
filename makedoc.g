#
# PatternClass: A permutation pattern class package
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc", "2016.02.16") then
    Error("AutoDoc version 2016.02.16 or newer is required.");
fi;
AutoDoc( rec(
    autodoc := true,
    gapdoc := rec(
        LaTeXOptions := rec(
            EarlyExtraPreamble := """
                \usepackage{graphicx}
                \usepackage{float}
                """,
        ),
    ),
    scaffold := rec(
        includes := [
            "intro.xml",
            "tpn.xml",
            "encoding.xml",
            "tpntoaut.xml",
            "auttotpn.xml",
            "classandbase.xml",
            "basics.xml",
            "props.xml",
            "langs.xml",
            "tmp.xml",
        ],
        bib := "bibliography.bib",
    ),
) );
