Class {
	#name : 'Position',
	#superclass : 'Object',
	#instVars : [
		'position',
		'lap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Position class >> at: aStartingPosition withLaps: aNumberOfLaps [

	aStartingPosition < 1 ifTrue: [
		Error signal: 'Starting position cannot be less than one.' ].
	aNumberOfLaps < 1 ifTrue: [
		Error signal: 'Number of Laps cannot be less than one.' ].
	^ self new initializeAt: aStartingPosition withLaps: aNumberOfLaps
]

{ #category : 'initialization' }
Position >> initializeAt: startingPosition withLaps: laps [

	position := startingPosition.
	lap := laps
]

{ #category : 'comparing' }
Position >> isAheadOf: anotherPosition [

	lap > anotherPosition laps ifTrue: [ ^ true ].
	lap < anotherPosition laps ifTrue: [ ^ false ].
	^ position > anotherPosition tileIndex
]

{ #category : 'accessing' }
Position >> laps [

	^ lap
]

{ #category : 'moving' }
Position >> moveBy: aNumberOfSteps withNumberOfTiles: aNumberOfTiles [

	| indexedTile newLaps newTile |
	indexedTile := position - 1 + aNumberOfSteps.
	newLaps := lap + (indexedTile // aNumberOfTiles).
	newTile := indexedTile \\ aNumberOfTiles + 1.

	newLaps < 1 ifTrue: [ ^ self class at: 1 withLaps: 1 ].

	^ self class at: newTile withLaps: newLaps
]

{ #category : 'moving' }
Position >> resetToFirstTile [

	^ self class at: 1 withLaps: lap
]

{ #category : 'accessing' }
Position >> tileIndex [

	^ position
]
