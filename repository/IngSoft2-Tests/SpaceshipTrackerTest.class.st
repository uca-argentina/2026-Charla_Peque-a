Class {
	#name : 'SpaceshipTrackerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - movement' }
SpaceshipTrackerTest >> test001AShipStartsAtTheFirstTileOnTheFirstLap [

	| tracker ship |
	ship := 'Spaceship 1'.
	tracker := SpaceshipTracker
		           withShips: { ship }
		           numberOfTiles: 10
		           reachingLaps: 3.
	self assert: (tracker positionOf: ship) equals: 1.
	self assert: (tracker lapOf: ship) equals: 1
]

{ #category : 'tests - movement' }
SpaceshipTrackerTest >> test002MovingAShipAdvancesItsTile [

	| tracker ship |
	ship := 'Spaceship 1'.
	tracker := SpaceshipTracker
		           withShips: { ship }
		           numberOfTiles: 10
		           reachingLaps: 3.
	tracker move: ship by: 5.
	self assert: (tracker positionOf: ship) equals: 6
]

{ #category : 'tests - movement' }
SpaceshipTrackerTest >> test003MovingAllExceptDoesNotMoveTheExcludedShip [

	| tracker first second |
	first := 'Spaceship 1'.
	second := 'Spaceship 2'.
	tracker := SpaceshipTracker
		           withShips: {
				           first.
				           second }
		           numberOfTiles: 10
		           reachingLaps: 3.
	tracker moveAllExcept: first by: 3.
	self assert: (tracker positionOf: first) equals: 1.
	self assert: (tracker positionOf: second) equals: 4
]

{ #category : 'tests - movement' }
SpaceshipTrackerTest >> test004SendingAllToFirstTileKeepsTheLapCount [

	| tracker ship |
	ship := 'Spaceship 1'.
	tracker := SpaceshipTracker
		           withShips: { ship }
		           numberOfTiles: 10
		           reachingLaps: 5.
	tracker move: ship by: 14.
	self assert: (tracker lapOf: ship) equals: 2.
	tracker sendAllToFirstTile.
	self assert: (tracker positionOf: ship) equals: 1.
	self assert: (tracker lapOf: ship) equals: 2
]

{ #category : 'tests - winner' }
SpaceshipTrackerTest >> test005AShipThatExceedsTheTargetLapsBecomesTheWinner [

	| tracker ship |
	ship := 'Spaceship 1'.
	tracker := SpaceshipTracker
		           withShips: { ship }
		           numberOfTiles: 5
		           reachingLaps: 1.
	self deny: tracker hasWinner.
	tracker move: ship by: 6.
	self assert: tracker hasWinner.
	self assert: tracker winner equals: ship
]

{ #category : 'tests - ranking' }
SpaceshipTrackerTest >> test006RankingOrdersShipsFromFirstToLast [

	| tracker first second ranking |
	first := 'Spaceship 1'.
	second := 'Spaceship 2'.
	tracker := SpaceshipTracker
		           withShips: {
				           first.
				           second }
		           numberOfTiles: 10
		           reachingLaps: 5.
	tracker move: first by: 5.
	ranking := tracker rankingOf: {
			           first.
			           second }.
	self assert: ranking first equals: first.
	self assert: ranking last equals: second
]
