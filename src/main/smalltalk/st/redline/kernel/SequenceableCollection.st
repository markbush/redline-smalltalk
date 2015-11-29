"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Collection subclass: #SequenceableCollection.

"category: comparing"

- = aCollection
    | isSequenceable |
    "Answer if aCollection is equal to the receiver."
    self == aCollection ifTrue: [ ^ true ].
    isSequenceable := aCollection isKindOf: SequenceableCollection.
    isSequenceable ifFalse: [ ^ false ].
    self size = aCollection size ifFalse: [ ^ false ].
    1 to: self size do: [ :index |
      (self at: index) = (aCollection at: index)
        ifFalse: [ ^ false ].
    ].
    ^ true.

"category: accessing"

- size
    self subclassResponsibility.

- atAll: aCollection put: anObject
    "Associate each element of the argument, aCollection (an Integer or other external key), with the second argument,
     anObject."
    self notImplementedYet.

- atAllPut: anObject
    "Put the argument, anObject, as every one of the receiver's elements."
    self notImplementedYet.

- first
    "Answer the first element of the receiver. Report an error if the receiver contains no elements."
    ^ self at: 1.

- last
    "Answer the last element of the receiver. Report an error if the receiver contains no elements."
    self notImplementedYet.

- indexOf: anElement
    "Answer the first index of t h e argument, anElement, within the receiver. If the receiver does not contain
     anElement, answer 0."
    self notImplementedYet.

- indexOf: anElement ifAbsent: exceptionBlock
    "Answer the first index of the argument, anElement, within the receiver. If the receiver does not contain anElement
     answer the result of evaluating the argument, exceptionBlock."
    self notImplementedYet.

- indexOfSubCollection: aSubCollection startingAt: anIndex
    "If the elements of the argument, aSubCollection, appear, in order, in the receiver, then answer the index of the
     first element of the first such occurrence. If no such match is found, answer 0."
    self notImplementedYet.

- indexOfSubCollection: aSubCollection startingAt: anIndex ifAbsent: exceptionBlock
    "Answer the index of the receiver's first element, such that that element equals the first element of the argument,
     aSubCollection, and the next elements equal the rest of the elements of aSubCollection. Begin the search of the
     receiver at the element whose index is the argument, anIndex. If no such match is found, answer the result of
     evaluating the argument, exceptionBlock."
    self notImplementedYet.

- replaceFrom: start to: stop with: replacementCollection
    "Associate each index between start and stop with the elements of the argument, replacementCollection. Answer the
     receiver. The number of elements in replacementCollection must equal stop-start + 1."
    self notImplementedYet.

- replaceFrom: start to: stop with: replacementCollection startingAt: repStart
    "Associate each index between start and stop with the elements of the argument, replacementCollection, starting at
     the element of replacementCollection whose index is repStart. Answer the receiver. No range checks are performed,
     except if the receiver is the same as replacementCollection but repStart is not 1, then an error reporting that
     indices are out of range will occur."
    | index repOffset |
    (self == replacementCollection and: [ repStart ~= 1 ])
      ifTrue: [ self errorSubscriptBounds: self size + 1 ].
    index := start.
    repOffset := repStart - start.
    [ index <= stop ]
      whileTrue: [
        self at: index put: (replacementCollection at: repOffset + index).
        index := index + 1
      ].
    ^ self.

"category: copying"

- , aSequenceableCollection
    "This is the concatenation operation. Answer a copy of the receiver with each element of the argument,
    aSequenceableCollection, added, in order."
    ^ self copyReplaceFrom: self size + 1 to: self size with: aSequenceableCollection.

- copyFrom: start to: stop
    "Answer a copy of a subset of the receiver, starting from element at index start until element at index stop."
    | newSize |
    newSize := stop - start + 1.
    ^ (self species new: newSize)
        replaceFrom: 1
        to: newSize
        with: self
        startingAt: start.

- copyReplaceAll: oldSubCollection with: newSubCollection
    "Answer a copy of the receiver in which all occurrences of oldSubCollection have been replaced by newSubCollection."
    self notImplementedYet.

- copyReplaceFrom: start to: stop with: replacementCollection
    "Answer a copy of the receiver satisfying the following conditions: If stop is less than start, then this is an
     insertion; stop should be exactly start-1, start = 1 means insert before the first character, start = size + 1
     means append after last character. Otherwise, this is a replacement; start and stop have to be within the
     receiver's bounds."
    | newSequenceableCollection newSize endReplacement |
    newSize := self size - (stop - start + 1) + replacementCollection size.
    endReplacement := start - 1 + replacementCollection size.
    newSequenceableCollection := self species new: newSize.
    start > 1
      ifTrue: [
        newSequenceableCollection replaceFrom: 1
                                  to: start - 1
                                  with: self
                                  startingAt: 1
      ].
    start <= endReplacement
      ifTrue: [
        newSequenceableCollection replaceFrom: start
                                  to: endReplacement
                                  with: replacementCollection
                                  startingAt: 1
      ].
    endReplacement < newSize
      ifTrue: [
        newSequenceableCollection replaceFrom: endReplacement + 1
                                  to: newSize
                                  with: self
                                  startingAt: stop + 1
      ].
    ^ newSequenceableCollection.

- copyWith: newElement
    "Answer a copy of the receiver that is 1 bigger than the receiver and has newElement as the last element."
    self notImplementedYet.

- copyWithout: oldElement
    "Answer a copy of the receiver in which all occurrences of oldElement have been left out."
    self notImplementedYet.

- grownBy: length
    | newCollection size |
    size := self size.
    newCollection := self species new: size + length.
    newCollection replaceFrom: 1 to: size with: self startingAt: 1.
    ^ newCollection

"category: enumeration"

- findFirst: aBlock
    "Evaluate aBlock with each of the receiver's elements as the argument. Answer the index of the first element for
     which the argument, aBlock evaluates to true."
    self notImplementedYet.

- findLast: aBlock
    "Evaluate aBIock with each of the receiver's elements as the argument. Answer the index of the last element for
     which the argument, aBlock evaluates to true."
    self notImplementedYet.

- reverseDo: aBlock
    "Evaluate aBlock with each of the receiver's elements as the argument, starting with the last element and taking
     each in sequence up to the first. For SequenceableCollections, this is the reverse of the enumeration for do:.
     aBlock is a one-argument block."
    self notImplementedYet.

- with: aSequenceableCollection do: aBlock
    "Evaluate aBlock with each of the receiver's elements along with the corresponding element from
     aSequenceableCollection. aSequenceableCollection must be the same size as the receiver, and aBlock must be a
     two-argument block."
    self notImplementedYet.

"category: removing"

- remove: anObject ifAbsent: anExceptionBlock
    self shouldNotImplement.

"category: enumerating"

- do: aBlock
    | index length |
    index := 0.
    length := self size.
    [ (index := index + 1) <= length ]
      whileTrue: [ aBlock value: (self at: index) ].

- collect: aBlock
    | aStream index length |
    aStream := WriteStream on: (self species new: self size).
    index := 0.
    length := self size.
    [ (index := index + 1) <= length ]
      whileTrue: [ aStream nextPut: (aBlock value: (self at: index)) ].
    ^ aStream contents.

- select: aBlock
    | aStream index length newCollection |
    newCollection := self species new: self size.
    aStream := WriteStream on: newCollection.
    index := 0.
    length := self size.
    [ (index := index + 1) <= length ]
      whileTrue: [
        (aBlock value: (self at: index))
          ifTrue: [ aStream nextPut: (self at: index) ].
      ].
    ^ aStream contents.
