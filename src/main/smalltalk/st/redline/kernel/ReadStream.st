"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

PositionableStream subclass: #ReadStream.

"category: instance creation."

+ on: aCollection from: firstIndex to: lastIndex
    "Answer an instance of a kind of PositionableStream that streams over a copy of a subcollection of the argument,
     aCollection, from firstIndex to lastIndex."
    ^ self basicNew on: aCollection from: firstIndex to: lastIndex.

"category: private"

- on: aCollection from: firstIndex to: lastIndex
    "Answer an instance of a kind of PositionableStream that streams over a copy of a subcollection of the argument,
     aCollection, from firstIndex to lastIndex."
    | len |
    collection := aCollection.
    readLimit :=  lastIndex > (len := collection size)
                    ifTrue: [ len ]
                    ifFalse: [ lastIndex ].
    position := firstIndex <= 1
                  ifTrue: [ 0 ]
                  ifFalse: [ firstIndex - 1 ].

"category: accessing - reading"

- next
    "Answer the next object accessible by the receiver."
    position >= readLimit
      ifTrue: [ ^ nil ]
      ifFalse: [ ^ collection at: (position := position + 1) ].

"category: accessing - writing"

- nextPut: anObject
    "Store the argument, anObject, as the next element accessible by the receiver. Answer anObject."
    self shouldNotImplement.
