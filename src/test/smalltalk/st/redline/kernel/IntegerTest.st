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
    self testPrintString.
    self testNumberOfDigitsInBase.
    self testReciprocal.
    self testNegated.
    self testRaisedToInteger.
    self testNegative.
    self testMin.
    self testMax.

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

- testPrintString
    | result |
    result := 1 printString.
    self assert: result equals: '1' withMessage: 'should produce correct string for 1'.
    result := 476 printString.
    self assert: result equals: '476' withMessage: 'should produce correct string for 476'.
    result := -24 printString.
    self assert: result equals: '-24' withMessage: 'should produce correct string for -24'.

- testNumberOfDigitsInBase
    | result |
    result := 0 numberOfDigitsInBase: 10.
    self assert: result equals: 1 withMessage: 'should need 1 digit to display 0 in base 10'.
    result := 1 numberOfDigitsInBase: 10.
    self assert: result equals: 1 withMessage: 'should need 1 digit to display 1 in base 10'.
    result := 9 numberOfDigitsInBase: 10.
    self assert: result equals: 1 withMessage: 'should need 1 digit to display 9 in base 10'.
    result := 10 numberOfDigitsInBase: 10.
    self assert: result equals: 2 withMessage: 'should need 2 digits to display 10 in base 10'.
    result := 999 numberOfDigitsInBase: 10.
    self assert: result equals: 3 withMessage: 'should need 3 digits to display 999 in base 10'.
    result := 1000 numberOfDigitsInBase: 10.
    self assert: result equals: 4 withMessage: 'should need 4 digits to display 1000 in base 10'.
    result := 0 numberOfDigitsInBase: 2.
    self assert: result equals: 1 withMessage: 'should need 1 digit to display 0 in base 2'.
    result := 1 numberOfDigitsInBase: 2.
    self assert: result equals: 1 withMessage: 'should need 1 digit to display 1 in base 2'.
    result := 2 numberOfDigitsInBase: 2.
    self assert: result equals: 2 withMessage: 'should need 2 digit to display 2 in base 2'.
    result := 7 numberOfDigitsInBase: 2.
    self assert: result equals: 3 withMessage: 'should need 3 digits to display 7 in base 2'.
    result := 15 numberOfDigitsInBase: 2.
    self assert: result equals: 4 withMessage: 'should need 4 digits to display 15 in base 2'.
    result := 16 numberOfDigitsInBase: 2.
    self assert: result equals: 5 withMessage: 'should need 5 digits to display 16 in base 2'.
    result := 0 numberOfDigitsInBase: 16.
    self assert: result equals: 1 withMessage: 'should need 1 digit to display 0 in base 16'.
    result := 1 numberOfDigitsInBase: 16.
    self assert: result equals: 1 withMessage: 'should need 1 digit to display 1 in base 16'.
    result := 15 numberOfDigitsInBase: 16.
    self assert: result equals: 1 withMessage: 'should need 1 digit to display 15 in base 16'.
    result := 16 numberOfDigitsInBase: 16.
    self assert: result equals: 2 withMessage: 'should need 2 digits to display 16 in base 16'.
    result := 4095 numberOfDigitsInBase: 16.
    self assert: result equals: 3 withMessage: 'should need 3 digits to display 4095 in base 16'.
    result := 4096 numberOfDigitsInBase: 16.
    self assert: result equals: 4 withMessage: 'should need 4 digits to display 4096 in base 16'.

- testReciprocal
    self assert: 1 reciprocal equals: 1 withMessage: 'reciprocal of 1 should be 1'.
    self assert: 5 reciprocal equals: 0.2 withMessage: 'reciprocal of 5 should be 0.2'.

- testNegated
    self assert: 0 negated equals: 0 withMessage: 'negative of 0 should be 0'.
    self assert: 5 negated equals: -5 withMessage: 'negative of 5 should be -5'.
    self assert: -23 negated equals: 23 withMessage: 'negative of -23 should be 23'.

- testRaisedToInteger
    self assert: (5 raisedToInteger: 0) equals: 1 withMessage: 'number raised to 0 power should be 1'.
    self assert: (5 raisedToInteger: 1) equals: 5 withMessage: 'number raised to power 1 should be itself'.
    self assert: (5 raisedToInteger: 2) equals: 25 withMessage: '5 raised to power 2nd should be 25'.
    self assert: (5 raisedToInteger: 4) equals: 625 withMessage: '5 raised to power 4th should be 625'.
    self assert: (5 raisedToInteger: -1) equals: 0.2 withMessage: '5 raised to power -1 should be 0.2'.

- testNegative
    self assertFalse: 0 negative withMessage: '0 should not be negative'.
    self assertTrue: -57 negative withMessage: 'negative number should be negative'.
    self assertFalse: 286 negative withMessage: 'positive number should not be negative'.

- testMin
    self assert: (3 min: 5) equals: 3 withMessage: 'min of 3 and 5 should be 3'.
    self assert: (-3 min: -5) equals: -5 withMessage: 'min of -3 and -5 should be -5'.

- testMax
    self assert: (3 max: 5) equals: 5 withMessage: 'max of 3 and 5 should be 5'.
    self assert: (-3 max: -5) equals: -3 withMessage: 'max of -3 and -5 should be -3'.
