"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Number subclass: #Integer.

"category: arithmetic"

- + aNumber
    "Answer the sum of the receiver and the argument, aNumber."
    <primitive: 21>.

- - aNumber
    "Answer the difference between the receiver and the argument, aNumber."
    <primitive: 22>.

- * aNumber
    "Answer the result of multiplying the receiver by the argument, aNumber."
    <primitive: 29>.

- / aNumber
    "Answer the result of dividing the receiver by the argument, aNumber. Note that since as much precision as possible
     is retained, if the division is not exact, the result will be an instance of Fraction."
    <primitive: 30>.

- // aNumber
    "Answer the quotient of dividing the receiver by the argument, aNumber with truncation towards negative infinity."
    <primitive: 32>.

- \\ aNumber
    "Answer the integer remainder defined by division with truncation toward negative infinity. This is the modulo
     operation."
    <primitive: 31>.

- reciprocal
    ^ 1 / self

- negated
    ^ 0 - self

"category: mathematical functions"

- raisedToInteger: anInteger
    | result |
    anInteger negative ifTrue: [ ^ (self raisedToInteger: anInteger negated) reciprocal ].
    result := 1.
    anInteger timesRepeat: [ result := result * self ].
    ^ result.

"category: comparing"

- = aNumber
    "Answer if aNumber is equal to the receiver. The Blue Book specifies this primitive for SmallInteger,
     however we are not implementing that class so can use it here."
    <primitive: 27>.

- < aNumber
    "Answer whether the receiver is less than the argument."
    <primitive: 23>.

- <= aNumber
    "Answer whether the receiver is less than the argument."
    <primitive: 25>.

- > aNumber
    "Answer whether the receiver is less than the argument."
    <primitive: 24>.

- >= aNumber
    "Answer whether the receiver is less than the argument."
    <primitive: 26>.

- hash
    ^ self.

"category: testing"

- negative
    ^ self < 0

"category: factorization and divisibility"

- factorial
    "Answer the factorial of the receiver. The receiver must not be less than 0."
    self notImplementedYet.

- gcd: anInteger
    "Answer the greatest common divisor of the receiver and the argument, anInteger."
    self notImplementedYet.

- lcm: anInteger
    "Answer the least common multiple of the receiver and the argument, anInteger."
    self notImplementedYet.

"category: bit manipulation"

- allMask: anInteger
    "Treat the argument anInteger as a bit mask. Answer whether all of the bits that are 1 in anInteger are 1 in the
     receiver."
    self notImplementedYet.

- anyMask: anInteger
    "Treat the argument anInteger as a bit mask. Answer whether any of the bits that are 1 in anInteger are 1 in the
     receiver."
    self notImplementedYet.

- noMask: anInteger
    "Treat the argument anlnteger as a bit mask. Answer whether none of the bits that are 1 in anInteger are 1 in the
     receiver."
    self notImplementedYet.

- bitAnd: anInteger
    "Answer an Integer whose bits are the logical and of the receiver's bits and those of the argument anInteger."
    self notImplementedYet.

- bitOr: anInteger
    "Answer an Integer whose bits are the logical or of the receiver's bits and those of the argument anInteger."
    self notImplementedYet.

- bitXor: anInteger
    "Answer an Integer whose bits are the logical xor of the receiver's bits and those of the argument anInteger."
    self notImplementedYet.

- bitAt: index
    "Answer the bit (0 or 1) at position index of the receiver."
    self notImplementedYet.

- bitInvert
    "Answer an Integer whose bits are the complement of the receiver."
    self notImplementedYet.

- highBit
    "Answer the index of the high order bit of the binary representation of the receiver."
    self notImplementedYet.

- bitShift: anInteger
    "Answer an Integer whose value (in two's-complement representation) is the receiver's value (in two's-complement
     representation) shifted left by the number of bits indicated by the argument, anInteger. Negative arguments shift
     right. Zeros are shifted in from the right in left shifts. The sign bit is extended in right shifts."
    self notImplementedYet.

"category: enumerating"

- timesRepeat: aBlock
    | count |
    count := 1.
    [count <= self]
      whileTrue: [
        aBlock value.
        count := count + 1
      ].

"category: printing"

- printOn: aStream base: base
    ^ self printOn: aStream base: base length: 0 padded: false

- printOn: aStream base: base length: minimumLength padded: padWithZeroes
    | n numberOfDigits totalLength divisor |
    self < 0
      ifTrue: [ n := self negated. totalLength := 1 ]
      ifFalse: [ n := self. totalLength := 0 ].
    numberOfDigits := n numberOfDigitsInBase: base.
    totalLength := totalLength + numberOfDigits.
    padWithZeroes ifFalse: [
      [ totalLength < minimumLength ]
        whileTrue: [ aStream space. totalLength := totalLength + 1 ]
    ].
    n = self ifFalse: [ aStream nextPut: $- ].
    padWithZeroes
      ifTrue: [
        [ totalLength < minimumLength ]
          whileTrue: [ aStream nextPut: $0. totalLength := totalLength + 1 ]
      ].
    divisor := (base raisedToInteger: numberOfDigits - 1).
    [ divisor > 0 ]
      whileTrue: [
        | digit |
        digit := n // divisor.
        aStream nextPut: ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ' at: digit + 1).
        n := n - (digit * divisor).
        divisor := divisor // base
      ].

- numberOfDigitsInBase: base
    | n digits |
    n := 1.
    digits := 1.
    [ (n * base) <= self ]
      whileTrue: [ n := n * base. digits := digits + 1. ].
    ^ digits.
