"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

self import: 'st.redline.test.TestCase'.

TestCase subclass: #AssociationTest.

- test
    self testEquals.
    self testValueAccess.

- testEquals
    | anAssociation anotherAssociation |
    anAssociation := #theKey -> #theValue.
    self assert: anAssociation class equals: Association withMessage: 'should create an Association'.
    anotherAssociation := Association key: #theKey value: #theValue.
    self assertTrue: anotherAssociation = anAssociation withMessage: 'should be equal if equal components'.
    anotherAssociation := #theKey -> #otherValue.
    self assertFalse: anotherAssociation = anAssociation withMessage: 'should not be equal if unequal components'.
    anotherAssociation := #anotherKey -> #theValue.
    self assertFalse: anotherAssociation = anAssociation withMessage: 'should not be equal if unequal components'.

- testValueAccess
    | anAssociation |
    anAssociation := #theKey -> #theValue.
    self assert: anAssociation key equals: #theKey withMessage: 'should access the key'.
    self assert: anAssociation value equals: #theValue withMessage: 'should access the value'.
