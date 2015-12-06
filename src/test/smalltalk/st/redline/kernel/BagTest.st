"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #BagTest.

- test
    self testAdd.
    self testAddWithOccurrences.
    self testRemove.
    self testDo.
    self testIncludes.
    self testOccurrencesOf.

- testAdd
    | aBag |
    aBag := Bag new.
    self assert: aBag size equals: 0 withMessage: 'should initially have size 0'.
    aBag add: $a.
    self assert: aBag size equals: 1 withMessage: 'should have size 1 after adding an item'.
    aBag add: $a.
    self assert: aBag size equals: 2 withMessage: 'should have size 2 after adding another item'.
    aBag add: $b.
    self assert: aBag size equals: 3 withMessage: 'should have size 3 after adding another item'.

- testAddWithOccurrences
    | aBag |
    aBag := Bag new.
    aBag add: $a withOccurrences: 5.
    self assert: aBag size equals: 5 withMessage: 'should have size 5 after adding 5 occurrences'.
    aBag add: $b withOccurrences: 3.
    self assert: aBag size equals: 8 withMessage: 'should have size 8 after adding 3 more occurrences'.
    aBag add: $b withOccurrences: 3.
    self assert: aBag size equals: 11 withMessage: 'should have size 11 after adding 3 more occurrences'.

- testRemove
    | aBag |
    aBag := Bag new.
    aBag add: $a withOccurrences: 2.
    self assert: aBag size equals: 2 withMessage: 'should have size 2 after adding 2 occurrences'.
    aBag add: $b withOccurrences: 2.
    self assert: aBag size equals: 4 withMessage: 'should have size 4 after adding 2 more occurrences'.
    aBag remove: $a.
    self assert: aBag size equals: 3 withMessage: 'should have size 3 after removing 1 occurrence'.
    aBag remove: $b.
    self assert: aBag size equals: 2 withMessage: 'should have size 2 after removing 1 occurrence'.
    aBag remove: $a.
    self assert: aBag size equals: 1 withMessage: 'should have size 1 after removing 1 occurrence'.
    aBag remove: $b.
    self assert: aBag size equals: 0 withMessage: 'should have size 0 after removing final occurrence'.

- testDo
    | aBag result |
    aBag := Bag new.
    aBag add: 1 withOccurrences: 2.
    aBag add: 2 withOccurrences: 6.
    aBag add: 3 withOccurrences: 3.
    aBag add: 4 withOccurrences: 1.
    result := 0.
    aBag do: [ :each | result := result + each ].
    self assert: result equals: 27 withMessage: 'should enumerate all the occurrences'.

- testIncludes
    | aBag |
    aBag := Bag new.
    aBag add: $a.
    aBag add: $b withOccurrences: 3.
    aBag add: $c withOccurrences: 2.
    self assertTrue: (aBag includes: $a) withMessage: 'should include the element'.
    self assertTrue: (aBag includes: $b) withMessage: 'should include the element'.
    self assertTrue: (aBag includes: $c) withMessage: 'should include the element'.
    self assertFalse: (aBag includes: $d) withMessage: 'should not include the element'.

- testOccurrencesOf
    | aBag result |
    aBag := Bag new.
    aBag add: $a.
    aBag add: $b withOccurrences: 3.
    aBag add: $c withOccurrences: 2.
    result := aBag occurrencesOf: $a.
    self assert: result equals: 1 withMessage: 'should have 1 $a'.
    result := aBag occurrencesOf: $b.
    self assert: result equals: 3 withMessage: 'should have 3 $b'.
    result := aBag occurrencesOf: $c.
    self assert: result equals: 2 withMessage: 'should have 2 $c'.
    result := aBag occurrencesOf: $d.
    self assert: result equals: 0 withMessage: 'should have 0 $d'.
