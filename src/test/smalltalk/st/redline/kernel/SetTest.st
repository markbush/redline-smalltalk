"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #SetTest.

- test
    self testAdd.
    self testUniqueness.
    self testIncludes.
    self testOccurrencesOf.
    self testRemove.
    self testDo.

- testAdd
    | aSet |
    aSet := Set new.
    self assert: aSet size equals: 0 withMessage: 'should have size 0 when empty'.
    aSet add: $a.
    self assert: aSet size equals: 1 withMessage: 'should increase size after adding element'.
    aSet addAll: #($b $c $d $e $f $g $h $i $j $k).
    self assert: aSet size equals: 11 withMessage: 'should increase size after adding more elements'.

- testUniqueness
    | aSet |
    aSet := Set new.
    aSet addAll: #($a $b $c $a $d $c $a $b $d).
    self assert: aSet size equals: 4 withMessage: 'should only add each element once'.

- testIncludes
    | aSet |
    aSet := Set new.
    aSet addAll: 'Hello World'.
    self assert: aSet size equals: 8 withMessage: 'should only add each element once'.
    self assertTrue: (aSet includes: $e) withMessage: 'should contain its elements'.
    self assertFalse: (aSet includes: $a) withMessage: 'should not contain elements not added'.

- testOccurrencesOf
    | aSet result |
    aSet := Set new.
    aSet addAll: 'Hello World'.
    result := aSet occurrencesOf: $a.
    self assert: result equals: 0 withMessage: 'should have 0 occurrences of elements not in the aSet'.
    result := aSet occurrencesOf: $e.
    self assert: result equals: 1 withMessage: 'should have 1 occurrence of elements in the aSet'.
    result := aSet occurrencesOf: $l.
    self assert: result equals: 1 withMessage: 'should have 1 occurrence of elements in the aSet even when added multiple times'.

- testRemove
    | aSet |
    aSet := Set new.
    aSet add: $a.
    self assertTrue: (aSet includes: $a) withMessage: 'should contain element added'.
    self assertFalse: (aSet includes: 97) withMessage: 'should not contain element with same hashcode'.
    aSet add: 97.
    self assertTrue: (aSet includes: 97) withMessage: 'should now contain element with same hashcode'.
    self assert: aSet size equals: 2 withMessage: 'should contain both elements'.
    aSet remove: $a ifAbsent: [].
    self assert: aSet size equals: 1 withMessage: 'should contain remaining element'.
    self assertTrue: (aSet includes: 97) withMessage: 'should still contain element with same hashcode'.

- testDo
    | aSet result |
    aSet := Set new.
    aSet addAll: #(1 4 2 5 4 2 3 1 6 5 2 3).
    result := 0.
    aSet do: [ :each | result := result + each ].
    self assert: result equals: 21 withMessage: 'should find all unique elements once'.
