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
	aDiceCup := DiceCup withDice:
		            { (LoadedDice withForcedResult: aResult) }.
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
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self speedUpTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 2
		         dice: 3.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 8
]

{ #category : 'tests - WormHole' }
EffectsTest >> test002WhenAShipLandsOnWormHoleThenItRetreatsFourTiles [

	| aShip aGame |
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self wormHoleTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 2
		         dice: 7.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4
]

{ #category : 'tests - MoonWalk' }
EffectsTest >> test003WhenAShipLandsOnMoonWalkThenAllOtherShipsRetreatNTiles [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         (self moonWalkTileBack: 2).
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: {
				         firstShip.
				         secondShip }
		         laps: 2
		         dice: 5.

	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 6.
	self assert: (aGame positionOf: secondShip) equals: 1.
	self assert: (aGame lapOf: secondShip) equals: 1
]

{ #category : 'tests - MoonWalk' }
EffectsTest >> test004WhenAShipLandsOnMoonWalkThenItIsNotAffected [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         (self moonWalkTileBack: 2).
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: {
				         firstShip.
				         secondShip }
		         laps: 2
		         dice: 5.

	aGame playNextTurn.
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
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self atomicBombTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: {
				         firstShip.
				         secondShip }
		         laps: 2
		         dice: 5.

	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 1.
	self assert: (aGame positionOf: secondShip) equals: 1
]

{ #category : 'tests - AtomicBomb' }
EffectsTest >> test007WhenAtomicBombIsAppliedThenEachShipKeepsItsLapCount [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: {
				         self atomicBombTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: {
				         firstShip.
				         secondShip }
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
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self speedUpTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self wormHoleTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 2
		         dice: 4.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 9
]

{ #category : 'tests - no chained effect' }
EffectsTest >> test009WhenMoonWalkPushesAShipOntoSpeedUpThenSpeedUpDoesNotTrigger [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self speedUpTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         (self moonWalkTileBack: 5).
				         self noEffectTile.
				         self noEffectTile }
		         players: {
				         firstShip.
				         secondShip }
		         laps: 2
		         dice: 7.

	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 3.
	self assert: (aGame positionOf: secondShip) equals: 8
]

{ #category : 'tests - effects do not chain' }
EffectsTest >> test010WhenSpeedUpPushesAShipOntoAnotherEffectThenThatEffectDoesNotTrigger [

	| aShip aGame |
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self speedUpTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self wormHoleTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 2
		         dice: 3.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 8
]

{ #category : 'tests - effects do not chain' }
EffectsTest >> test011WhenWormHolePushesAShipOntoAnotherEffectThenThatEffectDoesNotTrigger [

	| aShip aGame |
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self speedUpTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self wormHoleTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 2
		         dice: 7.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4
]

{ #category : 'tests - effects do not chain' }
EffectsTest >> test012WhenAtomicBombSendsShipsToATileWithEffectThenThatEffectDoesNotTrigger [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: {
				         self speedUpTile.
				         self noEffectTile.
				         self atomicBombTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: {
				         firstShip.
				         secondShip }
		         laps: 3
		         dice: 2.
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 1.
	self assert: (aGame positionOf: secondShip) equals: 1
]

{ #category : 'tests - winning by effect' }
EffectsTest >> test013WhenAShipWinsBecauseOfABoardEffectThenTheGameEnds [

	| aShip aGame |
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self speedUpTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 1
		         dice: 3.
	aGame playNextTurn.
	self assert: aGame hasFinished.
	self assert: aGame winner equals: aShip
]

{ #category : 'helpers' }
EffectsTest >> wormHoleTile [

	^ Tile with: WormHole new
]
