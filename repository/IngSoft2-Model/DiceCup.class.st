Class {
	#name : 'DiceCup',
	#superclass : 'Object',
	#instVars : [
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DiceCup class >> withDices: aCollectionOfDice [

	aCollectionOfDice isEmpty ifTrue: [
		Error signal: 'A dice cup cannot be empty.' ].
	^ self new initializeWithDice: aCollectionOfDice
]

{ #category : 'initialization' }
DiceCup >> initializeWithDice: aCollectionOfDice [
	dice:= aCollectionOfDice.
	
]

{ #category : 'as yet unclassified' }
DiceCup >> roll [
^ dice sum: [:aDice | aDice roll].
]
