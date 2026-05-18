Class {
	#name : 'EffectsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
EffectsTest >> gameWith: aTileCollection players: aShipCollection laps: n dice: aResult [
 
	| aBoard aDiceCup |
	aBoard := Board withTiles: aTileCollection.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: aResult) }.
	^ Game
		playedBy: aShipCollection
		reachingLaps: n
		withBoard: aBoard
		andDiceCup: aDiceCup
]

{ #category : 'helpers' }
EffectsTest >> noEffect [
 
	^ NoEffect new
]

{ #category : 'helpers' }
EffectsTest >> test001WhenAShipLandsOnSpeedUpThenItAdvancesFourMoreTiles [
 
	| aShip aGame |
	aShip := 'Spaceship 1'.
	"Tablero de 10. SpeedUp en posición 4."
	aGame := self
		gameWith: {
			self noEffect. self noEffect. self noEffect. SpeedUp new.
			self noEffect. self noEffect. self noEffect. self noEffect.
			self noEffect. self noEffect }
		players: { aShip }
		laps: 2
		dice: 3.
 
	aGame playNextTurn.
	"Arranca en 1, tira 3, queda en 4 (SpeedUp), avanza +4, queda en 8"
	self assert: (aGame positionOf: aShip) equals: 8
]

{ #category : 'tests' }
EffectsTest >> test002WhenAShipLandsOnWormHoleThenItRetreatsFourTiles [
 
	| aShip aGame |
	aShip := 'Spaceship 1'.
	"Tablero de 10. WormHole en posición 8."
	aGame := self
		gameWith: {
			self noEffect. self noEffect. self noEffect. self noEffect.
			self noEffect. self noEffect. self noEffect. WormHole new.
			self noEffect. self noEffect }
		players: { aShip }
		laps: 2
		dice: 7.
 
	aGame playNextTurn.
	"Arranca en 1, tira 7, queda en 8 (WormHole), retrocede -4, queda en 4"
	self assert: (aGame positionOf: aShip) equals: 4
]

{ #category : 'tests' }
EffectsTest >> test003WhenAShipLandsOnMoonWalkThenAllOtherShipsRetreatNTiles [
 
	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	"Tablero de 10. MoonWalk(N=2) en posición 6."
	aGame := self
		gameWith: {
			self noEffect. self noEffect. self noEffect. self noEffect.
			self noEffect. (MoonWalk withTilesBack: 2). self noEffect.
			self noEffect. self noEffect. self noEffect }
		players: { firstShip. secondShip }
		laps: 2
		dice: 5.
 
	"firstShip arranca en 1, tira 5, cae en 6 (MoonWalk N=2).
	secondShip estaba en (1,1); retrocede 2 → clamp a (1,1)."
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 6.
	self assert: (aGame positionOf: secondShip) equals: 1.
	self assert: (aGame lapOf: secondShip) equals: 1
]
