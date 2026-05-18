Class {
	#name : 'SpeedUpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpeedUpTest >> test001WhenSpaceshipLandsOnSpeedUpThenItAdvancesFourMoreTiles [

	| aBoard aShip players |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: SpeedUp new atTile: 7.
	aShip := Spaceship named: 'Apollo'.
	players := OrderedCollection with: aShip.
	aBoard moveSpaceship: aShip players: players advancing: 6.
	self assert: aShip tile equals: 11
]

{ #category : 'tests' }
SpeedUpTest >> test002WhenPlayingThroughGameThenSpeedUpIsApplied [

	| aGame aShip aBoard aDiceCup |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: SpeedUp new atTile: 7.
	aShip := Spaceship named: 'Apollo'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 3
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 11
]
