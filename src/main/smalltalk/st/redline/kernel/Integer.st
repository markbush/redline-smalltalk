"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Number subclass: #Integer.

"category: arithmetic"

- + aNumber
    "Answer the sum of the receiver and the argument, aNumber."
    <primitive: 1>.

- - aNumber
    "Answer the difference between the receiver and the argument, aNumber."
    <primitive: 2>.

- * aNumber
    "Answer the result of multiplying the receiver by the argument, aNumber."
    <primitive: 9>.

- / aNumber
    "Answer the result of dividing the receiver by the argument, aNumber. Note that since as much precision as possible
     is retained, if the division is not exact, the result will be an instance of Fraction."
    <primitive: 10>.

- // aNumber
    "Answer the quotient of dividing the receiver by the argument, aNumber with truncation towards negative infinity."
    <primitive: 32>.

"category: comparing"

- = aNumber
    "Answer if aNumber is equal to the receiver. The Blue Book specifies this primitive for SmallInteger,
     however we are not implementing that class so can use it here."
    <primitive: 7>.

- < aNumber
    "Answer whether the receiver is less than the argument."
    <primitive: 3>.

- <= aNumber
    "Answer whether the receiver is less than the argument."
    <primitive: 5>.

- > aNumber
    "Answer whether the receiver is less than the argument."
    <primitive: 4>.

- >= aNumber
    "Answer whether the receiver is less than the argument."
    <primitive: 6>.

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
