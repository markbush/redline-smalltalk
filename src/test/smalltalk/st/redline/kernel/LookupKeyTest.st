"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #LookupKeyTest.

- test
    self testKeyAccess.
    self testLessThan.
    self testHash.

- testKeyAccess
    | aLookupKey |
    aLookupKey := LookupKey key: #HelloWorld.
    self assert: aLookupKey key equals: #HelloWorld withMessage: 'should have the correct key'.

- testLessThan
    | smaller larger |
    smaller := LookupKey key: 10.
    larger := LookupKey key: 20.
    self assertTrue: smaller < larger withMessage: 'should compare different keys'.
    larger := LookupKey key: 10.
    self assertFalse: smaller < larger withMessage: 'should find equal keys to not be different'.

- testHash
    | key aLookupKey |
    key := 'Hello World'.
    aLookupKey := LookupKey key: key.
    self assert: aLookupKey hash equals: key hash withMessage: 'should hash to the same as the key'.
