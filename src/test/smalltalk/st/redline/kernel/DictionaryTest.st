"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #DictionaryTest.

- test
    self testAtPut.
    self testAt.
    self testAdd.
    self testRemoveKey.
    self testRemoveAssociation.
    self testIncludes.
    self testIncludesAssociation.
    self testIncludesKey.
    self testDo.
    self testKeysDo.
    self testAssociationsDo.
    self testCollect.
    self testSelect.

- testAtPut
    | aDictionary |
    aDictionary := Dictionary new.
    self assert: aDictionary size equals: 0 withMessage: 'should start with size 0'.
    aDictionary at: #one put: 1.
    self assert: aDictionary size equals: 1 withMessage: 'should have size 1 after adding an item'.
    aDictionary at: #one put: 2.
    self assert: aDictionary size equals: 1 withMessage: 'should still have size 1 after changing the value of an item'.
    aDictionary at: #three put: 3.
    self assert: aDictionary size equals: 2 withMessage: 'should have size 2 after adding another value'.

- testAt
    | aDictionary result |
    aDictionary := Dictionary new.
    aDictionary at: #one put: 1.
    aDictionary at: #two put: 2.
    result := aDictionary at: #one.
    self assert: result equals: 1 withMessage: 'should find correct value'.
    result := aDictionary at: #two.
    self assert: result equals: 2 withMessage: 'should find correct value'.

- testAdd
    | aDictionary anAssociation result |
    aDictionary := Dictionary new.
    aDictionary at: #one put: 1.
    anAssociation := #two -> 2.
    aDictionary add: anAssociation.
    self assert: aDictionary size equals: 2 withMessage: 'should have size 2 after adding two elements'.
    anAssociation := #one -> 'one'.
    aDictionary add: anAssociation.
    self assert: aDictionary size equals: 2 withMessage: 'should replace an existing element'.
    result := aDictionary at: #one.
    self assert: result equals: 'one' withMessage: 'should find correct value'.

- testRemoveKey
    | aDictionary |
    aDictionary := Dictionary new: 5.
    aDictionary add: 97 -> 'ninety seven'.
    aDictionary add: $a -> 'a'.
    self assert: aDictionary size equals: 2 withMessage: 'should have size 2 after adding two elements'.
    aDictionary removeKey: 97.

- testRemoveAssociation
    | aDictionary |
    aDictionary := Dictionary new.
    aDictionary add: #one -> 1.
    self assert: aDictionary size equals: 1 withMessage: 'should have size 1 after adding an association'.
    aDictionary removeAssociation: #one -> 1.
    self assert: aDictionary size equals: 0 withMessage: 'should have size 0 after removing the association'.

- testIncludes
    | aDictionary result |
    aDictionary := Dictionary new.
    aDictionary add: #one -> 'one'.
    result := aDictionary includes: 'one'.
    self assertTrue: result withMessage: 'should include the value'.

- testIncludesAssociation
    | aDictionary result |
    aDictionary := Dictionary new.
    aDictionary add: #one -> 1.
    result := aDictionary includesAssociation: #one -> 1.
    self assertTrue: result withMessage: 'should include the association'.

- testIncludesKey
    | aDictionary result |
    aDictionary := Dictionary new.
    aDictionary add: #one -> 1.
    result := aDictionary includesKey: #one.
    self assertTrue: result withMessage: 'should include the key'.

- testDo
    | aDictionary result |
    aDictionary := Dictionary new.
    aDictionary add: #one -> 1.
    aDictionary add: #two -> 2.
    aDictionary add: #three -> 3.
    aDictionary add: #four -> 4.
    aDictionary add: #five -> 5.
    result := 0.
    aDictionary do: [ :eachValue | result := result + eachValue ].
    self assert: result equals: 15 withMessage: 'should enumerate over values'.

- testKeysDo
    | aDictionary result |
    aDictionary := Dictionary new.
    aDictionary add: 1 -> 6.
    aDictionary add: 2 -> 7.
    aDictionary add: 3 -> 8.
    aDictionary add: 4 -> 9.
    aDictionary add: 5 -> 10.
    result := 0.
    aDictionary keysDo: [ :eachKey | result := result + eachKey ].
    self assert: result equals: 15 withMessage: 'should enumerate over keys'.

- testAssociationsDo
    | aDictionary keysResult valuesResult |
    aDictionary := Dictionary new.
    aDictionary add: 1 -> 6.
    aDictionary add: 2 -> 7.
    aDictionary add: 3 -> 8.
    aDictionary add: 4 -> 9.
    aDictionary add: 5 -> 10.
    keysResult := 0.
    valuesResult := 0.
    aDictionary associationsDo: [ :assoc |
      keysResult := keysResult + assoc key.
      valuesResult := valuesResult + assoc value.
    ].
    self assert: keysResult equals: 15 withMessage: 'should enumerate over associations with keys'.
    self assert: valuesResult equals: 40 withMessage: 'should enumerate over associations with values'.

- testCollect
    | aDictionary result |
    aDictionary := Dictionary new.
    aDictionary add: 1 -> 6.
    aDictionary add: 2 -> 7.
    aDictionary add: 3 -> 8.
    aDictionary add: 4 -> 9.
    aDictionary add: 5 -> 10.
    result := aDictionary collect: [ :each | each \\ 3 ].
    self assert: result class equals: Bag withMessage: 'should produce a Bag'.
    self assert: result size equals: 5 withMessage: 'should produce same number of values as original Dictionary'.
    self assert: (result occurrencesOf: 0) equals: 2 withMessage: 'should evaluate results correctly'.
    self assert: (result occurrencesOf: 1) equals: 2 withMessage: 'should evaluate results correctly'.
    self assert: (result occurrencesOf: 2) equals: 1 withMessage: 'should evaluate results correctly'.

- testSelect
    | aDictionary result |
    aDictionary := Dictionary new.
    aDictionary add: 1 -> 6.
    aDictionary add: 2 -> 7.
    aDictionary add: 3 -> 8.
    aDictionary add: 4 -> 9.
    aDictionary add: 5 -> 10.
    result := aDictionary select: [ :each | each \\ 3 = 0 ].
    self assert: result class equals: Dictionary withMessage: 'should produce a Dictionary'.
    self assert: result size equals: 2 withMessage: 'should select the correct number of elements based on values'.
    result := aDictionary includesAssociation: 1 -> 6.
    self assertTrue: result withMessage: 'should select correct elements'.
    result := aDictionary includesAssociation: 4 -> 9.
    self assertTrue: result withMessage: 'should select correct elements'.
