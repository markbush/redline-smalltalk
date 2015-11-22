"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #SequenceableCollectionTest.

- test
    self testEquals.
    self testReplaceFromToWithStartingAt.
    self testCopyReplaceFromToWith.
    self testConcatenation.

- testEquals
    | first second |
    first := #(1 2 3).
    second := #(1 2 3).
    self assertTrue: first = second withMessage: 'should be equal if elements are equal'.
    first := #(1 2 3).
    second := #(4 5 6).
    self assertFalse: first = second withMessage: 'should be not equal if elements are not equal'.
    first := #(1 2 3).
    second := #(1 2).
    self assertFalse: first = second withMessage: 'should be not equal if not the same length'.

- testReplaceFromToWithStartingAt
    | collection replacement result |
    collection := #(1 2 3 4 5 6).
    replacement := #(7 8 9).
    result := collection replaceFrom: 2 to: 4 with: replacement startingAt: 1.
    self assert: result equals: #(1 7 8 9 5 6) withMessage: 'should replace subsequence with all of replacement'.
    collection := #(1 2 3 4 5 6).
    replacement := #(7 8 9).
    result := collection replaceFrom: 5 to: 6 with: replacement startingAt: 1.
    self assert: result equals: #(1 2 3 4 7 8) withMessage: 'should replace subsequence as far as required'.

- testCopyReplaceFromToWith
    | collection replacement result |
    collection := #(1 2 3 4 5 6).
    replacement := #(7 8 9).
    result := collection copyReplaceFrom: 2 to: 4 with: replacement.
    self assert: result equals: #(1 7 8 9 5 6) withMessage: 'should replace subsequence'.
    self assert: collection equals: #(1 2 3 4 5 6) withMessage: 'should preserve receiver'.
    result := collection copyReplaceFrom: 1 to: 0 with: replacement.
    self assert: result equals: #(7 8 9 1 2 3 4 5 6) withMessage: 'should insert at beginning'.
    self assert: collection equals: #(1 2 3 4 5 6) withMessage: 'should preserve receiver'.
    result := collection copyReplaceFrom: 7 to: 6 with: replacement.
    self assert: result equals: #(1 2 3 4 5 6 7 8 9) withMessage: 'should append at end'.
    self assert: collection equals: #(1 2 3 4 5 6) withMessage: 'should preserve receiver'.

- testConcatenation
    | first second result |
    first := #(1 2 3).
    second := #(4 5 6).
    result := #(1 2 3 4 5 6).
    self assert: first , second equals: result withMessage: 'should concatenate Arrays'.
    self assert: first equals: #(1 2 3) withMessage: 'should preserve receiver'.
    self assert: second equals: #(4 5 6) withMessage: 'should preserve argument'.
