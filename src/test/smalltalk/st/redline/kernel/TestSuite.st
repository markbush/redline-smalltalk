"Redline Smalltalk, Copyright (c) James C. Ladd. All rights reserved. See LICENSE in the root of this distribution."

Object subclass: #TestSuite.

- run
    self show: '-------------------------------------------------------'.
    self show: '--- S m a l l t a l k  T e s t s'.
    self show: '-------------------------------------------------------'.
    self show: 'Running UndefinedObjectTests'.
    UndefinedObjectTest new test.
    self show: 'Running TrueTests'.
    TrueTest new test.
    self show: 'Running FalseTests'.
    FalseTest new test.
    self show: 'Running ObjectTests'.
    ObjectTest new test.
    self show: 'Running IntegerTests'.
    IntegerTest new test.
    self show: 'Running WriteStreamTests'.
    WriteStreamTest new test.
    self show: 'Running StringTests'.
    StringTest new test.
    self show: 'Running SequenceableCollectionTests'.
    SequenceableCollectionTest new test.
    self show: 'Running OrderedCollectionTests'.
    OrderedCollectionTest new test.
    self show: 'Running ArrayedCollectionTests'.
    ArrayedCollectionTest new test.
    self show: 'Running IntervalTests'.
    IntervalTest new test.
    self show: 'Running BagTests'.
    BagTest new test.
    self show: 'Running SetTests'.
    SetTest new test.
    self show: 'Running LookupKeyTests'.
    LookupKeyTest new test.
    self show: 'Running AssociationTests'.
    AssociationTest new test.
    self show: 'Running DictionaryTests'.
    DictionaryTest new test.

- show: message
    Transcript show: message; cr.
