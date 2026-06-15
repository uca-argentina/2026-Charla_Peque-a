Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - game logic' }
DiceTest >> test001WhenTheDiceIsRolledANumberIsReturned [

	| aDice |
	aDice := Dice withFaces: 6.
	self assert: aDice roll isNumber
]

{ #category : 'tests - game logic' }
DiceTest >> test002WhenTheDiceIsRolledAPositiveNumberIsReturned [

	| aDice |
	aDice := Dice withFaces: 6.
	self assert: aDice roll strictlyPositive
]

{ #category : 'tests - game logic' }
DiceTest >> test003WhenADiceWith6FacesIsRolledThenTheResultIsBetweenOneAndSix [

	| aDice |
	aDice := Dice withFaces: 6.
	self assert: (aDice roll between: 1 and: 6)
]

{ #category : 'tests - instance creation' }
DiceTest >> test004WhenTheNumberOfFacesIsEqualToZeroThenTheDiceIsNotCreated [

	self
		should: [ Dice withFaces: 0 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A dice cannot have less than three (3) faces.' ]
]

{ #category : 'tests - instance creation' }
DiceTest >> test005WhenTheNumberOfFacesIsNegativeThenTheDiceIsNotCreated [

	self
		should: [ Dice withFaces: -8 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A dice cannot have less than three (3) faces.' ]
]

{ #category : 'tests - instance creation' }
DiceTest >> test006WhenTheDiceHasLessThanThreeFacesThenTheDiceIsNotCreated [

	self
		should: [ Dice withFaces: 2 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A dice cannot have less than three (3) faces.' ]
]
