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
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: aResult) }.
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
	"Tablero de 10 casilleros, 100 parsecs totales → 10 parsecs por casillero"
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	self assert: (converter tilesForParsecs: 30) equals: 3
]

{ #category : 'tests - ParsecConverter' }
HyperJumpTest >> test004ParsecConverterTruncatesResult [

	| converter |
	"100 parsecs, 10 tiles → 10 parsecs/tile. 25 parsecs → 2.5 → trunca a 2"
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
	"Lista desordenada: { 3. 10. 5 } → debe aplicarse 10, luego 5, luego 3"
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile.
				         (self hyperJumpTileWithParsecs: { 3. 10. 5 } converter: converter).
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile. self noEffectTile }
		         players: { aShip }
		         laps: 3
		         dice: 4.

	"Turno 1: tira 4 → pos 5 (HyperJump). Aplica 10 parsecs → 1 tile. Queda en 6."
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
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile.
				         (self hyperJumpTileWithParsecs: { 20. 10 } converter: converter).
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile. self noEffectTile }
		         players: { aShip }
		         laps: 3
		         dice: 4.

	"Tira 4, cae en pos 5 (HyperJump). Aplica 20 parsecs → 2 tiles. Queda en 7."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7
]

{ #category : 'tests - game logic' }
HyperJumpTest >> test009HyperJumpAppliesParsecValuesFromHighestToLowest [

	| converter aShip aGame |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile.
				         (self hyperJumpTileWithParsecs: { 20. 10 } converter: converter).
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile. self noEffectTile }
		         players: { aShip }
		         laps: 5
		         dice: 4.

	"Primera visita: 20 parsecs → 2 tiles. De 5 queda en 7."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7
]

{ #category : 'tests - game logic' }
HyperJumpTest >> test010HyperJumpCyclesThroughParsecValuesAndResets [

	| converter aShip aGame |
	converter := ParsecConverter withTotalParsecs: 50 numberOfTiles: 5.
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile.
				         (self hyperJumpTileWithParsecs: { 20. 10 } converter: converter).
				         self noEffectTile. self noEffectTile. self noEffectTile }
		         players: { aShip }
		         laps: 10
		         dice: 1.

	"Visita 1: pos1 tira1 → pos2 (HJ). 20 parsecs → 2 tiles. Queda en 4."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4.
	"Visita 2: pos4 tira1 → pos5. NoEffect."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 5.
	"Visita 3: pos5 tira1 → pos1 (vuelta). NoEffect."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 1.
	"Visita 4: pos1 tira1 → pos2 (HJ). Segunda vez: 10 parsecs → 1 tile. Queda en 3."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 3.
	"Visita 5: pos3 tira1 → pos4. NoEffect."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4.
	"Visita 6: pos4 tira1 → pos5. NoEffect."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 5.
	"Visita 7: pos5 tira1 → pos1 (vuelta). NoEffect."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 1.
	"Visita 8: pos1 tira1 → pos2 (HJ). Reset: vuelve a 20 → 2 tiles. Queda en 4."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4
]

{ #category : 'tests - light years' }
HyperJumpTest >> test011HyperJumpCanBeExpressedInLightYears [

	| converter aShip aGame |
	"60 años luz = 20 parsecs (1 parsec = 3 años luz). 100 parsecs / 10 tiles → 2 tiles."
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: {
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile.
				         (Tile with: (HyperJump
						          withDistances: { (Distance lightYears: 60) }
						          converter: converter)).
				         self noEffectTile. self noEffectTile. self noEffectTile.
				         self noEffectTile. self noEffectTile }
		         players: { aShip }
		         laps: 3
		         dice: 4.

	"Tira 4 → pos 5 (HJ). 60 años luz = 20 parsecs → 2 tiles. Queda en 7."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7
]
