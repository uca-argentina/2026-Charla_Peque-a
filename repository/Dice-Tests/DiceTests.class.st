Class {
	#name : 'DiceTests',
	#superclass : 'TestCase',
	#category : 'Dice-Tests',
	#package : 'Dice-Tests'
}

{ #category : 'tests' }
DiceTests >> test001WhenTheDiceIsRolledANumberIsReturned [

|aDice |

aDice := Dice new.

self assert: (aDice roll isNumber)
]

{ #category : 'tests' }
DiceTests >> test002WhenTheDiceIsRolledAPositiveNumberIsReturned [

|aDice |

aDice := Dice new.

self assert: (aDice roll strictlyPositive)
]
