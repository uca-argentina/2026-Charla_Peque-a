Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'tiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> withTiles: aTileCollection [

	aTileCollection isEmpty ifTrue: [
		Error signal: 'A Board must have at least one tile.' ].
	(aTileCollection allSatisfy: [ :each | each isKindOf: Tile ]) ifFalse: [
		Error signal: 'All elements of a Board must be tiles.' ].
	^ self new initializeWithTiles: aTileCollection

]

{ #category : 'accessing' }
Board >> TileAt: aTileIndex [

	^ tiles at: aTileIndex
]

{ #category : 'instance creation' }
Board >> applyEffectFor: aSpaceship on: aGame [

	| position tile |
	position := (aGame positionOf: aSpaceship).
	tile := tiles at: position .
	tile applyOn: aGame
]

{ #category : 'instance creation' }
Board >> fromPosition: currentPosition advancing: steps [

	| indexedTile newLaps newSquare numberOfTiles |
	"Aritmética circular considerando base 1 para los casilleros"
	numberOfTiles := tiles size.
	indexedTile := currentPosition tile - 1 + steps.

	"El // en Smalltalk divide truncando hacia menos infinito (ideal para vueltas negativas)"
	newLaps := currentPosition laps + (indexedTile // numberOfTiles).

	"El \\ en Smalltalk es el módulo que preserva el signo del divisor"
	newSquare := indexedTile \\ numberOfTiles + 1.

	"Si por un retroceso la nave intentaría ir antes del inicio del juego (lap < 1),
	hacemos clamp en (tile=1, lap=1). Una nave no puede retroceder antes de la salida."
	newLaps < 1 ifTrue: [ ^ Position at: 1 withLaps: 1 ].

	^ Position at: newSquare withLaps: newLaps
]

{ #category : 'initialization' }
Board >> initializeWithTiles: aTileCollection [

	tiles := aTileCollection
]

{ #category : 'accessing' }
Board >> numberOfTiles [

	^ tiles size
]
