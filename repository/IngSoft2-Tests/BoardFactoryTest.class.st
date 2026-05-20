Class {
	#name : 'BoardFactoryTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
BoardFactoryTest >> countTiles: aBoard ofClass: aClass [

	| count |
	count := 0.
	1 to: aBoard numberOfTiles do: [ :i |
		((aBoard tileAt: i) isKindOf: aClass) ifTrue: [ count := count + 1 ] ].
	^ count
]

{ #category : 'helpers' }
BoardFactoryTest >> factoryWithTiles: n [

	^ BoardFactory
		  withTiles: n
		  totalParsecs: 1000
		  moonWalkRange: #( 1 to: 5 )
		  hyperJumpParsecs: #( 100 200 300 )
]

{ #category : 'tests - instance creation' }
BoardFactoryTest >> test001WhenTheNumberOfTilesIsZeroThenTheFactoryCannotBeCreated [

	self
		should: [
				BoardFactory
					withTiles: 0
					totalParsecs: 1000
					moonWalkRange: #(1 to: 5)
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
					moonWalkRange: #(1 to: 5)
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
					moonWalkRange: #(0 to: 5)
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
					moonWalkRange: #(5 to: 2)
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
					moonWalkRange: (1 to: 5)
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
BoardFactoryTest >> test008WhenAFactoryBuildsABoardThenAllTilesAreTileInstances [

	| factory board allTiles |
	factory := self factoryWithTiles: 50.
	board := factory build.
	allTiles := (1 to: board numberOfTiles) collect: [ :i |
		            board tileAt: i ].
	self assert: (allTiles allSatisfy: [ :each | each isKindOf: Tile ])
]

{ #category : 'tests - probabilistic distribution' }
BoardFactoryTest >> test009WhenBuildingManyBoardsThenNoEffectAppearsInApproximately40Percent [

	| factory counts totalNoEffect percentage |
	factory := self factoryWithTiles: 100.
	counts := (1 to: 500) collect: [ :i |
			          | board |
			          board := factory build.
			          self countTiles: board ofClass: NoEffect ].

	totalNoEffect := counts sum.
	percentage := totalNoEffect / 50000.0 * 100.

	self assert: (percentage between: 38 and: 42)
]

{ #category : 'tests - probabilistic distribution' }
BoardFactoryTest >> test010WhenBuildingManyBoardsThenWormHoleAppearsInApproximately20Percent [

	| factory counts totalWormHole percentage |
	factory := self factoryWithTiles: 100.
	counts := (1 to: 500) collect: [ :i |
			          | board |
			          board := factory build.
			          self countTiles: board ofClass: WormHole ].

	totalWormHole := counts sum.
	percentage := totalWormHole / 50000.0 * 100.
	self assert: (percentage between: 18 and: 22)
]

{ #category : 'tests - probabilistic distribution' }
BoardFactoryTest >> test011WhenBuildingManyBoardsThenSpeedUpAppearsInApproximately20Percent [

	| factory counts totalSpeedUp percentage |
	factory := self factoryWithTiles: 100.
	counts := (1 to: 500) collect: [ :i |
			          | board |
			          board := factory build.
			          self countTiles: board ofClass: SpeedUp ].

	totalSpeedUp := counts sum.
	percentage := totalSpeedUp / 50000.0 * 100.

	self assert: (percentage between: 18 and: 22)
]

{ #category : 'tests - probabilistic distribution' }
BoardFactoryTest >> test012WhenBuildingManyBoardsThenMoonWalkAppearsInApproximately10Percent [

	| factory counts totalMoonWalk percentage |
	factory := self factoryWithTiles: 100.
	counts := (1 to: 500) collect: [ :i |
			          | board |
			          board := factory build.
			          self countTiles: board ofClass: MoonWalk ].

	totalMoonWalk := counts sum.
	percentage := totalMoonWalk / 50000.0 * 100.

	self assert: (percentage between: 8 and: 12)
]

{ #category : 'tests - probabilistic distribution' }
BoardFactoryTest >> test013WhenBuildingManyBoardsThenHyperJumpAppearsInApproximately8Percent [

	| factory counts totalHyperJump percentage |
	factory := self factoryWithTiles: 100.
	counts := (1 to: 500) collect: [ :i |
			          | board |
			          board := factory build.
			          self countTiles: board ofClass: HyperJump ].

	totalHyperJump := counts sum.
	percentage := totalHyperJump / 50000.0 * 100.

	self assert: (percentage between: 6 and: 10)
]

{ #category : 'tests - probabilistic distribution' }
BoardFactoryTest >> test014WhenBuildingManyBoardsThenAtomicBombAppearsInApproximately2Percent [

	| factory counts totalAtomicBomb percentage |
	factory := self factoryWithTiles: 100.
	counts := (1 to: 500) collect: [ :i |
			          | board |
			          board := factory build.
			          self countTiles: board ofClass: AtomicBomb ].

	totalAtomicBomb := counts sum.
	percentage := totalAtomicBomb / 50000.0 * 100.
	self assert: (percentage between: 0 and: 4)
]

{ #category : 'tests - edge cases' }
BoardFactoryTest >> test015WhenBuildingASingleTileBoardThenItCanBeAnyTileType [

	| factory board tile |
	factory := self factoryWithTiles: 1.
	board := factory build.
	tile := board tileAt: 1.
	self assert: (tile isKindOf: Tile)
]

{ #category : 'tests - moonwalk range' }
BoardFactoryTest >> test016WhenMoonWalkRangeIsFixedThenAllMoonWalksHaveTheSameValue [

	| factory boards moonWalks |
	factory := BoardFactory
		           withTiles: 100
		           totalParsecs: 1000
		           moonWalkRange: #(3 to: 3)
		           hyperJumpParsecs: #( 100 ).
	boards := (1 to: 10) collect: [ :i | factory build ].
	moonWalks := boards flatCollect: [ :board |
			             (1 to: board numberOfTiles)
				             collect: [ :i | board tileAt: i ]
				             thenSelect: [ :tile | tile isKindOf: MoonWalk ] ].

	self deny: moonWalks isEmpty.
	moonWalks do: [ :mw | self assert: mw tilesBack equals: 3 ]
]

{ #category : 'tests - moonwalk range' }
BoardFactoryTest >> test017WhenMoonWalkRangeIsWideThenDifferentMoonWalksCanHaveDifferentValues [

	| factory boards moonWalks distinctValues |
	factory := BoardFactory
		           withTiles: 100
		           totalParsecs: 1000
		           moonWalkRange: #(1 to: 10)
		           hyperJumpParsecs: #( 100 ).

	boards := (1 to: 20) collect: [ :i | factory build ].
	moonWalks := boards flatCollect: [ :board |
			             (1 to: board numberOfTiles)
				             collect: [ :i | board tileAt: i ]
				             thenSelect: [ :tile | tile isKindOf: MoonWalk ] ].

	distinctValues := (moonWalks collect: [ :mw | mw tilesBack ]) asSet.
	self assert: distinctValues size > 3
]

{ #category : 'tests - moonwalk range' }
BoardFactoryTest >> test018WhenMoonWalkRangeIsAnArrayThenItWorksCorrectly [

	| factory boards moonWalks |
	factory := BoardFactory
		           withTiles: 100
		           totalParsecs: 1000
		           moonWalkRange: #( 2 )
		           hyperJumpParsecs: #( 100 ).

	boards := (1 to: 10) collect: [ :i | factory build ].
	moonWalks := boards flatCollect: [ :board |
			             (1 to: board numberOfTiles)
				             collect: [ :i | board tileAt: i ]
				             thenSelect: [ :tile | tile isKindOf: MoonWalk ] ].
	self deny: moonWalks isEmpty.
	moonWalks do: [ :mw | self assert: mw tilesBack equals: 2 ]
]
