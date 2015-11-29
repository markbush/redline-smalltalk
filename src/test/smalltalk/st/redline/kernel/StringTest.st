"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #StringTest.

- test
    self testSize.
    self testAt.
    self testAtPut.
    self testReplaceFromToWithStartingAt.
    self testConcatenation.

- testSize
    self assert: 'hello' size equals: 5 withMessage: 'should report length of string'.
    self assert: '' size equals: 0 withMessage: 'should report length of string'.

- testAt
    | aString |
    aString := 'Hello, World!'.
    self assert: (aString at: 3) equals: $l withMessage: 'should index a Character from a String'.
    self assert: (aString at: 6) equals: $, withMessage: 'should index a Character from a String'.

- testAtPut
    | aString |
    aString := 'hello, world.'.
    aString at: 1 put: $H.
    aString at: 8 put: $W.
    aString at: 13 put: $!.
    self assert: aString equals: 'Hello, World!' withMessage: 'should replace characters in the String'.

- testReplaceFromToWithStartingAt
    | aString |
    aString := 'Hello, there!'.
    aString replaceFrom: 8 to: 12 with: 'World' startingAt: 1.
    self assert: aString equals: 'Hello, World!' withMessage: 'should replace a subsequence'.

- testConcatenation
    | hello world |
    hello := 'Hello, '.
    world := 'World!'.
    self assert: hello , world equals: 'Hello, World!' withMessage: 'should be able to concatenate strings'.
