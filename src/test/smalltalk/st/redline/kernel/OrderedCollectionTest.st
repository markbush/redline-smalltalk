"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #OrderedCollectionTest.

- test
    self testSize.
    self testAdd.
    self testAddAll.
    self testAt.
    self testAtPut.
    self testAddLast.
    self testRemoveIfAbsent.
    self testDo.
    self testCollect.
    self testSelect.

- testSize
    | collection |
    collection := OrderedCollection new: 20.
    self assert: collection size equals: 0 withMessage: 'should have size 0'.
    collection := OrderedCollection new.
    self assert: collection size equals: 0 withMessage: 'should have size 0'.
    collection add: 1.
    collection add: 2.
    self assert: collection size equals: 2 withMessage: 'should have size 2'.

- testAdd
    | collection |
    collection := OrderedCollection new: 10.
    collection add: 1.
    self assert: collection size equals: 1 withMessage: 'should have size 1 after adding 1 item'.
    collection add: 2.
    self assert: collection size equals: 2 withMessage: 'should have size 2 after adding 2 items'.

- testAddAll
    | collection |
    collection := OrderedCollection new: 15.
    collection addAll: #(1 2 3 4 5).
    self assert: collection size equals: 5 withMessage: 'should have size 5 after adding 5 items'.
    self assert: (collection at: 1) equals: 1 withMessage: 'should have added 1 first'.
    self assert: (collection at: 2) equals: 2 withMessage: 'should have added 2 next'.
    self assert: (collection at: 3) equals: 3 withMessage: 'should have added 3 next'.
    self assert: (collection at: 4) equals: 4 withMessage: 'should have added 4 next'.
    self assert: (collection at: 5) equals: 5 withMessage: 'should have added 5 next'.

- testAt
    | collection result |
    collection := OrderedCollection new: 10.
    collection add: 1.
    collection add: 2.
    result := collection at: 1.
    self assert: result equals: 1 withMessage: 'should select correct element from collection'.
    result := collection at: 2.
    self assert: result equals: 2 withMessage: 'should select correct element from collection'.

- testAtPut
    | collection result |
    collection := OrderedCollection new: 10.
    collection add: 1.
    collection add: 2.
    result := collection at: 1 put: $a.
    self assert: (collection at: 1) equals: $a withMessage: 'should replace element in collection'.
    self assert: result equals: $a withMessage: 'should return new element'.

- testAddLast
    | collection |
    collection := OrderedCollection new: 10.
    collection addLast: 1.
    self assert: collection size equals: 1 withMessage: 'should have size 1 after adding 1 item'.
    collection addLast: 2.
    self assert: collection size equals: 2 withMessage: 'should have size 2 after adding s items'.
    self assert: (collection at: 1) equals: 1 withMessage: 'should have added 1 first'.
    self assert: (collection at: 2) equals: 2 withMessage: 'should have added 2 after'.

- testRemoveIfAbsent
    | collection result |
    collection := OrderedCollection new: 10.
    collection addAll: #(1 2 3 4 5).
    self assert: (collection at: 3) equals: 3 withMessage: 'should start with correct element at index 3'.
    result := collection remove: 2 ifAbsent: [ 0 ].
    self assert: collection size equals: 4 withMessage: 'should remove an element'.
    self assert: result equals: 2 withMessage: 'should return removed element'.
    self assert: (collection at: 3) equals: 4 withMessage: 'should remove the element'.
    result := collection remove: 6 ifAbsent: [ 0 ].
    self assert: collection size equals: 4 withMessage: 'should not remove an element'.
    self assert: result equals: 0 withMessage: 'should return exception block value when element not found'.

- testDo
    | collection result |
    collection := OrderedCollection new: 10.
    result := 0.
    collection do: [ :each | result := result + 1 ].
    self assert: result equals: 0 withMessage: 'should perform 0 times for empty collection'.
    collection addAll: #(1 2 3).
    collection do: [ :each | result := result + 1 ].
    self assert: result equals: 3 withMessage: 'should perform 3 times for empty collection'.
    result := 0.
    collection do: [ :each | result := result + each ].
    self assert: result equals: 6 withMessage: 'should access each element in collection'.

- testSelect
    | collection result |
    collection := OrderedCollection new: 30.
    result := collection select: [ :each | #($a $e $i $o $u) includes: each ].
    self assert: result class equals: OrderedCollection withMessage: 'should produce an OrderedCollection'.
    self assert: result size equals: 0 withMessage: 'should produce an empty OrderedCollection'.
    collection addAll: #($h $e $l $l $o $  $w $o $r $l $d).
    result := collection select: [ :each | #($a $e $i $o $u) includes: each ].
    self assert: result size equals: 3 withMessage: 'should produce an OrderedCollection with 3 elements'.
    self assert: (result at: 1) equals: $e withMessage: 'should have correct value at 1'.
    self assert: (result at: 2) equals: $o withMessage: 'should have correct value at 2'.
    self assert: (result at: 3) equals: $o withMessage: 'should have correct value at 3'.

- testCollect
    | collection result |
    collection := OrderedCollection new: 10.
    result := collection collect: [ :each | each * each ].
    self assert: result class equals: OrderedCollection withMessage: 'should produce an OrderedCollection'.
    self assert: result size equals: 0 withMessage: 'should produce an empty OrderedCollection'.
    collection addAll: #(1 2 3 4 5).
    result := collection collect: [ :each | each * each ].
    self assert: result size equals: 5 withMessage: 'should produce an OrderedCollection with 5 elements'.
    self assert: (result at: 1) equals: 1 withMessage: 'should have correct value at 1'.
    self assert: (result at: 2) equals: 4 withMessage: 'should have correct value at 2'.
    self assert: (result at: 3) equals: 9 withMessage: 'should have correct value at 3'.
    self assert: (result at: 4) equals: 16 withMessage: 'should have correct value at 4'.
    self assert: (result at: 5) equals: 25 withMessage: 'should have correct value at 5'.
