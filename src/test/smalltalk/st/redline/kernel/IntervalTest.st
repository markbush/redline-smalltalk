"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #IntervalTest.

- test
    self testSize.
    self testAt.
    self testDo.
    self testCollect.

- testSize
    | interval |
    interval := Interval from: 1 to: 5.
    self assert: interval size equals: 5 withMessage: 'should have size 5'.
    interval := Interval from: 1 to: 5 by: 2.
    self assert: interval size equals: 3 withMessage: 'should have size 3'.
    interval := Interval from: 9 to: 2 by: -3.
    self assert: interval size equals: 3 withMessage: 'should have size 3'.

- testAt
    | interval |
    interval := Interval from: 1 to: 5.
    self assert: (interval at: 1) equals: 1 withMessage: 'should have 1 at: 1'.
    self assert: (interval at: 2) equals: 2 withMessage: 'should have 2 at: 2'.
    self assert: (interval at: 5) equals: 5 withMessage: 'should have 5 at: 5'.
    interval := Interval from: 1 to: 5 by: 2.
    self assert: (interval at: 1) equals: 1 withMessage: 'should have 1 at: 1'.
    self assert: (interval at: 2) equals: 3 withMessage: 'should have 3 at: 2'.
    self assert: (interval at: 3) equals: 5 withMessage: 'should have 5 at: 3'.
    interval := Interval from: 9 to: 2 by: -3.
    self assert: (interval at: 1) equals: 9 withMessage: 'should have 9 at: 1'.
    self assert: (interval at: 2) equals: 6 withMessage: 'should have 6 at: 2'.
    self assert: (interval at: 3) equals: 3 withMessage: 'should have 3 at: 3'.

- testDo
    | interval result |
    interval := Interval from: 1 to: 5.
    result := 0.
    interval do: [ :each | result := result + each. ].
    self assert: result equals: 15 withMessage: 'should sum to 15'.
    interval := Interval from: 1 to: 5 by: 2.
    result := 0.
    interval do: [ :each | result := result + each. ].
    self assert: result equals: 9 withMessage: 'should sum to 9'.
    interval := Interval from: 9 to: 2 by: -3.
    result := 0.
    interval do: [ :each | result := result + each. ].
    self assert: result equals: 18 withMessage: 'should sum to 18'.

- testCollect
    | interval result |
    interval := Interval from: 1 to: 5.
    result := interval collect: [ :each | each * 2 ].
    self assert: result class equals: Array withMessage: 'should collect into an Array'.
    self assert: result equals: #(2 4 6 8 10) withMessage: 'should produce Array of double values'.
    interval := Interval from: 1 to: 5 by: 2.
    result := interval collect: [ :each | each * each ].
    self assert: result equals: #(1 9 25) withMessage: 'should produce Array of squared values'.
    interval := Interval from: 9 to: 2 by: -3.
    result := interval collect: [ :each | each + 5 ].
    self assert: result equals: #(14 11 8) withMessage: 'should produce Array of values incremented by 5'.
