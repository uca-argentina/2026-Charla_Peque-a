Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
HyperJumpTest >> gameWith: aTileCollection players: aShipCollection laps: n dice: aResult [

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
HyperJumpTest >> hyperJumpTileWithParsecs: aList converter: aConverter [

	^ Tile with: (HyperJump withParsecs: aList converter: aConverter)
]

{ #category : 'helpers' }
HyperJumpTest >> noEffectTile [

	^ Tile with: NoEffect new
]

{ #category : 'tests - ParsecConverter' }
HyperJumpTest >> test001ParsecConverterCannotBeCreatedWithNonPositiveParsecs [

	self
		should: [ ParsecConverter withTotalParsecs: 0 numberOfTiles: 10 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Total parsecs must be positive.' ]
]

{ #category : 'tests - ParsecConverter' }
HyperJumpTest >> test002ParsecConverterCannotBeCreatedWithNonPositiveTiles [

	self
		should: [ ParsecConverter withTotalParsecs: 100 numberOfTiles: 0 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Number of tiles must be positive.' ]
]

{ #category : 'tests - ParsecConverter' }
HyperJumpTest >> test003ParsecConverterConvertsParsecsToCasilleros [

	| converter |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	self assert: (converter tilesForParsecs: 30) equals: 3
]

{ #category : 'tests - ParsecConverter' }
HyperJumpTest >> test004ParsecConverterTruncatesResult [

	| converter |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	self assert: (converter tilesForParsecs: 25) equals: 2
]

{ #category : 'tests - instance creation' }
HyperJumpTest >> test005HyperJumpCannotBeCreatedWithEmptyParsecsList [

	| converter |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	self
		should: [ HyperJump withParsecs: #(  ) converter: converter ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'HyperJump must have at least one parsec value.' ]
]

{ #category : 'tests - instance creation' }
HyperJumpTest >> test006HyperJumpCannotBeCreatedWithNilConverter [

	self
		should: [ HyperJump withParsecs: { 10. 5 } converter: nil ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'HyperJump must have a converter.' ]
]

{ #category : 'tests - instance creation' }
HyperJumpTest >> test007HyperJumpSortsParsecListFromHighestToLowest [

	| converter aShip aGame |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         (self
					          hyperJumpTileWithParsecs: { 3. 10. 5 }
					          converter: converter).
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 3
		         dice: 4.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 6
]

{ #category : 'tests - game logic' }
HyperJumpTest >> test008WhenAShipLandsOnHyperJumpItAdvancesTheCorrectNumberOfTiles [

	| converter aShip aGame |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         (self
					          hyperJumpTileWithParsecs: { 20. 10 }
					          converter: converter).
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 3
		         dice: 4.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7
]

{ #category : 'tests - game logic' }
HyperJumpTest >> test009WhenHyperJumpIsAppliedThenItUsesParsecValuesFromHighestToLowest [

	| converter aShip aGame |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         (self
					          hyperJumpTileWithParsecs: { 20. 10 }
					          converter: converter).
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 5
		         dice: 4.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7
]

{ #category : 'tests - game logic' }
HyperJumpTest >> test010WhenHyperJumpExhaustsItsValuesThenItResetsAndCycles [

	| converter aShip aGame |
	converter := ParsecConverter withTotalParsecs: 50 numberOfTiles: 5.
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         (self
					          hyperJumpTileWithParsecs: { 20. 10 }
					          converter: converter).
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 10
		         dice: 1.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4.
	
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 5.
	
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 1.
	
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 3.
	
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4.
	
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 5.
	
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 1.
	
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4
]

{ #category : 'tests - light years' }
HyperJumpTest >> test011WhenHyperJumpIsExpressedInLightYearsThenItConvertsToParsecs [

	| converter aShip aGame |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         (Tile with: (HyperJump
						           withDistances: { (Distance lightYears: 60) }
						           converter: converter)).
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { aShip }
		         laps: 3
		         dice: 4.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7
]

{ #category : 'tests - edge cases' }
HyperJumpTest >> test012AHyperJumpShorterThanOneTileMovesZeroTiles [

	| converter ship aGame |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	ship := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         (self
					          hyperJumpTileWithParsecs: { 5 }
					          converter: converter).
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile.
				         self noEffectTile }
		         players: { ship }
		         laps: 3
		         dice: 4.
	aGame playNextTurn.
	self assert: (aGame positionOf: ship) equals: 5
]
