"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

SequenceableCollection subclass: #OrderedCollection
                       instanceVariableNames: 'firstIndex lastIndex'
                       classVariableNames: ''
                       poolDictionaries: ''
                       classInstanceVariableNames: ''.

"category: instance creation"

+ new
    ^ self new: 10.

+ new: anInteger
    ^ (super new: anInteger) setIndices.

"category: accessing"

- size
    ^ lastIndex - firstIndex + 1.

- at: anInteger
    | offset |
    offset := anInteger + firstIndex - 1.
    ^ (anInteger < 1 or: [ offset > lastIndex ]) "FIXME: should be able to perform calculation in block"
      ifTrue: [ self errorNoSuchElement ]
      ifFalse: [ super at: offset ]. "FIXME: should be able to return from block"

- at: anInteger put: anObject
    | offset |
    offset := anInteger + firstIndex - 1.
    ^ (anInteger < 1 or: [ offset > lastIndex ])
      ifTrue: [ self errorNoSuchElement ]
      ifFalse: [ super at: offset put: anObject ]. "FIXME: should be able to return from block"

- after: oldObject
    "Answer the element after old0bject in the receiver. If the receiver does not contain oldObject or if the receiver
     contains no elements after oldObject, report an error."
    self notImplementedYet.

- before: oldObject
    "Answer the element before oldObject in the receiver. If the receiver does not contain oldObject or if the receiver
     contains no elements before oldObject, report an error."
    self notImplementedYet.

"category: adding"

- add: newObject
    ^ self addLast: newObject.

- add: newObject after: oldObject
    "Add the argument, newObject, as an element of the receiver. Put it in the sequence just succeeding oldObject.
     Answer newObject. If oldObject is not found, then report an error."
    self notImplementedYet.

- add: newObject before: oldObject
    "Add the argument, newObject, as an element of the receiver. Put it in the sequence just preceding oldObject.
    Answer newObject. If oldObject is not found, then report an error."
    self notImplementedYet.

- addAddFirst: anOrderedCollection
    "Add each element of the argument, anOrderedCollection, at the beginning of the receiver. Answer
    anOrderedCollection."
    self notImplementedYet.

- addAllLast: anOrderedCollection
    "Add each element of the argument, anOrderedCollection, to the end of the receiver. Answer anOrderedCollection."
    self notImplementedYet.

- addFirst: newObject
    "Add the argument, newObject, to the beginning of the receiver. Answer newObject."
    self notImplementedYet.

- addLast: newObject
    "Add the argument, newObject, to the end of the receiver. Answer newObject."
    lastIndex = self basicSize ifTrue: [ self makeRoomAtLast ].
    lastIndex := lastIndex + 1.
    self basicAt: lastIndex put: newObject.
    ^ newObject.

"category: removing"

- remove: oldObject ifAbsent: absentBlock
    | index |
    index := firstIndex.
    [ index <= lastIndex ]
      whileTrue: [
        oldObject = (self basicAt: index)
          ifTrue: [ self removeIndex: index. ^ oldObject ]
          ifFalse: [ index := index + 1 ].
      ].
    ^ absentBlock value.

- removeFirst
    "Remove the first element of the receiver and answer it. If the receiver is empty, report an error."
    self notImplementedYet.

- removeLast
    "Remove the last  element of the receiver and answer it. If the receiver is empty, report an error."
    self notImplementedYet.

"category: enumerating"

- do: aBlock
    | index |
    index := firstIndex.
    [ index <= lastIndex ]
      whileTrue: [
        aBlock value: (self basicAt: index).
        index := index + 1
      ]

- collect: aBlock
    | newCollection |
    newCollection := self species new.
    self do: [ :each | newCollection add: (aBlock value: each) ].
    ^ newCollection.

- select: aBlock
    | newCollection |
    newCollection := self species new.
    self do: [ :each | (aBlock value: each) ifTrue: [ newCollection add: each ] ].
    ^ newCollection.

"category: private"

- setIndices
    firstIndex := self basicSize // 2 max: 1.
    lastIndex := firstIndex - 1 max: 0.

- errorNoSuchElement
    self error: 'attempt to index non-existent element in an ordered collection'.

- makeRoomAtLast
    | newCollection |
    newCollection := self species new: self size * 2.
    newCollection addAll: self.
    self become: newCollection.

- removeIndex: anInteger
    | index |
    index := anInteger.
    [ index < lastIndex ]
      whileTrue: [
        self basicAt: index put: (self basicAt: index + 1).
        index := index + 1
      ].
    lastIndex := lastIndex - 1.
