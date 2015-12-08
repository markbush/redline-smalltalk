Object subclass: #TrafficLight
       instanceVariableNames: 'lights'
       classVariableNames: ''
       poolDictionaries: ''
       classInstanceVariableNames: ''.

"category: instance creation"

+ with: numberOfLights
    ^ self new lights: numberOfLights.

"category: operate"

- turnOn: lightNumber
    (lights at: lightNumber) turnOn.

"category: initialize-release"

- release
    super release.
    lights do: [ :eachLight | eachLight release ].
    lights := nil.

"category: private"

- lights: numberOfLights
    lights := Array new: (numberOfLights max: 1).
    lights at: 1 put: Light setOn.
    2 to: numberOfLights do: [ :index |
      lights at: index put: Light setOff
    ].
    lights do: [ :eachLight |
      lights do: [ :dependentLight |
        eachLight ~~ dependentLight
          ifTrue: [ eachLight addDependent: dependentLight ]
      ]
    ].
    ^ self.
