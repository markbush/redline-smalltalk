"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #NumberTest.

- test
    self testTo.
    self testToBy.
    self testToDo.
    self testToDoBy.

- testTo
    | interval |
    interval := 1 to: 5.
    self assert: interval class equals: Interval withMessage: 'should create an interval'.
    self assert: interval size equals: 5 withMessage: 'should have size 5'.

- testToBy
    | interval |
    interval := 1 to: 5 by: 3.
    self assert: interval class equals: Interval withMessage: 'should create an interval'.
    self assert: interval size equals: 2 withMessage: 'should have size 2'.
    interval := 9 to: -5 by: -4.
    self assert: interval size equals: 4 withMessage: 'should have size 4'.

- testToDo
    | result |
    result := 0.
    1 to: 5 do: [ :each | result := result + each. ].
    self assert: result equals: 15 withMessage: 'should sum range to 15'.

- testToByDo
    | result |
    result := 0.
    -7 to: 5 by: 2 do: [ :each | result := result + each. ].
    self assert: result equals: 5 withMessage: 'should sum range to 5'.
    result := 0.
    18 to: -25 by: -3 do: [ :each | result := result + each. ].
    self assert: result equals: -45 withMessage: 'should sum range to -45'.
