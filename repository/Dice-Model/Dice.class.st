Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfFaces'
	],
	#category : 'Dice-Model',
	#package : 'Dice-Model'
}

{ #category : 'as yet unclassified' }
Dice class >> withFaces: aNumberOfFaces [ 
	(aNumberOfFaces == 0) ifTrue: [Error signal: 'A Dice cannot have zero (0) number of faces.'.].
	(aNumberOfFaces  < 0) ifTrue: [ Error signal: 'A Dice cannot have a negative (<0) number of faces.'.].
	^(self new) initializeWithFaces: aNumberOfFaces . 
]

{ #category : 'initialization' }
Dice >> initializeWithFaces: aNumberOfFaces [  
	numberOfFaces := aNumberOfFaces . 
]

{ #category : 'as yet unclassified' }
Dice >> roll [
	^ (1 to: numberOfFaces) atRandom .
]
