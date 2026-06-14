Class {
	#name : 'ParsecConverter',
	#superclass : 'Object',
	#instVars : [
		'totalParsecs',
		'numberOfTiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ParsecConverter class >> withTotalParsecs: aTotalParsecs numberOfTiles: aNumberOfTiles [

	aTotalParsecs <= 0 ifTrue: [
		Error signal: 'Total parsecs must be positive.' ].
	aNumberOfTiles <= 0 ifTrue: [
		Error signal: 'Number of tiles must be positive.' ].
	^ self new
		  initializeWithTotalParsecs: aTotalParsecs
		  numberOfTiles: aNumberOfTiles
]

{ #category : 'initialization' }
ParsecConverter >> initializeWithTotalParsecs: aTotalParsecs numberOfTiles: aNumberOfTiles [

	totalParsecs := aTotalParsecs.
	numberOfTiles := aNumberOfTiles
]

{ #category : 'converting' }
ParsecConverter >> tilesForParsecs: aParsecs [

	"Each tile represents an equal share of the total parsecs of the board.
	 The result is truncated: a jump shorter than one full tile moves zero tiles."

	^ (aParsecs * numberOfTiles / totalParsecs) truncated
]
