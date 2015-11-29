"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

PositionableStream subclass: #WriteStream
                   instanceVariableNames: 'writeLimit'
                   classVariableNames: ''
                   poolDictionaries: ''
                   classInstanceVariableNames: ''.

"category: instance creation."

+ on: aCollection from: firstIndex to: lastIndex
    "Answer an instance of a kind of WriteStream that streams over a copy of a subcollection of the argument,
     aCollection, from firstIndex to lastIndex."
    ^ self basicNew on: aCollection from: firstIndex to: lastIndex.

+ with: aCollection
    "Answer an instance of WriteStream accessing the argument, aCollection, but positioned to store the next
     element at the end of it"
    ^ self basicNew with: aCollection.

+ with: aCollection from: firstIndex to: lastIndex
    "Answer an instance of WriteStream accessing the subcollection of the argument, aCollection, from location
     firstIndex to lastIndex, but positioned to store the next element at the end of the subcollection."
    ^ self basicNew with: (aCollection copyFrom: firstIndex to: lastIndex).

"category: private"

- on: aCollection
    "Answer an instance of a kind of PositionableStream that streams over the argument, aCollection."
    super on: aCollection.
    readLimit := 0.
    writeLimit := aCollection size.

- on: aCollection from: firstIndex to: lastIndex
    "Answer an instance of a kind of PositionableStream that streams over a copy of a subcollection of the argument,
     aCollection, from firstIndex to lastIndex."
    | len |
    collection := aCollection.
    readLimit := 
        writeLimit := lastIndex > (len := collection size)
                        ifTrue: [ len ]
                        ifFalse: [ lastIndex ].
    position := firstIndex <= 1
                  ifTrue: [ 0 ]
                  ifFalse: [ firstIndex - 1 ].

- with: aCollection
    super on: aCollection.
    position := (readLimit := (writeLimit := aCollection size)).

- pastEndPut: anObject
    collection := collection grownBy: ((collection size max: 20) min: 1000000).
    writeLimit := collection size.
    position := position + 1.
    collection at: position put: anObject.
    ^ anObject

"category: accessing"

- contents
    "Answer all of the objects in the collection accessed by the receiver. Generally, the answer will be a collection
     of the same class as the one accessed by the receiver."
    readLimit := readLimit max: position.
    ^ collection copyFrom: 1 to: position.

"category: accessing - reading"

- next
    "Answer the next object accessible by the receiver."
    self shouldNotImplement.

"category: accessing - writing"

- nextPut: anObject
    "Store the argument, anObject, as the next element accessible by the receiver. Answer anObject."
    position >= writeLimit
      ifTrue: [ ^ self pastEndPut: anObject ]
      ifFalse: [
        position := position + 1.
        ^ collection at: position put: anObject
      ].

"category: character writing"

- space
    self nextPut: $ .
