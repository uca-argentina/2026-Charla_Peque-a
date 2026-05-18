Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numberOfTiles',
		'tileEffects'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> withNumberOfTiles: aNumberOfTiles [

	aNumberOfTiles > 0 ifFalse: [
		Error signal: 'A Board must have at least one tile.' ].
	^ self new initializeWithNumberOfTiles: aNumberOfTiles
]

{ #category : 'effects' }
Board >> effectAt: aTileIndex [

	^ tileEffects at: aTileIndex
]

{ #category : 'position arithmetic' }
Board >> fromPosition: currentPosition advancing: steps [

	| indexedTile newLaps newSquare |
	indexedTile := currentPosition tile - 1 + steps.
	
	newLaps := currentPosition laps + (indexedTile // numberOfTiles).
	
	newSquare := indexedTile \\ numberOfTiles + 1.
	
	^ Position at: newSquare withLaps: newLaps
]

{ #category : 'initialization' }
Board >> initializeWithNumberOfTiles: aNumberOfTiles [

	numberOfTiles := aNumberOfTiles.
	tileEffects := OrderedCollection new.
	aNumberOfTiles timesRepeat: [ tileEffects add: NoEffect new ]
]

{ #category : 'movement' }
Board >> moveSpaceship: aSpaceship by: steps [
	"Desplazamiento puro (efectos encadenados, MoonWalk, etc.). No dispara efectos de casillero."

	aSpaceship position:
		(self fromPosition: aSpaceship position advancing: steps)
]

{ #category : 'movement' }
Board >> moveSpaceship: aSpaceship players: allPlayers advancing: steps [
	"Avanza por dados o turno. Al caer en un casillero, aplica su efecto una sola vez."

	self moveSpaceship: aSpaceship by: steps.
	(self effectAt: aSpaceship tile)
		applyTriggeredBy: aSpaceship
		in: allPlayers
		on: self
]

{ #category : 'effects' }
Board >> setEffect: anEffect atTile: aTileIndex [

	tileEffects at: aTileIndex put: anEffect
]
