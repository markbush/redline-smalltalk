"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Collection subclass: #Set
           instanceVariableNames: 'tally'
           classVariableNames: ''
           poolDictionaries: ''
           classInstanceVariableNames: ''.

"category: instance creation"

+ new
    ^ self new: 2.

+ new: anInteger
    ^ (super new: anInteger) setTally.

"category: accessing"

- at: index
    self errorNotKeyed.

- at: index put: anObject
    self errorNotKeyed.

- size
    ^ tally.

"category: private"

- setTally
    tally := 0.

- findElementOrNil: anObject
    | index start |
    start := anObject hash \\ self basicSize + 1.
    index := start.
    [ | element |
      element := self basicAt: index.
      (element == nil or: [ element = anObject ])
        ifTrue: [ ^ index ].
      index := index \\ self basicSize + 1.
      index = start
    ] whileFalse.
    ^ nil.

- find: oldObject ifAbsent: aBlock
    | index |
    index := self findElementOrNil: oldObject.
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
        newIndex := self findElementOrNil: element.
        newIndex = index
          ifFalse: [ self swap: index with: newIndex ]
      ].

- swap: index with: newIndex
    | anObject |
    anObject := self basicAt: index.
    self basicAt: index put: (self basicAt: newIndex).
    self basicAt: newIndex put: anObject.

- sizeCheck
    | availableSlots |
    availableSlots := self basicSize.
    availableSlots - tally < (availableSlots // 4 max: 1)
      ifTrue: [ self grow ].

- grow
    | newCollection |
    newCollection := self species new: self basicSize * 2.
    newCollection addAll: self.
    self become: newCollection.

"category: testing"

- includes: anObject
    ^ (self basicAt: (self findElementOrNil: anObject)) ~~ nil

- occurrencesOf: anObject
    ^ (self includes: anObject)
        ifTrue: [ 1 ]
        ifFalse: [ 0 ].

"category: adding"

- add: newObject
    | index |
    newObject isNil ifTrue: [ ^ newObject ].
    self sizeCheck.
    index := self findElementOrNil: newObject.
    (self basicAt: index) isNil
      ifTrue: [
        self basicAt: index put: newObject.
        tally := tally + 1
      ].
    ^ newObject.

"category: removing"

- remove: oldObject ifAbsent: aBlock
    | index |
    index := self find: oldObject ifAbsent: [ ^ aBlock value ].
    self basicAt: index put: nil.
    tally := tally - 1.
    self fixCollisionsFrom: index.
    ^ oldObject.

"category: enumerating"

- do: aBlock
    tally = 0
      ifTrue: [ ^ self ].
    1 to: self basicSize do: [ :index |
      (self basicAt: index) == nil
        ifFalse: [ aBlock value: (self basicAt: index) ]
    ].
    ^ self
