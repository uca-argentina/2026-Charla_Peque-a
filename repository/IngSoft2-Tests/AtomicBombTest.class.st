Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombTest >> test001WhenSpaceshipLandsOnAtomicBombThenAllPlayersReturnToTileOne [

	| aBoard triggeringShip otherShip players |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: AtomicBomb new atTile: 5.
	triggeringShip := Spaceship named: 'Apollo'.
	otherShip := Spaceship named: 'Enterprise'.
	triggeringShip position: (Position at: 1 withLaps: 1).
	otherShip position: (Position at: 12 withLaps: 1).
	players := OrderedCollection with: triggeringShip with: otherShip.
	aBoard moveSpaceship: triggeringShip players: players advancing: 4.
	self assert: triggeringShip tile equals: 1.
	self assert: otherShip tile equals: 1
]

{ #category : 'tests' }
AtomicBombTest >> test002WhenAtomicBombExplodesThenLapsArePreserved [

	| aBoard triggeringShip otherShip players |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: AtomicBomb new atTile: 5.
	triggeringShip := Spaceship named: 'Apollo'.
	otherShip := Spaceship named: 'Enterprise'.
	triggeringShip position: (Position at: 3 withLaps: 2).
	otherShip position: (Position at: 15 withLaps: 1).
	players := OrderedCollection with: triggeringShip with: otherShip.
	aBoard moveSpaceship: triggeringShip players: players advancing: 2.
	self assert: triggeringShip tile equals: 1.
	self assert: triggeringShip laps equals: 2.
	self assert: otherShip tile equals: 1.
	self assert: otherShip laps equals: 1
]

{ #category : 'tests' }
AtomicBombTest >> test003WhenPlayingThroughGameThenAtomicBombResetsAllToFirstTile [

	| aGame firstShip secondShip aBoard aDiceCup |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: AtomicBomb new atTile: 5.
	firstShip := Spaceship named: 'Apollo'.
	secondShip := Spaceship named: 'Enterprise'.
	secondShip position: (Position at: 12 withLaps: 1).
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 4) }.
	aGame := Game
		         playedBy: {
				         firstShip.
				         secondShip }
		         reachingLaps: 3
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 1.
	self assert: (aGame positionOf: secondShip) equals: 1
]
