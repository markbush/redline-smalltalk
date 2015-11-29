"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #ArrayedCollectionTest.

- test
    self testSize.
    self testWith.
    self testIncludes.
    self testEmpty.
    self testOccurrencesOf.
    self testDo.
    self testSelect.
    self testCollect.
    self testReject.
    self testDetect.
    self testDetectIfNone.
    self testInjectInto.
    self testPrintString.
    self testFirst.
    self testReplaceFromToWithStartingAt.
    self testConcatenation.
    self testCopyFromTo.
    self testCopyReplaceFromToWith.
    self testGrownBy.
    "self testAsBag."
    "self testAsSet."
    self testAsOrderedCollection.
    "self testAsSortedCollection."
    "self testAsSortedCollectionWithSortBlock."

- testSize
    | array |
    array := #().
    self assert: array size equals: 0 withMessage: 'should have size 0'.
    array := #(1 3 5 7 9).
    self assert: array size equals: 5 withMessage: 'should have size 5'.
    array := Array new: 12.
    self assert: array size equals: 12 withMessage: 'should have size 12'.

- testWith
    | array |
    array := Array with: $a.
    self assert: array size equals: 1 withMessage: 'should have size 1'.
    self assert: array equals: #($a) withMessage: 'should construct correct 1 element array'.
    array := Array with: $a with: $b.
    self assert: array size equals: 2 withMessage: 'should have size 2'.
    self assert: array equals: #($a $b) withMessage: 'should construct correct 2 element array'.
    array := Array with: $a with: $b with: $c.
    self assert: array size equals: 3 withMessage: 'should have size 3'.
    self assert: array equals: #($a $b $c) withMessage: 'should construct correct 3 element array'.
    array := Array with: $a with: $b with: $c with: $d.
    self assert: array size equals: 4 withMessage: 'should have size 4'.
    self assert: array equals: #($a $b $c $d) withMessage: 'should construct correct 4 element array'.

- testIncludes
    | array |
    array := #().
    self assertFalse: (array includes: 1) withMessage: 'should not include an element'.
    array := #(1 3 5 7 9).
    self assertTrue: (array includes: 1) withMessage: 'should include an element'.
    array := Array with: $a.
    self assertTrue: (array includes: $a) withMessage: 'should include an element'.

- testEmpty
    | array |
    array := #().
    self assertTrue: array isEmpty withMessage: 'should be empty'.
    array := #(1 2 3).
    self assertFalse: array isEmpty withMessage: 'should not be empty'.

- testOccurrencesOf
    | array |
    array := #().
    self assert: (array occurrencesOf: 1) equals: 0 withMessage: 'should have no occurrences'.
    array := #(1 3 5 7 9).
    self assert: (array occurrencesOf: 1) equals: 1 withMessage: 'should have 1 occurrence'.
    array := #(1 4 1 7 9 1).
    self assert: (array occurrencesOf: 1) equals: 3 withMessage: 'should have 3 occurrences'.

- testDo
    | array result |
    array := #().
    result := 0.
    array do: [ :each | result := result + 1 ].
    self assert: result equals: 0 withMessage: 'should perform 0 times for empty array'.
    array := #(1 2 3).
    array do: [ :each | result := result + 1 ].
    self assert: result equals: 3 withMessage: 'should perform 3 times for empty array'.
    result := 0.
    array do: [ :each | result := result + each ].
    self assert: result equals: 6 withMessage: 'should access each element in array'.

- testSelect
    | array result |
    array := #().
    result := array select: [ :each | #($a $e $i $o $u) includes: each ].
    self assert: result class equals: Array withMessage: 'should produce an Array'.
    self assert: result equals: #() withMessage: 'should produce an empty Array'.
    array := #($h $e $l $l $o $  $w $o $r $l $d).
    result := array select: [ :each | #($a $e $i $o $u) includes: each ].
    self assert: result equals: #($e $o $o) withMessage: 'should produce an Array with 3 elements'.

- testCollect
    | array result |
    array := #().
    result := array collect: [ :each | each * each ].
    self assert: result class equals: Array withMessage: 'should produce an Array'.
    self assert: result equals: #() withMessage: 'should produce an empty Array'.
    array := #(1 2 3 4 5).
    result := array collect: [ :each | each * each ].
    self assert: result equals: #(1 4 9 16 25) withMessage: 'should produce an Array of squares'.

- testReject
    | array result |
    array := #().
    result := array reject: [ :each | #($a $e $i $o $u) includes: each ].
    self assert: result class equals: Array withMessage: 'should produce an Array'.
    self assert: result equals: #() withMessage: 'should produce an empty Array'.
    array := #($h $e $l $l $o $  $w $o $r $l $d).
    result := array reject: [ :each | #($a $e $i $o $u) includes: each ].
    self assert: result equals: #($h $l $l $  $w $r $l $d) withMessage: 'should produce an Array with 8 elements'.

- testDetect
    | array result |
    array := #(1 7 3 24 6 2 14).
    result := array detect: [ :each | each > 10 ].
    self assert: result equals: 24 withMessage: 'should find first element satisfying the condition'.

- testDetectIfNone
    | array result |
    array := #(1 7 3 24 6 2 14).
    result := array detect: [ :each | each > 10 ] ifNone: [ -1 ].
    self assert: result equals: 24 withMessage: 'should find first element satisfying the condition'.
    array := #(1 7 3 24 6 2 14).
    result := array detect: [ :each | each > 30 ] ifNone: [ -1 ].
    self assert: result equals: -1 withMessage: 'should return alternate value if none satisfy condition'.

- testInjectInto
    | array result |
    array := #(1 2 3 4 5).
    result := array inject: 0 into: [ :sum :each | sum + each ].
    self assert: result equals: 15 withMessage: 'should sum over the array'.
    array := #(1 2 3 4 5).
    result := array inject: 1 into: [ :product :each | product * each ].
    self assert: result equals: 120 withMessage: 'should multiply over the array'.

- testPrintString
    | array result |
    array := #(1 2 3).
    result := array printString.
    self assert: result equals: 'Array (1 2 3 )' withMessage: 'should produce correct printed form for Array of numbers'.
    array := #($a $b $c).
    result := array printString.
    self assert: result equals: 'Array ($a $b $c )' withMessage: 'should produce correct printed form for Array of characters'.
    array := #('a' 'b' 'c').
    result := array printString.
    self assert: result equals: 'Array (''a'' ''b'' ''c'' )' withMessage: 'should produce correct printed form for Array of strings'.

- testFirst
    | array result |
    array := #(1 2 3).
    result := array first.
    self assert: result equals: 1 withMessage: 'should select the first element'.
    array := #($a $b $c).
    result := array first.
    self assert: result equals: $a withMessage: 'should select the first element'.

- testReplaceFromToWithStartingAt
    | array |
    array := #(1 2 3 4 5 6 7).
    array replaceFrom: 3 to: 5 with: #($a $b $c $d $e) startingAt: 1.
    self assert: array equals: #(1 2 $a $b $c 6 7) withMessage: 'should replace subsequence'.
    array := #(1 2 3 4 5 6 7).
    array replaceFrom: 2 to: 4 with: #($a $b $c $d $e) startingAt: 3.
    self assert: array equals: #(1 $c $d $e 5 6 7) withMessage: 'should replace subsequence with offset in replacement array'.

- testConcatenation
    | first second result |
    first := #(1 2 3).
    second := #($a $b $c).
    result := first , second.
    self assert: first equals: #(1 2 3) withMessage: 'should leave receiver unchanged'.
    self assert: second equals: #($a $b $c) withMessage: 'should leave argument unchanged'.
    self assert: result equals: #(1 2 3 $a $b $c) withMessage: 'should concatenate arrays.'.

- testCopyFromTo
    | array result |
    array := #(1 2 3 4 5).
    result := array copyFrom: 2 to: 4.
    self assert: array equals: #(1 2 3 4 5) withMessage: 'should leave receiver unchanged'.
    self assert: result equals: #(2 3 4) withMessage: 'should select subsequence'.

- testCopyReplaceFromToWith
    | array result replacement |
    array := #(1 2 3 4 5).
    replacement := #($a $b $c).
    result := array copyReplaceFrom: 1 to: 0 with: replacement.
    self assert: array equals: #(1 2 3 4 5) withMessage: 'should leave receiver unchanged'.
    self assert: replacement equals: #($a $b $c) withMessage: 'should leave replacement unchanged'.
    self assert: result equals: #($a $b $c 1 2 3 4 5) withMessage: 'should prepend when start = 1 and stop = 0'.
    result := array copyReplaceFrom: array size + 1 to: array size with: replacement.
    self assert: result equals: #(1 2 3 4 5 $a $b $c) withMessage: 'should append when start = size + 1 and stop = size'.
    result := array copyReplaceFrom: 2 to: 4 with: replacement.
    self assert: result equals: #(1 $a $b $c 5) withMessage: 'should replace elements otherwise'.

- testGrownBy
    | array result |
    array := #(1 2 3).
    result := array grownBy: 2.
    self assert: array equals: #(1 2 3) withMessage: 'should leave receiver unchanged'.
    self assert: result class equals: Array withMessage: 'should produce receivers species'.
    self assert: result size equals: 5 withMessage: 'should produce new array of appropriate size'.
    self assert: (result at: 1) equals: (array at: 1) withMessage: 'should preserve elements'.
    self assert: (result at: 2) equals: (array at: 2) withMessage: 'should preserve elements'.
    self assert: (result at: 3) equals: (array at: 3) withMessage: 'should preserve elements'.

- testAsBag

- testAsSet

- testAsOrderedCollection
    | array result |
    array := #(1 2 3).
    result := array asOrderedCollection.
    self assert: result class equals: OrderedCollection withMessage: 'should produce an OrderedCollection'.
    self assert: result size equals: array size withMessage: 'should return same sized collection'.
    self assert: (result at: 1) equals: (array at: 1) withMessage: 'should preserve elements'.
    self assert: (result at: 2) equals: (array at: 2) withMessage: 'should preserve elements'.
    self assert: (result at: 3) equals: (array at: 3) withMessage: 'should preserve elements'.

- testAsSortedCollection

- testAsSortedCollectionWithSortBlock
