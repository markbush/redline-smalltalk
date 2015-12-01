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
    | set |
    set := Set new.
    self assert: set size equals: 0 withMessage: 'should have size 0 when empty'.
    set add: $a.
    self assert: set size equals: 1 withMessage: 'should increase size after adding element'.
    set addAll: #($b $c $d $e $f $g $h $i $j $k).
    self assert: set size equals: 11 withMessage: 'should increase size after adding more elements'.

- testUniqueness
    | set |
    set := Set new.
    set addAll: #($a $b $c $a $d $c $a $b $d).
    self assert: set size equals: 4 withMessage: 'should only add each element once'.

- testIncludes
    | set |
    set := Set new.
    set addAll: 'Hello World'.
    self assert: set size equals: 8 withMessage: 'should only add each element once'.
    self assertTrue: (set includes: $e) withMessage: 'should contain its elements'.
    self assertFalse: (set includes: $a) withMessage: 'should not contain elements not added'.

- testOccurrencesOf
    | set result |
    set := Set new.
    set addAll: 'Hello World'.
    result := set occurrencesOf: $a.
    self assert: result equals: 0 withMessage: 'should have 0 occurrences of elements not in the set'.
    result := set occurrencesOf: $e.
    self assert: result equals: 1 withMessage: 'should have 1 occurrence of elements in the set'.
    result := set occurrencesOf: $l.
    self assert: result equals: 1 withMessage: 'should have 1 occurrence of elements in the set even when added multiple times'.

- testRemove
    | set |
    set := Set new.
    set add: $a.
    self assertTrue: (set includes: $a) withMessage: 'should contain element added'.
    self assertFalse: (set includes: 97) withMessage: 'should not contain element with same hashcode'.
    set add: 97.
    self assertTrue: (set includes: 97) withMessage: 'should now contain element with same hashcode'.
    self assert: set size equals: 2 withMessage: 'should contain both elements'.
    set remove: $a ifAbsent: [].
    self assert: set size equals: 1 withMessage: 'should contain remaining element'.
    self assertTrue: (set includes: 97) withMessage: 'should still contain element with same hashcode'.

- testDo
    | set result |
    set := Set new.
    set addAll: #(1 4 2 5 4 2 3 1 6 5 2 3).
    result := 0.
    set do: [ :each | result := result + each ].
    self assert: result equals: 21 withMessage: 'should find all unique elements once'.
