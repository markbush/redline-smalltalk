Object subclass: #Light
       instanceVariableNames: 'status index'
       classVariableNames: 'LightIndex'
       poolDictionaries: ''
       classInstanceVariableNames: ''.

"category: instance creation"

+ setOn
    ^ self new setOn.

+ setOff
    ^ self new setOff.

"category: status"

- turnOn
    self isOff
      ifTrue: [
        status := true.
        Transcript show: self; cr.
        self changed.
      ].

- turnOff
    self isOn
      ifTrue: [
        status := false.
        Transcript show: self; cr.
      ].

"category: testing"

- isOn
    ^ status.

- isOff
    ^ status not.

"category: change and update"

- update: aLight
    aLight == self ifFalse: [ self turnOff ].

"category: private"

+ initialize
    LightIndex := 1

- initialize
    super initialize.
    index := LightIndex.
    LightIndex := LightIndex + 1

- setOn
    status := true.

- setOff
    status := false.

- printOn: aStream
    aStream nextPutAll: 'Light '.
    aStream nextPutAll: index printString.
    aStream nextPut: $ .
    self isOn
      ifTrue: [ aStream nextPutAll: 'on' ]
      ifFalse: [ aStream nextPutAll: 'off' ].
