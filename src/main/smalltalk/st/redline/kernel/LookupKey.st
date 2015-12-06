"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Magnitude subclass: #LookupKey
          instanceVariableNames: 'key'
          classVariableNames: ''
          poolDictionaries: ''
          classInstanceVariableNames: ''.

"category: instance creation"

+ key: aKey
    ^ self basicNew key: aKey.

"category: accessing"

- key
    ^ key.

- key: anObject
    key := anObject.

"category: comparing"

- < aLookupKey
    ^ key < aLookupKey key.

- = aLookupKey
    ^ self species = aLookupKey species
      ifTrue: [ key = aLookupKey key ]
      ifFalse: [ false ].

- hash
    ^ key hash.

"category: printing"

- printOn: aStream
    key printOn: aStream.
