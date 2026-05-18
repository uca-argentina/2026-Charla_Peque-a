Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormHoleTest >> test001WhenSpaceshipLandsOnWormHoleThenItGoesBackFourTiles [

	| aBoard aShip players |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: WormHole new atTile: 10.
	aShip := Spaceship named: 'Apollo'.
	players := OrderedCollection with: aShip.
	aBoard moveSpaceship: aShip players: players advancing: 9.
	self assert: aShip tile equals: 6
]

{ #category : 'tests' }
WormHoleTest >> test002WhenPlayingThroughGameThenWormHoleIsApplied [

	| aGame aShip aBoard aDiceCup |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: WormHole new atTile: 10.
	aShip := Spaceship named: 'Apollo'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 9) }.
	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 3
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 6
]
