Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFaces'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Dice class >> withFaces: aNumberOfFaces [

	aNumberOfFaces < 3 ifTrue: [
		Error signal: 'A dice cannot have less than three (3) faces.' ].
	^ self new initializeWithFaces: aNumberOfFaces
]

{ #category : 'initialization' }
Dice >> initializeWithFaces: aNumberOfFaces [

	numberOfFaces := aNumberOfFaces
]

{ #category : 'game logic' }
Dice >> roll [

	^ (1 to: numberOfFaces) atRandom
]
