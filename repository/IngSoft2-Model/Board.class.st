Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numberOfTiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> withNumberOfTiles: aNumberOfTiles [
	aNumberOfTiles > 0 ifFalse: [ Error signal: 'A Board must have at least one tile.' ].
	^ (self new) initializeWithNumberOfTiles: aNumberOfTiles 
]

{ #category : 'initialization' }
Board >> initializeWithNumberOfTiles: aNumberOfTiles [
	numberOfTiles := aNumberOfTiles 
]
