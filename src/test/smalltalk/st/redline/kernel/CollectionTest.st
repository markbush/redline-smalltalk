"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #CollectionTest.

- test
    self testSize.

- testSize
    | array |
    array := #().
    self assert: array size equals: 0 withMessage: 'should have size 0'.
    array := #(1 3 5 7 9).
    self assert: array size equals: 5 withMessage: 'should have size 5'.
