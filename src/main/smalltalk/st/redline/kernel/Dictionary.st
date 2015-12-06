"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Set subclass: #Dictionary.

"category: accessing"

- at: key
    ^ self at: key ifAbsent: [ self errorKeyNotFound ].

- at: key put: anObject
    | index element |
    self sizeCheck.
    index := self findKeyOrNil: key.
    element := self basicAt: index.
    element isNil
      ifTrue: [
        self basicAt: index put: (Association key: key value: anObject).
        tally := tally + 1.
      ]
      ifFalse: [
        element value: anObject.
      ].
    ^ anObject.

- at: key ifAbsent: aBlock
    "Answer the value named by the argument, key. If key is not found, answer the result of evaluating aBlock."
    | index |
    index := self findKey: key ifAbsent: [ ^ aBlock value ].
    ^ (self basicAt: index) value.

- associationAt: key
    "Answer the association named by the argument, key. If key is not found, report an error."
    self notImplementedYet.

- associationAt: key ifAbsent: aBlock
    "Answer the association named by the argument, key. If key is not found, answer the result of evaluating aBlock."
    self notImplementedYet.

- keyAtValue: value
    "Answer the name for the argument, value. If there is no such value, answer nil. Since values are not necessarily
     unique, answer the name for the first one encountered in the search."
    self notImplementedYet.

- keyAtValue: value ifAbsent: exceptionBlock
    "Answer the key for the argument, value. If there is no such value, answer the result of evaluating exceptionBlock."
    self notImplementedYet.

- keys
    "Answer a Set containing the receiver's keys."
    self notImplementedYet.

- values
    "Answer a Bag containing the receiver's values (includes any duplications)."
    self notImplementedYet.

"category: adding"

- add: anAssociation
    | index element |
    self sizeCheck.
    index := self findKeyOrNil: anAssociation key.
    element := self basicAt: index.
    element isNil
      ifTrue: [
        self basicAt: index put: anAssociation.
        tally := tally + 1.
      ]
      ifFalse: [
        element value: anAssociation value.
      ].
    ^ anAssociation.

"category: dictionary testing"

- includes: anObject
    self do: [ :each | anObject = each ifTrue: [ ^ true ] ].
    ^ false.

- includesAssociation: anAssociation
    "Answer whether the receiver has an element (association between a key and a value) that is equal to the argument,
     anAssociation."
    ^ super includes: anAssociation.

- includesKey: key
    "Answer whether the receiver has a key equal to the argument, key."
    self associationsDo: [ :each | key = each key ifTrue: [ ^ true ] ].
    ^ false.

"category: dictionary removing"

- remove: anObject ifAbsent: aBlock
    self shouldNotImplement

- removeAssociation: anAssociation
    "Remove the key and value association, anAssociation, from the receiver. Answer anAssociation."
    self removeKey: anAssociation key.
    ^ anAssociation.

- removeKey: key
    "Remove key (and its associated value) from the receiver. If key is not in the receiver, report an error. Otherwise
     answer the value associated with key."
    ^ self removeKey: key ifAbsent: [ self errorKeyNotFound ].

- removeKey: key ifAbsent: aBlock
    "Remove key (and its associated value) from the receiver. If key is not in the receiver, answer the result of
     evaluating aBlock. Otherwise, answer the value named by key."
    | index oldValue |
    index := self findKey: key ifAbsent: [ ^ aBlock value ].
    oldValue := self basicAt: index.
    self basicAt: index put: nil.
    tally := tally - 1.
    self fixCollisionsFrom: index.
    ^ oldValue.

"category: dictionary enumerating"

- do: aBlock
    self associationsDo: [ :assoc | aBlock value: assoc value ].

- associationsDo: aBlock
    "Evaluate aBlock for each of the receiver's key/value associations."
    super do: aBlock.

- keysDo: aBlock
    "Evaluate aBlock for each of the receiver's keys."
    self associationsDo: [ :assoc | aBlock value: assoc key ].

- collect: aBlock
    | newCollection |
    newCollection := Bag new.
    self do: [ :each | newCollection add: (aBlock value: each) ].
    ^ newCollection.

- select: aBlock
    | newCollection |
    newCollection := self species new.
    self associationsDo: [ :assoc |
      (aBlock value: assoc value)
        ifTrue: [ newCollection add: assoc ].
    ].
    ^ newCollection.

"category: private"

- errorKeyNotFound
    self error: 'key not found'.

- findKeyOrNil: aKey
    | index start |
    start := aKey hash \\ self basicSize + 1.
    index := start.
    [ | element |
      element := self basicAt: index.
      (element == nil or: [ element key = aKey ])
        ifTrue: [ ^ index ].
      index := index \\ self basicSize + 1.
      index = start
    ] whileFalse.
    ^ nil.

- findKey: aKey ifAbsent: aBlock
    | index |
    index := self findKeyOrNil: aKey.
    ^ (index isNil or: [ (self basicAt: index) isNil ])
        ifTrue: [ aBlock value ]
        ifFalse: [ index ].

- fixCollisionsFrom: start
    | element index |
    index := start.
    [ index := index \\ self basicSize + 1.
      element := self basicAt: index.
      element == nil ]
      whileFalse: [ | newIndex |
        newIndex := self findKeyOrNil: element key.
        newIndex = index
          ifFalse: [ self swap: index with: newIndex ]
      ].

- grow
    | newCollection |
    newCollection := self species new: self basicSize * 2.
    self associationsDo: [ :assoc | newCollection add: assoc ].
    self become: newCollection.
