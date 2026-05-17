Class {
	#name : 'DiceCupTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceCupTest >> test001WhenADiceCupIsCreatedWithOneDiceThenRollReturnsAValidNumber [

	| aDiceCup |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	self assert: aDiceCup roll equals: 6
]

{ #category : 'tests' }
DiceCupTest >> test002WhenADiceCupHasTwoDiceThenTheRollReturnsTheSumOfBothRollResults [

	| aDiceCup |
	aDiceCup := DiceCup withDice: {
			            (LoadedDice withForcedResult: 6).
			            (LoadedDice withForcedResult: 6) }.
	self assert: aDiceCup roll equals: 12
]

{ #category : 'tests' }
DiceCupTest >> test003WhenADiceCupIsCreatedEmptyThenItCannotBeCreated [

	self
		should: [ DiceCup withDice: {  } ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'A dice cup cannot be empty.' ]
]
