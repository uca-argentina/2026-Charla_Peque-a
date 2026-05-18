Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MoonWalkTest >> test001WhenSpaceshipLandsOnMoonWalkThenOtherPlayersGoBackNSteps [

	| aBoard triggeringShip otherShip players |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: (MoonWalk backing: 3) atTile: 10.
	triggeringShip := Spaceship named: 'Apollo'.
	otherShip := Spaceship named: 'Enterprise'.
	otherShip position: (Position at: 8 withLaps: 1).
	players := OrderedCollection with: triggeringShip with: otherShip.
	aBoard moveSpaceship: triggeringShip players: players advancing: 9.
	self assert: triggeringShip tile equals: 10.
	self assert: otherShip tile equals: 5
]

{ #category : 'tests' }
MoonWalkTest >> test002WhenSpaceshipLandsOnMoonWalkThenTriggeringPlayerIsNotAffected [

	| aBoard triggeringShip otherShip players |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: (MoonWalk backing: 3) atTile: 7.
	triggeringShip := Spaceship named: 'Apollo'.
	otherShip := Spaceship named: 'Enterprise'.
	otherShip position: (Position at: 10 withLaps: 1).
	players := OrderedCollection with: triggeringShip with: otherShip.
	aBoard moveSpaceship: triggeringShip players: players advancing: 6.
	self assert: triggeringShip tile equals: 7.
	self assert: otherShip tile equals: 7
]

{ #category : 'tests' }
MoonWalkTest >> test003WhenPlayingThroughGameThenMoonWalkAffectsOnlyOtherPlayers [

	| aGame firstShip secondShip aBoard aDiceCup |
	aBoard := Board withNumberOfTiles: 20.
	aBoard setEffect: (MoonWalk backing: 3) atTile: 10.
	firstShip := Spaceship named: 'Apollo'.
	secondShip := Spaceship named: 'Enterprise'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 3) }.
	aGame := Game
		         playedBy: {
				         firstShip.
				         secondShip }
		         reachingLaps: 3
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	5 timesRepeat: [ aGame playNextTurn ].
	self assert: (aGame positionOf: firstShip) equals: 10.
	self assert: (aGame positionOf: secondShip) equals: 4
]
