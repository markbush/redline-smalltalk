"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Dictionary subclass: #IdentityDictionary.

"category: dictionary testing"

- includes: anObject
    self do: [ :each | anObject == each ifTrue: [ ^ true ] ].
    ^ false.

- includesAssociation: anAssociation
    "Answer whether the receiver has an element (association between a key and a value) that is equal to the argument,
     anAssociation, with identical key."
    ^ (self includesKey: anAssociation key)
        and: [ (self at: anAssociation key) = anAssociation value ].

- includesKey: key
    "Answer whether the receiver has a key identical to the argument, key."
    self associationsDo: [ :assoc | key == assoc key ifTrue: [ ^ true ] ].
    ^ false.

"category: private"

- findKeyOrNil: aKey
    | index start |
    start := aKey hash \\ self basicSize + 1.
    index := start.
    [ | element |
      element := self basicAt: index.
      (element == nil or: [ element key == aKey ])
        ifTrue: [ ^ index ].
      index := index \\ self basicSize + 1.
      index = start
    ] whileFalse.
    ^ nil.
