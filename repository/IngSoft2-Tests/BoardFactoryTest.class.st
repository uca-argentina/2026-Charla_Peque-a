Class {
	#name : 'BoardFactoryTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
BoardFactoryTest >> boardForcingRoll: aRoll [

	"Builds a single-tile board whose only tile is produced by the given roll.
	 The extra values feed MoonWalk's range pick when needed."

	| source factory |
	source := SequencedRandomSource withValues: { aRoll. 1 }.
	factory := self factoryWithTiles: 1 randomSource: source.
	^ factory build
]

{ #category : 'helpers' }
BoardFactoryTest >> effectClassForRoll: aRoll [

	^ (self boardForcingRoll: aRoll) effectAt: 1
]

{ #category : 'helpers' }
BoardFactoryTest >> factoryWithTiles: n [

	^ BoardFactory
		  withTiles: n
		  totalParsecs: 1000
		  moonWalkRange: #( 1 2 3 4 5 )
		  hyperJumpParsecs: #( 100 200 300 )
]

{ #category : 'helpers' }
BoardFactoryTest >> factoryWithTiles: n randomSource: aSource [

	^ BoardFactory
		  withTiles: n
		  totalParsecs: 1000
		  moonWalkRange: #( 1 2 3 4 5 )
		  hyperJumpParsecs: #( 100 200 300 )
		  randomSource: aSource
]

{ #category : 'tests - instance creation' }
BoardFactoryTest >> test001WhenTheNumberOfTilesIsZeroThenTheFactoryCannotBeCreated [

	self
		should: [
			BoardFactory
				withTiles: 0
				totalParsecs: 1000
				moonWalkRange: #( 1 2 3 4 5 )
				hyperJumpParsecs: #( 100 ) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'A board must have at least one tile.' ]
]

{ #category : 'tests - instance creation' }
BoardFactoryTest >> test002WhenParsecsAreNonPositiveThenAFactoryCannotBeCreated [

	self
		should: [
			BoardFactory
				withTiles: 10
				totalParsecs: 0
				moonWalkRange: #( 1 2 3 4 5 )
				hyperJumpParsecs: #( 100 ) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Total parsecs must be positive.' ]
]

{ #category : 'tests - instance creation' }
BoardFactoryTest >> test003WhenMoonWalkRangeIsEmptyThenTheFactoryCannotBeCreated [

	self
		should: [
			BoardFactory
				withTiles: 10
				totalParsecs: 1000
				moonWalkRange: #(  )
				hyperJumpParsecs: #( 100 ) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'MoonWalk range cannot be empty.' ]
]

{ #category : 'tests - instance creation' }
BoardFactoryTest >> test004WhenMoonWalkMinIsLessThanOneThenTheFactoryCannotBeCreated [

	self
		should: [
			BoardFactory
				withTiles: 10
				totalParsecs: 1000
				moonWalkRange: #( 0 1 2 3 4 5 )
				hyperJumpParsecs: #( 100 ) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'MoonWalk min must be at least one.' ]
]

{ #category : 'tests - instance creation' }
BoardFactoryTest >> test005WhenMoonWalkMaxIsLessThanMinThenTheFactoryCannotBeCreated [

	self
		should: [
			BoardFactory
				withTiles: 10
				totalParsecs: 1000
				moonWalkRange: #( 5 2 )
				hyperJumpParsecs: #( 100 ) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'MoonWalk max must be greater than or equal to min.' ]
]

{ #category : 'tests - instance creation' }
BoardFactoryTest >> test006WhenHyperJumpParsecsListIsEmptyThenTheFactoryCannotBeCreated [

	self
		should: [
			BoardFactory
				withTiles: 10
				totalParsecs: 1000
				moonWalkRange: #( 1 2 3 4 5 )
				hyperJumpParsecs: #(  ) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'HyperJump parsecs list cannot be empty.' ]
]

{ #category : 'tests - board properties' }
BoardFactoryTest >> test007WhenAFactoryBuildsABoardThenItHasTheRequestedNumberOfTiles [

	| factory board |
	factory := self factoryWithTiles: 100.
	board := factory build.
	self assert: board numberOfTiles equals: 100
]

{ #category : 'tests - board properties' }
BoardFactoryTest >> test008WhenAFactoryBuildsABoardThenAllTilesAreTiles [

	| factory board allUnderstandProtocol |
	factory := self factoryWithTiles: 50.
	board := factory build.
	allUnderstandProtocol := (1 to: board numberOfTiles) allSatisfy: [ :i |
		                         (board tileAt: i) respondsTo: #applyOn:for: ].
	self assert: allUnderstandProtocol
]

{ #category : 'tests - deterministic distribution' }
BoardFactoryTest >> test009ARollOfThirtyOrLessProducesANoEffect [

	self assert: (self effectClassForRoll: 1) class equals: NoEffect.
	self assert: (self effectClassForRoll: 30) class equals: NoEffect
]

{ #category : 'tests - deterministic distribution' }
BoardFactoryTest >> test010ARollBetweenThirtyOneAndFiftyProducesAWormHole [

	self assert: (self effectClassForRoll: 31) class equals: WormHole.
	self assert: (self effectClassForRoll: 50) class equals: WormHole
]

{ #category : 'tests - deterministic distribution' }
BoardFactoryTest >> test011ARollBetweenFiftyOneAndSeventyProducesASpeedUp [

	self assert: (self effectClassForRoll: 51) class equals: SpeedUp.
	self assert: (self effectClassForRoll: 70) class equals: SpeedUp
]

{ #category : 'tests - deterministic distribution' }
BoardFactoryTest >> test012ARollBetweenSeventyOneAndEightyProducesAMoonWalk [

	self assert: (self effectClassForRoll: 71) class equals: MoonWalk.
	self assert: (self effectClassForRoll: 80) class equals: MoonWalk
]

{ #category : 'tests - deterministic distribution' }
BoardFactoryTest >> test013ARollBetweenEightyOneAndEightyEightProducesAHyperJump [

	self assert: (self effectClassForRoll: 81) class equals: HyperJump.
	self assert: (self effectClassForRoll: 88) class equals: HyperJump
]

{ #category : 'tests - deterministic distribution' }
BoardFactoryTest >> test014ARollOfEightyNineOrNinetyProducesAnAtomicBomb [

	self assert: (self effectClassForRoll: 89) class equals: AtomicBomb.
	self assert: (self effectClassForRoll: 90) class equals: AtomicBomb
]

{ #category : 'tests - deterministic distribution' }
BoardFactoryTest >> test015ARollAboveNinetyProducesAGiveCard [

	self assert: (self effectClassForRoll: 91) class equals: GiveCard.
	self assert: (self effectClassForRoll: 100) class equals: GiveCard
]

{ #category : 'tests - moonwalk range' }
BoardFactoryTest >> test016WhenMoonWalkRangeIsFixedThenTheMoonWalkHasThatValue [

	| source factory board moonWalk |
	"Roll 75 → MoonWalk. Range fixed at {3} so the value must be 3."
	source := SequencedRandomSource withValues: { 75. 1 }.
	factory := BoardFactory
		           withTiles: 1
		           totalParsecs: 1000
		           moonWalkRange: #( 3 )
		           hyperJumpParsecs: #( 100 )
		           randomSource: source.
	board := factory build.
	moonWalk := board effectAt: 1.
	self assert: moonWalk class equals: MoonWalk.
	self assert: moonWalk tilesBack equals: 3
]

{ #category : 'tests - moonwalk range' }
BoardFactoryTest >> test017WhenMoonWalkRangeIsWideThenTheValueComesFromTheRange [

	| source factory board moonWalk |
	"Roll 75 → MoonWalk. Next value 4 picks the 4th element of (1..10) → 4."
	source := SequencedRandomSource withValues: { 75. 4 }.
	factory := BoardFactory
		           withTiles: 1
		           totalParsecs: 1000
		           moonWalkRange: #( 1 2 3 4 5 6 7 8 9 10 )
		           hyperJumpParsecs: #( 100 )
		           randomSource: source.
	board := factory build.
	moonWalk := board effectAt: 1.
	self assert: moonWalk tilesBack equals: 4
]

{ #category : 'tests - edge cases' }
BoardFactoryTest >> test018WhenBuildingASingleTileBoardThenItCanBeAnyTileType [

	| factory board tile |
	factory := self factoryWithTiles: 1.
	board := factory build.
	tile := board tileAt: 1.
	self assert: (tile respondsTo: #applyOn:for:)
]
