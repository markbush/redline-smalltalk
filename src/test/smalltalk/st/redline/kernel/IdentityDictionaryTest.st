"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #IdentityDictionaryTest.

- test
    self testStringKeys.
    self testSymbolKeys.
    self testObjectKeys.
    self testIncludes.

- testStringKeys
    | aDictionary key1 key2 key3 |
    aDictionary := IdentityDictionary new.
    key1 := 'a string'.
    key2 := 'a string'.
    key3 := 'a string'.
    aDictionary at: key1 put: 1.
    aDictionary at: key2 put: 2.
    self assert: aDictionary size equals: 2 withMessage: 'should contain 2 distinct elements'.
    self assertTrue: (aDictionary includesKey: key1) withMessage: 'should contain keys specifically added'.
    self assertFalse: (aDictionary includesKey: key3) withMessage: 'should not contain equal keys not specifically added'.
    self assert: (aDictionary at: key1) equals: 1 withMessage: 'should find key1 based on key identity'.
    self assert: (aDictionary at: key2) equals: 2 withMessage: 'should find key2 based on key identity'.

- testSymbolKeys
    | aDictionary key1 key2 key3 |
    aDictionary := IdentityDictionary new.
    key1 := #aSymbol.
    key2 := #aSymbol.
    key3 := #aSymbol.
    aDictionary at: key1 put: 1.
    aDictionary at: key2 put: 2.
    self assert: aDictionary size equals: 1 withMessage: 'should contain 1 distinct element'.
    self assertTrue: (aDictionary includesKey: key1) withMessage: 'should contain keys specifically added'.
    self assertTrue: (aDictionary includesKey: key3) withMessage: 'should contain equal Symbol as they are unique'.
    self assert: (aDictionary at: key1) equals: 2 withMessage: 'should override key2 as equal Symbols are identical'.
    self assert: (aDictionary at: key2) equals: 2 withMessage: 'should find key2 based on key identity'.

- testObjectKeys
    | aDictionary key1 key2 key3 |
    aDictionary := IdentityDictionary new.
    key1 := IdentityDictionaryTest new.
    key2 := IdentityDictionaryTest new.
    key3 := IdentityDictionaryTest new.
    aDictionary at: key1 put: 1.
    aDictionary at: key2 put: 2.
    self assert: aDictionary size equals: 2 withMessage: 'should contain 2 distinct elements'.
    self assertTrue: (aDictionary includesKey: key1) withMessage: 'should contain keys specifically added'.
    self assertFalse: (aDictionary includesKey: key3) withMessage: 'should not contain equal keys not specifically added'.
    self assert: (aDictionary at: key1) equals: 1 withMessage: 'should find key1 based on key identity'.
    self assert: (aDictionary at: key2) equals: 2 withMessage: 'should find key2 based on key identity'.

- testIncludes
    | aDictionary aString aSymbol |
    aDictionary := IdentityDictionary new.
    aString := 'a string'.
    aSymbol := #aSymbol.
    aDictionary at: 1 put: aString.
    aDictionary at: 2 put: aSymbol.
    self assertTrue: (aDictionary includes: aString) withMessage: 'should include specific string'.
    self assertFalse: (aDictionary includes: 'a string') withMessage: 'should not include if just equivalent'.
    self assertTrue: (aDictionary includes: aSymbol) withMessage: 'should include specific symbol'.
    self assertTrue: (aDictionary includes: #aSymbol) withMessage: 'should include equivalent symbol'.
