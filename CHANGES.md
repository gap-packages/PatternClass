This file describes changes in the PatternClass package.

## 2.4.5 (2024-08-30)

- Janitorial changes

## 2.4.4 (2024-08-28)

- Update CI, and use latest GAP functionality.

## 2.4.3 (2022-10-17)

- Fix `InversionAutOfClass` failing when the given automaton has a larger
  alphabet than the inversion automaton

## 2.4.2 (2018-07-24)

- Changed the name of HashSet due to clash with DataStructure Package
- Removed TODOs from code

## 2.4.1 (2017-09-28)

## 2.4 (2017-08-11)

- Improved the runtime of InbetweenPermSet when the subpermutation is of length 1.
- Added IsSumPerm function
- Fixed&merged issues

## 2.3 (2017-07-05)

- Added functions to create the language and set of permutations contained between two permutations.

## 2.2 (2015-12-04)

- Updated the way testing is being done in preparation for GAP4.8.

## 2.1 (2015-08-27)

- Removed all unnecessary files from the archive.
- Fixed PackageInfo, such that no warnings are thrown.

## 2.0 (2015-08-27)

- Package is now being hosted on GitHub!
- Updated maintainers details
- Changed version numbering to a simpler system.

## 1.1235813213455 (2015-08-27)

- Fixed up PackageInfo.g for submission to GAP distribution.

## 1.12358132134 (2015-04-29)

## 1.123581321

- Fixed up some small editorial faults (copyright, authors etc.)

## 1.1235813

- Cleaned up some code.
- Moved the alternative automaton theoretic functions into their own file
- Introduced tests for the pkg

## 1.12358

- Fixed issues with the experimental code from lib/grid by not loading the code
  automatically. At their own discretion.

## 1.1235

- The undocumented functions for chains of simple permutations are now documented.
- The experimental code on grid classes is moved into a separate folder, these
  functions are undocumented.
- Patched code for Automata functions UnionAutomata, IntersectionAutomaton and
  ProductOfLanguages has been added.
- Some code has been changed to use the patched functions, and general code
  cleaning has been done in places.

## 1.123

- Functions for the regular language of simple permutations have been added.
- Fix of SequencesToRatExp, there was an issue when the alphabet exceeded 9 letters.
- Undocumented functions for chains of simple permutations have been added.

## 1.12

- The following functions have been added:
   * IsInterval - Checker whether the input sequence is an interval.
   * Inflation - Returns a permutation that is represented by the
      input list of permutations.
   * Block-Decomposition - Returns the unique (for some permutations)
      list of permutations representing the input permutation in a
      truncated format.

## 1.1

- Improvement in BoundedClassAutomaton
- Additional functions checking whether a permutation is
   * plus-decomposable
   * minus-decomposable
   * simple
- Functions to build the rational subsets of a class accepting
  all plus- (minus-) decomposable permutations (also indecomposable
  permutations)
- Functions to check whether the input list is
   * a valid rank encoding
   * a rank encoding stemming from the input class
- A function calculating the complement of a permutation
- Functions to calculate the direct sum or the skew sum of 2 permutations
- A function calculating the direct sum for 2 rational pattern classes
- A function to build the automaton that accepts all permutations under the
  rank encoding that have the same number of inversions.
- A function that builds the subclass containing all permutations with the
  same number of inversions in the class.
