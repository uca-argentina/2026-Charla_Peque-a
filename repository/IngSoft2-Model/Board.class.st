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

{ #category : 'instance creation' }
Board >> fromPosition: currentPosition advancing: steps [

	| indexedTile newLaps newSquare |
	"Aritmética circular considerando base 1 para los casilleros"
	indexedTile := currentPosition tile - 1 + steps.

	"El // en Smalltalk divide truncando hacia menos infinito (ideal para vueltas negativas)"
	newLaps := currentPosition laps + (indexedTile // numberOfTiles).

	"El \\ en Smalltalk es el módulo que preserva el signo del divisor"
	newSquare := indexedTile \\ numberOfTiles + 1.

	^ Position at: newSquare withLaps: newLaps
]

{ #category : 'initialization' }
Board >> initializeWithNumberOfTiles: aNumberOfTiles [
	numberOfTiles := aNumberOfTiles 
]
