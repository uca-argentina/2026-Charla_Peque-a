Class {
	#name : 'BoardFactoryTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
BoardFactoryTest >> allTilesOf: aBoard areOfClass: anEffectClass [

	^ (1 to: aBoard numberOfTiles) allSatisfy: [ :i |
		  (aBoard effectAt: i) class = anEffectClass ]
]

{ #category : 'helpers' }
BoardFactoryTest >> factoryWithTiles: n allOf: anEffectBlock [

	| distribution |
	distribution := EffectDistribution new
		                probability: 100
		                of: anEffectBlock.
	^ BoardFactory withTiles: n distribution: distribution
]

{ #category : 'helpers' }
BoardFactoryTest >> standardFactoryWithTiles: n [

	^ BoardFactory
		  withTiles: n
		  totalParsecs: 1000
		  moonWalkRange: #( 1 2 3 4 5 )
		  hyperJumpParsecs: #( 100 200 300 )
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

	| board |
	board := (self standardFactoryWithTiles: 100) build.
	self assert: board numberOfTiles equals: 100
]

{ #category : 'tests - board properties' }
BoardFactoryTest >> test008WhenAFactoryBuildsABoardThenAllItsTilesAreTiles [

	| board allAreTiles |
	board := (self standardFactoryWithTiles: 50) build.
	allAreTiles := (1 to: board numberOfTiles) allSatisfy: [ :i |
		               (board tileAt: i) class = Tile ].
	self assert: allAreTiles
]

{ #category : 'tests - distribution by configuration' }
BoardFactoryTest >> test009ADistributionOfAllNoEffectFillsTheBoardWithNoEffect [

	| board |
	board := (self factoryWithTiles: 20 allOf: [ NoEffect new ]) build.
	self assert: (self allTilesOf: board areOfClass: NoEffect)
]

{ #category : 'tests - distribution by configuration' }
BoardFactoryTest >> test010ADistributionOfAllWormHoleFillsTheBoardWithWormHole [

	| board |
	board := (self factoryWithTiles: 20 allOf: [ WormHole new ]) build.
	self assert: (self allTilesOf: board areOfClass: WormHole)
]

{ #category : 'tests - distribution by configuration' }
BoardFactoryTest >> test011ADistributionOfAllSpeedUpFillsTheBoardWithSpeedUp [

	| board |
	board := (self factoryWithTiles: 20 allOf: [ SpeedUp new ]) build.
	self assert: (self allTilesOf: board areOfClass: SpeedUp)
]

{ #category : 'tests - distribution by configuration' }
BoardFactoryTest >> test012ADistributionOfAllMoonWalkFillsTheBoardWithMoonWalk [

	| board |
	board := (self
		          factoryWithTiles: 20
		          allOf: [ MoonWalk withTilesBack: 2 ]) build.
	self assert: (self allTilesOf: board areOfClass: MoonWalk)
]

{ #category : 'tests - distribution by configuration' }
BoardFactoryTest >> test013ADistributionOfAllAtomicBombFillsTheBoardWithAtomicBomb [

	| board |
	board := (self factoryWithTiles: 20 allOf: [ AtomicBomb new ]) build.
	self assert: (self allTilesOf: board areOfClass: AtomicBomb)
]

{ #category : 'tests - distribution by configuration' }
BoardFactoryTest >> test014ADistributionOfAllGiveCardFillsTheBoardWithGiveCard [

	| board |
	board := (self factoryWithTiles: 20 allOf: [ GiveCard new ]) build.
	self assert: (self allTilesOf: board areOfClass: GiveCard)
]

{ #category : 'tests - distribution by configuration' }
BoardFactoryTest >> test015ACustomDistributionCanMixEffectsWithChosenProbabilities [

	| board distribution source noEffectCount speedUpCount |
	source := SequencedRandomSource withValues: { 1. 51. 1. 51 }.
	distribution := EffectDistribution withRandomSource: source.
	distribution
		probability: 50 of: [ NoEffect new ];
		probability: 50 of: [ SpeedUp new ].
	board := (BoardFactory withTiles: 4 distribution: distribution) build.
	noEffectCount := (1 to: 4) count: [ :i |
		                 (board effectAt: i) class = NoEffect ].
	speedUpCount := (1 to: 4) count: [ :i |
		                (board effectAt: i) class = SpeedUp ].
	self assert: noEffectCount equals: 2.
	self assert: speedUpCount equals: 2
]

{ #category : 'tests - moonwalk range' }
BoardFactoryTest >> test016WhenAMoonWalkBlockUsesAFixedValueThenEveryMoonWalkHasThatValue [

	| board moonWalk |
	board := (self
		          factoryWithTiles: 5
		          allOf: [ MoonWalk withTilesBack: 3 ]) build.
	moonWalk := board effectAt: 1.
	self assert: moonWalk class equals: MoonWalk.
	self assert: moonWalk tilesBack equals: 3
]

{ #category : 'tests - moonwalk range' }
BoardFactoryTest >> test017WhenAMoonWalkBlockClosesOverASourceThenTheValueComesFromIt [

	| board moonWalk source distribution |
	source := SequencedRandomSource withValues: { 4 }.
	distribution := EffectDistribution new
		                probability: 100
		                of: [ MoonWalk withTilesBack: (source nextInt: 10) ].
	board := (BoardFactory withTiles: 1 distribution: distribution) build.
	moonWalk := board effectAt: 1.
	self assert: moonWalk tilesBack equals: 4
]

{ #category : 'tests - edge cases' }
BoardFactoryTest >> test018WhenBuildingASingleTileBoardThenItsTileIsATile [

	| board tile |
	board := (self standardFactoryWithTiles: 1) build.
	tile := board tileAt: 1.
	self assert: tile class equals: Tile
]

{ #category : 'tests - instance creation' }
BoardFactoryTest >> test019WhenTheDistributionIsNilThenTheFactoryCannotBeCreated [

	self
		should: [ BoardFactory withTiles: 10 distribution: nil ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A board factory must have an effect distribution.' ]
]

{ #category : 'tests - configurable distribution' }
BoardFactoryTest >> test020WhenADistributionIsAllOfOneEffectThenEveryTileIsThatEffect [

	| board distribution |
	distribution := EffectDistribution new
		                probability: 100
		                of: [ WormHole new ].
	board := (BoardFactory withTiles: 30 distribution: distribution)
		         build.
	self assert: (self allTilesOf: board areOfClass: WormHole)
]

{ #category : 'tests - configurable distribution' }
BoardFactoryTest >> test021WhenADistributionMixesTwoEffectsThenAControlledSourceProducesBoth [

	| board distribution source |
	source := SequencedRandomSource withValues: { 10. 90. 10. 90 }.
	distribution := EffectDistribution withRandomSource: source.
	distribution
		probability: 50 of: [ NoEffect new ];
		probability: 50 of: [ AtomicBomb new ].
	board := (BoardFactory withTiles: 4 distribution: distribution) build.
	self assert: (board effectAt: 1) class equals: NoEffect.
	self assert: (board effectAt: 2) class equals: AtomicBomb.
	self assert: (board effectAt: 3) class equals: NoEffect.
	self assert: (board effectAt: 4) class equals: AtomicBomb
]

{ #category : 'tests - configurable distribution' }
BoardFactoryTest >> test022WhenADistributionGivesAnEffectZeroPercentThenItNeverAppears [

	| board distribution |
	distribution := EffectDistribution new
		                probability: 100 of: [ SpeedUp new ];
		                probability: 0 of: [ AtomicBomb new ].
	board := (BoardFactory withTiles: 25 distribution: distribution)
		         build.
	self assert: (self allTilesOf: board areOfClass: SpeedUp)
]
