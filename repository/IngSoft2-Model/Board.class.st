Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> withTiles: aTileCollection [

	aTileCollection isEmpty ifTrue: [
		Error signal: 'A Board must have at least one tile.' ].
	(aTileCollection allSatisfy: [ :each | each class == Tile ])
		ifFalse: [ Error signal: 'All elements of a Board must be tiles.' ].
	^ self new initializeWithTiles: aTileCollection
]

{ #category : 'accessing' }
Board >> effectAt: aTileIndex [

	^ (tiles at: aTileIndex) effect
]

{ #category : 'initialization' }
Board >> initializeWithTiles: aTileCollection [

	tiles := aTileCollection asOrderedCollection copy
]

{ #category : 'accessing' }
Board >> numberOfTiles [

	^ tiles size
]

{ #category : 'accessing' }
Board >> tileAt: aTileIndex [

	^ tiles at: aTileIndex
]

{ #category : 'accessing' }
Board >> tileFor: aPosition [

	^ tiles at: aPosition
]
