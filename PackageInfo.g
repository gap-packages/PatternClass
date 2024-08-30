#
# PatternClass: A permutation pattern class package
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "PatternClass",
Subtitle := "A permutation pattern class package",
Version := "2.4.5",
Date := "30/08/2024", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Ruth",
    LastName := "Hoffmann",
    WWWHome := "https://www.st-andrews.ac.uk/computer-science/people/rh347/",
    Email := "rh347@st-andrews.ac.uk",
    PostalAddress := Concatenation(
               "School of Computer Science,\n",
               "University of St. Andrews,\n",
               "North Haugh,\n",
               "St. Andrews,\n",
               "Fife,\n",
               "KY16 9SS,\n",
               "SCOTLAND" ),
    Place := "St Andrews",
    Institution := "School of Computer Science, University of St Andrews",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Steve",
    LastName := "Linton",
    WWWHome := "http://sal.host.cs.st-andrews.ac.uk/",
    Email := "sl4@st-andrews.ac.uk",
    PostalAddress := Concatenation(
               "Steve Linton\n",
               "School of Computer Science,\n",
               "University of St. Andrews,\n",
               "North Haugh,\n",
               "St. Andrews,\n",
               "Fife,\n",
               "KY16 9SS,\n",
               "SCOTLAND" ),
    Place := "St Andrews",
    Institution := "School of Computer Science, University of St Andrews",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Michael",
    LastName := "Albert",
    WWWHome := "https://www.otago.ac.nz/computer-science/people/Michael_Albert.html",
    Email := "malbert@cs.otago.ac.nz",
    PostalAddress := Concatenation(
               "Michael Albert\n",
               "Department of Computer Science,\n",
               "University of Otago,\n",
               "PO Box 56,\n",
               "DUNEDIN 9054,\n",
               "New Zealand," ),
    Place := "Dunedin",
    Institution := "Department of Computer Science, University of Otago",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/gap-packages/", ~.PackageName ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://gap-packages.github.io/PatternClass/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "deposited",

AbstractHTML := "The PatternClass package is build on the idea of token passing networks building permutation pattern classes. Those classes are best determined by their basis. Both sets can be encoded by rank encoding their permutations. Each, the class and its basis, in their encoded form build a rational language. Rational languages can be easily computed by using automata, which also can be build directly from the token passing networks. Both ways will build the same language, i.e. the same automaton.",

PackageDoc := rec(
  BookName  := "PatternClass",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A permutation pattern class package",
),

Dependencies := rec(
  GAP := ">= 4.8",
  NeededOtherPackages := [ ["Automata", ">=1.13"], [ "GAPDoc", ">= 1.5" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [ "permutation", "pattern", "transducer", "regular language", "subpermutation" , "token passing network", "encoding" ],

));
