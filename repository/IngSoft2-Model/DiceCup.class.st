Class {
	#name : 'DiceCup',
	#superclass : 'Object',
	#instVars : [
		'dice'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
DiceCup class >> withDice: aCollectionOfDice [

	aCollectionOfDice isEmpty ifTrue: [
		Error signal: 'A dice cup cannot be empty.' ].
	^ self new initializeWithDice: aCollectionOfDice
]

{ #category : 'initialization' }
DiceCup >> initializeWithDice: aCollectionOfDice [

	dice := aCollectionOfDice asOrderedCollection copy
]

{ #category : 'game logic' }
DiceCup >> roll [

	^ dice sum: [ :aDice | aDice roll ]
]
