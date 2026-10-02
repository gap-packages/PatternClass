[![CI](https://github.com/gap-packages/PatternClass/actions/workflows/CI.yml/badge.svg)](https://github.com/gap-packages/PatternClass/actions/workflows/CI.yml)
[![Code Coverage](https://codecov.io/github/gap-packages/PatternClass/coverage.svg?branch=master&token=)](https://codecov.io/gh/gap-packages/PatternClass)

The 'PatternClass' GAP 4 package
================================

Introduction
------------

The 'PatternClass' package allows you to explore the permutation
pattern classes build by token passing networks.
Amongst other things, 'PatternClass' can compute the basis of a
permutation pattern class et vice versa, rank encode and decode permutations,
create automata from token passing networks and checking if the
deterministic automaton is a possible representative of a
token passing network.
More details on what functions "PatternClass' contains, consult
the manual in the doc folder.

If there are any problems with the package please do not hesitate to contact us.

Michael Albert	 <malbert@cs.otago.ac.nz>
Steve Linton 	 <sl4@st-andrews.ac.uk>
Ruth Hoffmann	 <rh347@icloud.com> (Current maintainer)


Contents
--------

This package comes with the following files and directories

    doc             the directory with the manual
    init.g          this file does initialise the package
    lib             this directory contains all GAP code
    lib/grid        this directory contains experimental code which is not preloaded
                    see README in lib/grid for info
    PackageInfo.g   the information file for automatic processing
    read.g          this file reads the package
    README          you are currently reading this file

Unpacking and Installing 'PatternClass'
---------------------------------------

If you get 'PatternClass' as a compressed file unpack it in the pkg/ folder
in the gap4r4 folder where GAP is installed on your computer.
To uncompress the .tar.gz file on UNIX use the following command

   tar xzf PatternClass2.4.2.tar.gz

If your version of tar does not support the z option use

   gunzip PatternClass2.4.2.tar.gz
   tar xf PatternClass2.4.2.tar

This will create the folder PatternClass in pkg/ and within that
you will find the directories and files mentioned above.

To use the package within GAP, run GAP and type the following

gap> LoadPackage("patternclass");
----------------------------------------------------------------
Loading  Automata 1.13
For help, type: ?Automata:
----------------------------------------------------------------
─────────────────────────────────────────────────────────────────────────────
Loading  PatternClass 2.4.2 (A permutation pattern class package)
by Ruth Hoffmann (https://rh347.host.cs.st-andrews.ac.uk/),
   Steve Linton (http://sal.host.cs.st-andrews.ac.uk/), and
   Michael Albert (http://www.cs.otago.ac.nz/staff/michael.html).
Homepage: https://gap-packages.github.io/PatternClass/
─────────────────────────────────────────────────────────────────────────────
true
gap>

Now you can use all functions of 'PatternClass' within this session
of GAP. As described in the manual, found in the doc directory or
online or within GAP help.



Changes
-------

See [CHANGES.md](CHANGES.md).
