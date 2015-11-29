"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

SequenceableCollection subclass: #ArrayedCollection.

"category: adding"

- add: newObject
    "Include the argument , newObject, as one of the receiver's elements. Answer newObject."
    self shouldNotImplement.

"category: accessing"

- size
    <primitive: 62>.

"category: instance creation"

+ with: anObject
    "Answer an instance of the collection containing anObject."
    | newCollection |
    newCollection := self new: 1.
    newCollection at: 1 put: anObject.
    ^ newCollection.

+ with: firstObject with: secondObject
    "Answer an instance of the collection containing firstObject and secondObject as elements."
    | newCollection |
    newCollection := self new: 2.
    newCollection at: 1 put: firstObject.
    newCollection at: 2 put: secondObject.
    ^ newCollection.

+ with: firstObject with: secondObject with: thirdObject
    "Answer an instance of the collection containing firstObject, secondObject, and thirdObject as elements."
    | newCollection |
    newCollection := self new: 3.
    newCollection at: 1 put: firstObject.
    newCollection at: 2 put: secondObject.
    newCollection at: 3 put: thirdObject.
    ^ newCollection.

+ with: firstObject with: secondObject with: thirdObject with: fourthObject
    "Answer an instance of the collection, containing firstObject, secondObject, thirdObject, and fourthObject as the
     elements."
    | newCollection |
    newCollection := self new: 4.
    newCollection at: 1 put: firstObject.
    newCollection at: 2 put: secondObject.
    newCollection at: 3 put: thirdObject.
    newCollection at: 4 put: fourthObject.
    ^ newCollection.
    