Class {
	#name : 'SpaceshipTracker',
	#superclass : 'Object',
	#instVars : [
		'positions',
		'numberOfTiles',
		'lapsToReach',
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
SpaceshipTracker class >> withShips: aSpaceshipCollection numberOfTiles: aNumberOfTiles reachingLaps: aNumberOfLaps [

	^ self new
		  initializeWithShips: aSpaceshipCollection
		  numberOfTiles: aNumberOfTiles
		  reachingLaps: aNumberOfLaps
]

{ #category : 'private' }
SpaceshipTracker >> checkWinner: aSpaceship [

	(positions at: aSpaceship) laps > lapsToReach ifTrue: [
		winner := aSpaceship ]
]

{ #category : 'testing' }
SpaceshipTracker >> hasWinner [

	^ winner notNil
]

{ #category : 'initialization' }
SpaceshipTracker >> initializeWithShips: aSpaceshipCollection numberOfTiles: aNumberOfTiles reachingLaps: aNumberOfLaps [

	numberOfTiles := aNumberOfTiles.
	lapsToReach := aNumberOfLaps.
	winner := nil.
	positions := Dictionary new.
	aSpaceshipCollection do: [ :aShip |
		positions at: aShip put: (Position at: 1 withLaps: 1) ]
]

{ #category : 'accessing' }
SpaceshipTracker >> lapOf: aSpaceship [

	^ (positions at: aSpaceship) laps
]

{ #category : 'moving' }
SpaceshipTracker >> move: aSpaceship by: aNumberOfSteps [

	| newPosition |
	newPosition := (positions at: aSpaceship)
		               moveBy: aNumberOfSteps
		               withNumberOfTiles: numberOfTiles.
	positions at: aSpaceship put: newPosition.
	self checkWinner: aSpaceship
]

{ #category : 'moving' }
SpaceshipTracker >> moveAllExcept: aSpaceship by: aNumberOfSteps [

	positions keysDo: [ :each |
		each = aSpaceship ifFalse: [ self move: each by: aNumberOfSteps ] ]
]

{ #category : 'accessing' }
SpaceshipTracker >> positionOf: aSpaceship [

	^ (positions at: aSpaceship) tileIndex
]

{ #category : 'ranking' }
SpaceshipTracker >> rankingOf: aSpaceshipCollection [

	^ aSpaceshipCollection asSortedCollection: [ :shipA :shipB |
		  (positions at: shipA) isAheadOf: (positions at: shipB) ]
]

{ #category : 'moving' }
SpaceshipTracker >> sendAllToFirstTile [

	positions keysAndValuesDo: [ :ship :position |
		positions at: ship put: position resetToFirstTile ]
]

{ #category : 'accessing' }
SpaceshipTracker >> winner [

	^ winner
]
