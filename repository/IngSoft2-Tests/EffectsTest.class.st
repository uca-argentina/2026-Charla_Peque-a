Class {
	#name : 'EffectsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
EffectsTest >> atomicBombTile [

	^ Tile with: AtomicBomb new
]

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
		  withDeck: (SequenceDeck withCards: { Acceleration new })
]

{ #category : 'helpers' }
EffectsTest >> moonWalkTileBack: n [

	^ Tile with: (MoonWalk withTilesBack: n)
]

{ #category : 'helpers' }
EffectsTest >> noEffectTile [

	^ Tile with: NoEffect new
]

{ #category : 'helpers' }
EffectsTest >> speedUpTile [

	^ Tile with: SpeedUp new
]

{ #category : 'tests - SpeedUp' }
EffectsTest >> test001WhenAShipLandsOnSpeedUpThenItAdvancesFourMoreTiles [

	| aShip aGame |
	aShip := 'Spaceship 1'.
	"Tablero de 10. SpeedUp en posición 4."
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self speedUpTile.
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile. self noEffectTile. self noEffectTile }
		         players: { aShip }
		         laps: 2
		         dice: 3.

	aGame playNextTurn.
	"Arranca en 1, tira 3, queda en 4 (SpeedUp), avanza +4, queda en 8"
	self assert: (aGame positionOf: aShip) equals: 8
]

{ #category : 'tests - WormHole' }
EffectsTest >> test002WhenAShipLandsOnWormHoleThenItRetreatsFourTiles [

	| aShip aGame |
	aShip := 'Spaceship 1'.
	"Tablero de 10. WormHole en posición 8."
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile.
				         self wormHoleTile.
				         self noEffectTile. self noEffectTile }
		         players: { aShip }
		         laps: 2
		         dice: 7.

	aGame playNextTurn.
	"Arranca en 1, tira 7, queda en 8 (WormHole), retrocede -4, queda en 4"
	self assert: (aGame positionOf: aShip) equals: 4
]

{ #category : 'tests - MoonWalk' }
EffectsTest >> test003WhenAShipLandsOnMoonWalkThenAllOtherShipsRetreatNTiles [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	"Tablero de 10. MoonWalk(N=2) en posición 6."
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile. self noEffectTile.
				         (self moonWalkTileBack: 2).
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile }
		         players: { firstShip. secondShip }
		         laps: 2
		         dice: 5.

	"firstShip cae en 6 (MoonWalk N=2). secondShip (1,1) retrocede 2 → clamp a (1,1)."
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 6.
	self assert: (aGame positionOf: secondShip) equals: 1.
	self assert: (aGame lapOf: secondShip) equals: 1
]

{ #category : 'tests - MoonWalk' }
EffectsTest >> test004MoonWalkDoesNotAffectTheShipThatLandedOnIt [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile. self noEffectTile.
				         (self moonWalkTileBack: 2).
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile }
		         players: { firstShip. secondShip }
		         laps: 2
		         dice: 5.

	aGame playNextTurn.
	"firstShip cae en MoonWalk pero NO se mueve a sí misma"
	self assert: (aGame positionOf: firstShip) equals: 6
]

{ #category : 'tests - MoonWalk' }
EffectsTest >> test005MoonWalkCannotBeCreatedWithLessThanOneTileBack [

	self
		should: [ MoonWalk withTilesBack: 0 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'MoonWalk must move at least one tile back.' ]
]

{ #category : 'tests - AtomicBomb' }
EffectsTest >> test006WhenAShipLandsOnAtomicBombThenAllShipsReturnToFirstTile [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile. self noEffectTile.
				         self atomicBombTile.
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile }
		         players: { firstShip. secondShip }
		         laps: 2
		         dice: 5.

	"firstShip tira 5, va de 1 a 6 (AtomicBomb). Todos al primer casillero."
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 1.
	self assert: (aGame positionOf: secondShip) equals: 1
]

{ #category : 'tests - AtomicBomb' }
EffectsTest >> test007AtomicBombKeepsTheLapCountOfEachShip [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	"Tablero de 5. AtomicBomb en posición 1."
	aGame := self
		         gameWith: {
				         self atomicBombTile.
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile }
		         players: { firstShip. secondShip }
		         laps: 3
		         dice: 5.

	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 1.
	self assert: (aGame lapOf: firstShip) equals: 2.
	self assert: (aGame positionOf: secondShip) equals: 1.
	self assert: (aGame lapOf: secondShip) equals: 1
]

{ #category : 'tests - no chained effect' }
EffectsTest >> test008WhenAnEffectMovesAShipToAnotherEffectThenTheSecondEffectIsNotApplied [

	| aShip aGame |
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile.
				         self speedUpTile.
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self wormHoleTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 2
		         dice: 4.

	"Tira 4 → pos 5 (SpeedUp) → +4 → pos 9 (WormHole) NO se aplica."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 9
]

{ #category : 'tests - no chained effect' }
EffectsTest >> test009MoonWalkPushingShipToSpeedUpDoesNotTriggerSpeedUp [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile.
				         self speedUpTile.
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile.
				         (self moonWalkTileBack: 5).
				         self noEffectTile. self noEffectTile }
		         players: { firstShip. secondShip }
		         laps: 2
		         dice: 7.

	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 3.
	self assert: (aGame positionOf: secondShip) equals: 8
]

{ #category : 'helpers' }
EffectsTest >> wormHoleTile [

	^ Tile with: WormHole new
]
