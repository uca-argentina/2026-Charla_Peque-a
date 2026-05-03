Class {
	#name : 'DiceTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTests >> test001WhenTheDiceIsRolledANumberIsReturned [

|aDice |

aDice := Dice withFaces: 6.

self assert: (aDice roll isNumber)
]

{ #category : 'tests' }
DiceTests >> test002WhenTheDiceIsRolledAPositiveNumberIsReturned [ 

|aDice |

aDice := Dice withFaces: 6.

self assert: (aDice roll strictlyPositive)


]

{ #category : 'tests' }
DiceTests >> test003WhenADiceWith6FacesIsRolledThenTheResultIsBetweenOneAndSix [ 

|aDice |

aDice := Dice withFaces: 6.

self assert: (aDice roll between: 1 and: 6)

]

{ #category : 'tests' }
DiceTests >> test004WhenTheNumberOfFacesIsEqualToZeroThenTheDiceIsNotCreated [ 

	self
		should: [ Dice withFaces: 0 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A dice cannot have less than three (3) faces.']
]

{ #category : 'tests' }
DiceTests >> test005WhenTheNumberOfFacesIsNegativeThenTheDiceIsNotCreated [ 

	self
		should: [ Dice withFaces: -8 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A dice cannot have less than three (3) faces.' ]

]

{ #category : 'tests' }
DiceTests >> test006WhenTheDiceHasLessThanThreeFacesThenTheDiceIsNotCreated [ 

self should:  [Dice withFaces: 2.] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'A dice cannot have less than three (3) faces.']

]
