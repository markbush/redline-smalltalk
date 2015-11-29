"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Stream subclass: #PositionableStream
       instanceVariableNames: 'collection position readLimit'
       classVariableNames: ''
       poolDictionaries: ''
       classInstanceVariableNames: ''.

"category: instance creation."

+ on: aCollection
    "Answer an instance of a kind of PositionableStream that streams over the argument, aCollection."
    ^ self basicNew on: aCollection.

+ on: aCollection from: firstIndex to: lastIndex
    "Answer an instance of a kind of PositionableStream that streams over a copy of a subcollection of the argument,
     aCollection, from firstIndex to lastIndex."
    ^ self basicNew on: (aCollection copyFrom: firstIndex to: lastIndex).

"category: private"

- on: aCollection
    "Answer an instance of a kind of PositionableStream that streams over the argument, aCollection."
    collection := aCollection.
    readLimit := aCollection size.
    position := 0.
    self reset.

- positionError
    self error: 'attempt to set the position of a PositionableStream out of bounds'.

"category: testing."

- atEnd
    "Answer whether the receiver cannot access any more objects."
    ^ position >= readLimit.

- isEmpty
    "Answer true if the collection the receiver accesses has no elements; otherwise, answer false."
    ^ self atEnd and: [ position = 0 ].

"category: accessing."

- peek
    "Answer the next element in the collection (as in the message next), but do not change, the position reference.
     Answer nil if the receiver is at the end."
    | nextObject |
    self atEnd ifTrue: [ ^ nil ].
    nextObject := self next.
    position := position - 1.
    ^ nextObject.

- peekFor: anObject
    "Determine the response to the message peek. If it is the same as the argument, anObject, then increment the
    position reference and answer true. Otherwise answer false and do not change the position reference."
    | nextObject |
    self atEnd ifTrue: [ ^ false ].
    nextObject := self next.
    anObject = nextObject ifTrue: [ ^ true ].
    position := position - 1.
    ^ false.

- upTo: anObject
    "Answer a collection of elements starting with the next element accessed by the receiver, and up to, not inclusive
     of, the next element that is equal to anObject. If anObject is not in the collection, answer the entire rest of the
     collection."
    | newCollection element |
    newCollection := OrderedCollection new.
    [ self atEnd or: [ (element := self next) = anObject ] ]
        whileFalse: [ newCollection addLast: element ].
    ^ newCollection.

- contents
    "Answer all of the objects in the collection accessed by the receiver. Generally, the answer will be a collection
     of the same class as the one accessed by the receiver."
    ^ collection copyFrom: 1 to: readLimit.

- reverseContents
    "Answer a copy of the receiver's contents in reverse order."
    self notImplementedYet.

"category: positioning."

- position
    "Answer the receiver's current position reference for accessing the collection."
    ^ position.

- position: anInteger
    "Set the receiver's current position reference for accessing the collection to be the argument, anInteger. If the
     argument is not within the bounds of the receiver's collection, report an error."
    (anInteger >= 0 and: [ anInteger <= readLimit ])
      ifTrue: [ position := anInteger ]
      ifFalse: [ self positionError ].

- reset
    "Set the receiver's position reference to the beginning of the collection."
    position := 0.

- setToEnd
    "Set the receiver's position reference to the end of the collection."
    position := readLimit.

- skip: anInteger
    "Set the receiver's position reference to be the current position plus the argument, anInteger, possibly adjusting
     the result so as to remain within the bounds of the collection."
    self position: position + anInteger.

- skipTo: anObject
    "Set the receiver's position reference to be past the next occurrence of the argument, anObject, in the collection.
     Answer whether such an occurrence existed."
    [ self atEnd ]
        whileFalse: [ self next = anObject ifTrue: [ ^ true ] ].
    ^ false.
