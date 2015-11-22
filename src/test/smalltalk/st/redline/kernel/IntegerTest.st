"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #IntegerTest.

- test
    self testAddition.
    self testSubtraction.
    self testMultiplication.
    self testDivision.
    self testLessThan.
    self testLessThanOrEqual.
    self testGreaterThan.
    self testGreaterThanOrEqual.
    self testQuotient.

- testAddition
    self assert: 1 + 1 equals: 2 withMessage: '1 + 1 should equal 2'.
    self assert: 548137 + 0 equals: 548137 withMessage: '548137 + 0 should equal 548137'.
    self assert: 23 + -45 equals: -22 withMessage: '23 + -45 should equal -22'.
    self assert: -15 + 83 equals: 68 withMessage: '-15 + 83 should equal 68'.

- testSubtraction
    self assert: 1 - 1 equals: 0 withMessage: '1 - 1 should equal 0'.
    self assert: 548137 - 0 equals: 548137 withMessage: '548137 - 0 should equal 548137'.
    self assert: 23 - 45 equals: -22 withMessage: '23 - 45 should equal -22'.
    self assert: -15 - -83 equals: 68 withMessage: '-15 - -83 should equal 68'.

- testMultiplication
    self assert: 1 * 1 equals: 1 withMessage: '1 * 1 should equal 1'.
    self assert: 548137 * 0 equals: 0 withMessage: '548137 * 0 should equal 0'.
    self assert: 23 * -45 equals: -1035 withMessage: '23 * -45 should equal -1035'.
    self assert: -15 * -83 equals: 1245 withMessage: '-15 * -83 should equal 1245'.

- testDivision
    self assert: 1 / 1 equals: 1 withMessage: '1 / 1 should equal 1'.
    self assert: 0 / 548137 equals: 0 withMessage: '0 / 548137 should equal 0'.
    "Test generation of Fraction when class is implemented"

- testLessThan
    self assertTrue: 1 < 5 withMessage: 'should be true: 1 < 5'.
    self assertTrue: -5 < -1 withMessage: 'should be true: -5 < -1'.
    self assertTrue: -3 < 5 withMessage: 'should be true: -3 < 5'.
    self assertFalse: 5 < 1 withMessage: 'should be false: 5 < 1'.
    self assertFalse: -1 < -5 withMessage: 'should be false: -1 < -5'.
    self assertFalse: 5 < -3 withMessage: 'should be false: 5 < -3'.

- testLessThanOrEqual
    self assertTrue: 1 <= 5 withMessage: 'should be true: 1 <= 5'.
    self assertTrue: -5 <= -1 withMessage: 'should be true: -5 <= -1'.
    self assertTrue: -3 <= 5 withMessage: 'should be true: -3 <= 5'.
    self assertTrue: 1 <= 1 withMessage: 'should be true: 1 <= 1'.
    self assertTrue: -1 <= -1 withMessage: 'should be true: -1 <= -1'.
    self assertFalse: 5 <= 1 withMessage: 'should be false: 5 <= 1'.
    self assertFalse: -1 <= -5 withMessage: 'should be false: -1 <= -5'.
    self assertFalse: 5 <= -3 withMessage: 'should be false: 5 <= -3'.

- testGreaterThan
    self assertFalse: 1 > 5 withMessage: 'should be false: 1 > 5'.
    self assertFalse: -5 > -1 withMessage: 'should be false: -5 > -1'.
    self assertFalse: -3 > 5 withMessage: 'should be false: -3 > 5'.
    self assertTrue: 5 > 1 withMessage: 'should be true: 5 > 1'.
    self assertTrue: -1 > -5 withMessage: 'should be true: -1 > -5'.
    self assertTrue: 5 > -3 withMessage: 'should be true: 5 > -3'.

- testGreaterThanOrEqual
    self assertFalse: 1 >= 5 withMessage: 'should be false: 1 >= 5'.
    self assertFalse: -5 >= -1 withMessage: 'should be false: -5 >= -1'.
    self assertFalse: -3 >= 5 withMessage: 'should be false: -3 >= 5'.
    self assertTrue: 1 >= 1 withMessage: 'should be true: 1 >= 1'.
    self assertTrue: -1 >= -1 withMessage: 'should be true: -1 >= -1'.
    self assertTrue: 5 >= 1 withMessage: 'should be true: 5 >= 1'.
    self assertTrue: -1 >= -5 withMessage: 'should be true: -1 >= -5'.
    self assertTrue: 5 >= -3 withMessage: 'should be true: 5 >= -3'.

- testQuotient
    self assert: 9 // 4 equals: 2 withMessage: '9 // 4 should be 2'.
    self assert: -9 // 4 equals: -3 withMessage: '-9 // 4 should be -3'.
