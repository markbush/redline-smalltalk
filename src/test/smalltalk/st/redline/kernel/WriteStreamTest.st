"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #WriteStreamTest.

- test
    self testPosition.

- testPosition
    | aStream |
    aStream := WriteStream basicNew on: (Array new: 10).
    self assert: aStream position equals: 0 withMessage: 'should be at the beginning of the stream'.
    aStream nextPut: $a.
    self assert: aStream position equals: 1 withMessage: 'should be at the first element'.
