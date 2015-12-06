"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

LookupKey subclass: #Association
          instanceVariableNames: 'value'
          classVariableNames: ''
          poolDictionaries: ''
          classInstanceVariableNames: ''.

"category: instance creation"

+ key: newKey value: newValue
    ^ (super key: newKey) value: newValue.

"category: accessing"

- key: aKey value: anObject
    key := aKey.
    value := anObject.

- value
    ^ value.

- value: anObject
    value := anObject.

"category: comparing"

- = anAssociation
    ^ super = anAssociation and: [ value = anAssociation value ].

"category: printing"

- printOn: aStream
    super printOn: aStream.
    aStream nextPutAll: '->'.
    value printOn: aStream.

- storeOn: aStream
    aStream nextPut: $(.
    key storeOn: aStream.
    aStream nextPutAll: '->'.
    value storeOn: aStream.
    aStream nextPut: $).

