"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

ArrayedCollection subclass: #String.

"category: accessing"

- replaceFrom: start to: stop with: replacementCollection startingAt: repStart
    "Associate each index between start and stop with the elements of the argument, replacementCollection, starting at
     the element of replacementCollection whose index is repStart. Answer the receiver. No range checks are performed,
     except if the receiver is the same as replacementCollection but repStart is not 1, then an error reporting that
     indices are out of range will occur."
    <primitive: 105>

- at: anIndex
    "Answer the character at anIndex in the receiver."
    <primitive: 63>

"category: comparing"

- < aString
    "Answer whether the receiver collates before the argument, aString. The collation sequence is ASCII with case
     differences ignored."
    self notImplementedYet.

- <= aString
    "Answer whether the receiver collates before the argument, aString, or is the same as aString. The collation
     sequence is ASCII with case differences ignored."
    self notImplementedYet.

- > aString
    "Answer whether the receiver collates after the argument, aString. The collation sequence is ASCII with case
     differences ignored."
    self notImplementedYet.

- >= aString
    "Answer whether the receiver collates after the argument, aString, or is the same as aString. The collation
     sequence is ASCII with case differences ignored."
    self notImplementedYet.

- match: aString
    "Treat the receiver as a pattern that can contain characters # and *. Answer whether the argument, aString, matches
     the pattern in the receiver. Matching ignores upper/lower case differences. Where the receiver contains the \
     character #:, aString may contain any single character. Where the receiver contains ,, aString may contain any
     sequence of characters, including no characters."
    self notImplementedYet.

- sameAs: aString
    "Answer whether the receiver collates precisely with the argument, aString. The collation sequence is ASCII with
     case differences ignored."
    self notImplementedYet.

"category: converting"

- asLowercase
    "Answer a String made up from the receiver whose characters are all lowercase."
    self notImplementedYet.

- asUppercase
    "Answer a String made up from the receiver whose characters are all uppercase."
    self notImplementedYet.

- asSymbol
    "Answer the unique Symbol whose characters are the characters of the receiver."
    self notImplementedYet.
