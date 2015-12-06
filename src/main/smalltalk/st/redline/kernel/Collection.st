"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Object subclass: #Collection.

"category: adding"

- add: newObject
    "Include the argument , newObject, as one of the receiver's elements. Answer newObject."
    self subclassResponsibility.

- addAll: aCollection
    "Include all the elements of the argument, aCollection, as the receiver's elements. Answer aCollection."
    aCollection do: [ :each | self add: each ].
    ^ aCollection.

"category: removing"

- remove: oldObject
    "Remove the argument, oldObject, from the receiver's elements. Answer oldObject unless no element is equal to
     oldObject, in which case, report that an error occurred."
    self remove: oldObject ifAbsent: [ self errorNotFound ].

- remove: oldObject ifAbsent: anExceptionBlock
    "Remove the argument , oldObject, from the receiver's elements. If several of the elements are equal to oldObject,
     only one is removed. If no element is equal to oldObject, answer the result of evaluating anExceptionBlock.
     Otherwise, answer oldObject."
    self subclassResponsibility.

- removeAll: aCollection
    "Remove each element of the argument, aCollection, from the receiver. If successful for each, answer aCollection.
     Otherwise report that an error occurred."
    aCollection do: [ :each | self remove: each ].
    ^ aCollection.

- includes: anObject
    "Answer whether the argument , anObject, is equal to one of the receiver's elements."
    self do: [ :each | anObject = each ifTrue: [ ^ true ] ].
    ^ false.

- isEmpty
    "Answer whether the receiver contains any elements."
    ^ self size = 0.

- occurrencesOf: anObject
    "Answer how many of the receiver's elements are equal to the argument , anObject."
    | tally |
    tally := 0.
    self do: [ :each | anObject = each ifTrue: [ tally := tally + 1 ] ].
    ^ tally.

"category: accessing"

- size
    | tally |
    tally := 0.
    self do: [ :each | tally := tally + 1 ].
    ^ tally.

"category: enumeration"

- do: aBlock
    "Evaluate the argument, aBlock, for each of the receiver's elements."
    self subclassResponsibility.

- select: aBlock
    "Evaluate the argument, aBlock, for each of the receiver's elements. Collect into a new collection like that of the
     receiver, only those elements for which aBlock evaluates to true. Answer the new collection."
    | newCollection |
    newCollection := self species new.
    self do: [ :each | (aBlock value: each) ifTrue: [ newCollection add: each ] ].
    ^ newCollection.

- reject: aBlock
    "Evaluate the argument, aBlock, for each of the receiver's elements. Collect into a new collection like that of the
     receiver only those elements for which aBlock evaluates to false. Answer the new collection."
    ^ self select: [ :element | (aBlock value: element) == false ].

- collect: aBlock
    "Evaluate the argument, aBlock, for each of the receiver's elements. Answer a new collection like that of the
     receiver containing the values returned by the block on each evaluation."
    | newCollection |
    newCollection := self species new.
    self do: [ :each | newCollection add: (aBlock value: each) ].
    ^ newCollection.

- detect: aBlock
    "Evaluate the argument, aBlock, for each of the receiver's elements. Answer the first element for which aBlock
     evaluates to true. If none evaluates to true, report an error."
    ^ self detect: aBlock ifNone: [ self errorNotFound ].

- detect: aBlock ifNone: exceptionBlock
    "Evaluate the argument, aBlock, for each of the receiver's elements. Answer the first element for which aBlock
     evaluates to true. If none evaluates to true, evaluate the argument, exceptionBlock, exceptionBlock must be a
     block requiring no arguments."
    self do: [ :each | (aBlock value: each) ifTrue: [ ^ each ] ].
    ^ exceptionBlock value.

- inject: thisValue into: binaryBlock
    "Evaluate the argument, binaryBlock, once for each element in the receiver. The block has two arguments: the second
     is an element from the receiver; the first is the value of the previous evaluation of the block, starting with the
     argument, thisValue. Answer the final value of the block."
    | nextValue |
    nextValue := thisValue.
    self do: [ :each | nextValue := binaryBlock value: nextValue value: each ].
    ^ nextValue.

"category: instance creation"

+ with: anObject
    "Answer an instance of the collection containing anObject."
    | newCollection |
    newCollection := self new.
    newCollection add: anObject.
    ^ newCollection.

+ with: firstObject with: secondObject
    "Answer an instance of the collection containing firstObject and secondObject as elements."
    | newCollection |
    newCollection := self new.
    newCollection add: firstObject.
    newCollection add: secondObject.
    ^ newCollection.

+ with: firstObject with: secondObject with: thirdObject
    "Answer an instance of the collection containing firstObject, secondObject, and thirdObject as elements."
    | newCollection |
    newCollection := self new.
    newCollection add: firstObject.
    newCollection add: secondObject.
    newCollection add: thirdObject.
    ^ newCollection.

+ with: firstObject with: secondObject with: thirdObject with: fourthObject
    "Answer an instance of the collection, containing firstObject, secondObject, thirdObject, and fourthObject as the
     elements."
    | newCollection |
    newCollection := self new.
    newCollection add: firstObject.
    newCollection add: secondObject.
    newCollection add: thirdObject.
    newCollection add: fourthObject.
    ^ newCollection.

"category: converting"

- asBag
    "Answer a Bag whose elements are those of the receiver."
    | aBag |
    aBag := Bag new.
    self do: [ :each | aBag add: each ].
    ^ aBag.

- asSet
    "Answer a Set whose elements are those of the receiver (any duplications are therefore eliminated)."
    | aSet |
    aSet := Set new: self size.
    self do: [ :each | aSet add: each ].
    ^ aSet.

- asOrderedCollection
    "Answer an OrderedCollection whose elements are those of the receiver (ordering is possibly arbitrary)."
    | anOrderedCollection |
    anOrderedCollection := OrderedCollection new: self size.
    self do: [ :each | anOrderedCollection addLast: each ].
    ^ anOrderedCollection.

- asSortedCollection
    "Answer a SortedCollection whose elements are those of the receiver, sorted so that each element is less than or
     equal to (<=) its successors."
    | aSortedCollection |
    aSortedCollection := SortedCollection new: self size.
    aSortedCollection addAll: self.
    ^ aSortedCollection.

- asSortedCollection: aBlock
    "Answer a SortedCollection whose elements are those of the receiver, sorted according to the argument aBlock."
    | aSortedCollection |
    aSortedCollection := SortedCollection new: self size.
    aSortedCollection sortBlock: aBlock.
    aSortedCollection addAll: self.
    ^ aSortedCollection.

"category: private"

- errorNotFound
    self error: 'Object is not in the collection'.

- errorNotKeyed
    self error: self class name , 's do not respond to keyed accessing messages'.

- maxPrint
    ^ 5000.

"category: printing"

- printOn: aStream
    | tooMany |
    tooMany := aStream position + self maxPrint.
    aStream nextPutAll: self class name , ' ('.
    self do: [ :element |
      aStream position > tooMany
        ifTrue: [ aStream nextPutAll: '...etc...)'. ^ self ].
      element printOn: aStream.
      aStream space.
    ].
    aStream nextPut: $).

- storeOn: aStream
    | noneYet |
    aStream nextPutAll: ' (('.
    aStream nextPutAll: self class name.
    aStream nextPutAll: ' new)'.
    noneYet := true.
    self do: [ :each |
      noneYet
        ifTrue: [ noneYet := false ]
        ifFalse: [ aStream nextPut: $; ].
      aStream nextPutAll: ' add: '.
      aStream store: each.
    ].
    noneYet ifFalse: [ aStream nextPutAll: ' ; yourself ' ].
    aStream nextPut: $).
