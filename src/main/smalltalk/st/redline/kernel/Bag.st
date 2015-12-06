"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Collection subclass: #Bag
           instanceVariableNames: 'contents'
           classVariableNames: ''
           poolDictionaries: ''
           classInstanceVariableNames: ''.

"category: instance creation"

+ new
    ^ super new setDictionary

"category: accessing"

- at: index
    self errorNotKeyed.

- at: index put: anObject
    self errorNotKeyed.

- size
    | tally |
    tally := 0.
    contents do: [ :each | tally := tally + each ].
    ^ tally.

"category: adding"

- add: newObject
    ^ self add: newObject withOccurrences: 1

- add: newObject withOccurrences: anInteger
    "Include the argument, newObject, as an element of the receiver, anInteger number of times. Answer the argument,
     newObject."
    contents at: newObject
             put: anInteger + (self occurrencesOf: newObject).
    ^ newObject.

"category: removing"

- remove: oldObject ifAbsent: exceptionBlock
    | count |
    count := self occurrencesOf: oldObject.
    count = 0 ifTrue: [ ^ exceptionBlock value ].
    count = 1
      ifTrue: [ contents removeKey: oldObject ]
      ifFalse: [ contents at: oldObject put: count - 1 ].
    ^ oldObject.

"category: enumerating"

- do: aBlock
    contents associationsDo: [ :assoc |
      assoc value timesRepeat: [ aBlock value: assoc key ].
    ].

"category: testing"

- includes: anObject
    ^ contents includesKey: anObject.

- occurrencesOf: anObject
    ^ contents at: anObject ifAbsent: [ 0 ].

"category: private"

- setDictionary
    contents := Dictionary new.
