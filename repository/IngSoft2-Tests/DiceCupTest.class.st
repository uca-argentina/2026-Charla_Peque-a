Class {
	#name : 'DiceCupTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceCupTest >> test001WhenADiceCupIsCreatedWithOneDiceThenRollReturnsANumberInRange [
 
	| aDiceCup |
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	self assert: (aDiceCup roll between: 1 and: 6)
]

{ #category : 'tests' }
DiceCupTest >> test002WhenADiceCupHasTwoDiceThenRollReturnsSumInRange [
 
	| aDiceCup |
	aDiceCup := DiceCup withDices: { Dice withFaces: 6. Dice withFaces: 3 }.
	self assert: (aDiceCup roll between: 2 and: 9)
]

{ #category : 'tests' }
DiceCupTest >> test003WhenADiceCupIsCreatedEmptyThenItCannotBeCreated [
 
	self
		should: [ DiceCup withDices: {} ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'A dice cup cannot be empty.' ]
]
