"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

SequenceableCollection subclass: #Interval
                       instanceVariableNames: 'start stop step'
                       classVariableNames: ''
                       poolDictionaries: ''
                       classInstanceVariableNames: ''.

"category: instance creation"

+ from: startInteger to: stopInteger
    "Answer an instance of class Interval, starting with the number startInteger, ending with the number stopInteger,
     and using the increment 1 to compute each successive element."
    ^ self new setFrom: startInteger to: stopInteger by: 1.

+ from: startInteger to: stopInteger by: stepInteger
    "Answer an instance of Interval, starting with the number startInteger, ending with the number stopInteger, and
     using the increment stepInteger to compute each successive element."
    ^ self new setFrom: startInteger to: stopInteger by: stepInteger.

"category: accessing"

- species
    "Answer the preferred class for reconstructing the receiver."
    ^ Array

- size
    "Answer the size of this Interval."
    step < 0
      ifTrue: [
        start < stop
          ifTrue: [ ^ 0. ]
          ifFalse: [ ^ stop - start // step + 1. ].
      ]
      ifFalse: [
        stop < start
          ifTrue: [ ^ 0. ]
          ifFalse: [ ^ stop - start // step + 1. ].
      ].

- at: index
    "Answer the element in this Interval at index."
    ^ (index >= 1 and: [ index <= self size ])
      ifTrue: [ start + (step * (index - 1)). ]
      ifFalse: [ self errorSubscriptBounds: index. ].

- at: index put: anObject
    self error: 'you cannot store into an Interval'.

"category: adding"

- add: anObject
    self error: 'elements cannot be added to an Interval'.

"category: removing"

- remove: anObject
    self error: 'elements cannot be removed from an Interval'.

"category: enumerating"

- do: aBlock
    "Evaluate aBlock for each element in the receiver."
    | aValue |
    aValue := start.
    step < 0
      ifTrue: [
        [ stop <= aValue ]
          whileTrue: [
            aBlock value: aValue.
            aValue := aValue + step.
          ].
      ]
      ifFalse: [
        [ stop >= aValue ]
          whileTrue: [
            aBlock value: aValue.
            aValue := aValue + step.
          ].
      ].

- collect: aBlock
    "Evaluate aBlock for each element in the receiver and collect the results into an Array."
    | nextValue i result |
    result := self species new: self size.
    nextValue := start.
    i := 1.
    step < 0
      ifTrue: [
        [ stop <= nextValue ]
          whileTrue: [
            result at: i put: (aBlock value: nextValue).
            nextValue := nextValue + step.
            i := i + 1.
          ].
      ]
      ifFalse: [
        [ stop >= nextValue ]
          whileTrue: [
            result at: i put: (aBlock value: nextValue).
            nextValue := nextValue + step.
            i := i + 1.
          ].
      ].
      ^ result.

"category: private"

- setFrom: startInteger to: stopInteger by: stepInteger
    "Set the start, stop and step for this Interval."
    start := startInteger.
    stop := stopInteger.
    step := stepInteger.
