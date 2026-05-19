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
		  moonWalkMin: 1
		  moonWalkMax: 1
		  hyperJumpParsecs: #( 100 200 300 )
]

{ #category : 'tests' }
BoardFactoryTest >> test001WhenTheNumberOfTilesIsZeroThenTheFactoryCannotBeCreated [

	self
		should: [
				BoardFactory
					withTiles: 0
					totalParsecs: 1000
					moonWalkMin: 1
					moonWalkMax: 5
					hyperJumpParsecs: #( 100 ) ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A board must have at least one tile.' ]
]

{ #category : 'tests' }
BoardFactoryTest >> test002WhenParsecsAreNonPositiveThenAFactoryCannotBeCreated [

	self
		should: [
				BoardFactory
					withTiles: 10
					totalParsecs: 0
					moonWalkMin: 1
					moonWalkMax: 5
					hyperJumpParsecs: #( 100 ) ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Total parsecs must be positive.' ]
]

{ #category : 'tests' }
BoardFactoryTest >> test003WhenMoonWalkMinIsLessThanOneThenTheFactoryCannotBeCreated [

	self
		should: [
				BoardFactory
					withTiles: 10
					totalParsecs: 1000
					moonWalkMin: 0
					moonWalkMax: 5
					hyperJumpParsecs: #( 100 ) ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'MoonWalk min must be at least one.' ]
]

{ #category : 'tests' }
BoardFactoryTest >> test004WhenMoonWalkMaxIsLessThanMinThenTheFactoryCannotBeCreated [

	self
		should: [
				BoardFactory
					withTiles: 10
					totalParsecs: 1000
					moonWalkMin: 5
					moonWalkMax: 2
					hyperJumpParsecs: #( 100 ) ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'MoonWalk max must be greater than or equal to min.' ]
]

{ #category : 'tests' }
BoardFactoryTest >> test005WhenHyperJumpParsecsListIsEmptyThenTheFactoryCannotBeCreated [

	self
		should: [
				BoardFactory
					withTiles: 10
					totalParsecs: 1000
					moonWalkMin: 1
					moonWalkMax: 5
					hyperJumpParsecs: #(  ) ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'HyperJump parsecs list cannot be empty.' ]
]

{ #category : 'tests' }
BoardFactoryTest >> test006WhenAFactoryBuildsABoardThenItHasTheRequestedNumberOfTiles [

	| factory board |
	factory := self factoryWithTiles: 100.
	board := factory build.
	self assert: board numberOfTiles equals: 100
]

{ #category : 'tests' }
BoardFactoryTest >> test007WhenAFactoryBuildsA100TileBoardThenTheDistributionIsExact [

	| factory board |
	factory := self factoryWithTiles: 100.
	board := factory build.

	self assert: (self countTiles: board ofClass: NoEffect) equals: 40.
	self assert: (self countTiles: board ofClass: WormHole) equals: 20.
	self assert: (self countTiles: board ofClass: SpeedUp) equals: 20.
	self assert: (self countTiles: board ofClass: MoonWalk) equals: 10.
	self assert: (self countTiles: board ofClass: HyperJump) equals: 8.
	self assert: (self countTiles: board ofClass: AtomicBomb) equals: 2
]

{ #category : 'tests' }
BoardFactoryTest >> test008WhenAFactoryBuildsA1000TileBoardThenTheDistributionIsExact [

	| factory board |
	factory := self factoryWithTiles: 1000.
	board := factory build.

	self assert: (self countTiles: board ofClass: NoEffect) equals: 400.
	self assert: (self countTiles: board ofClass: WormHole) equals: 200.
	self assert: (self countTiles: board ofClass: SpeedUp) equals: 200.
	self assert: (self countTiles: board ofClass: MoonWalk) equals: 100.
	self assert: (self countTiles: board ofClass: HyperJump) equals: 80.
	self assert: (self countTiles: board ofClass: AtomicBomb) equals: 20
]

{ #category : 'tests' }
BoardFactoryTest >> test009WhenTheDistributionHasARemainderThenItIsAssignedToNoEffect [

	| factory board |
	factory := self factoryWithTiles: 17.
	board := factory build.

	self assert: board numberOfTiles equals: 17.
	self assert: (self countTiles: board ofClass: WormHole) equals: 3.
	self assert: (self countTiles: board ofClass: SpeedUp) equals: 3.
	self assert: (self countTiles: board ofClass: MoonWalk) equals: 1.
	self assert: (self countTiles: board ofClass: HyperJump) equals: 1.
	self assert: (self countTiles: board ofClass: AtomicBomb) equals: 0.
	self assert: (self countTiles: board ofClass: NoEffect) equals: 9
]

{ #category : 'tests' }
BoardFactoryTest >> test010WhenAFactoryBuildsABoardThenTilesAreShuffled [

	| factory board firstTiles allNoEffect |
	factory := self factoryWithTiles: 100.
	board := factory build.
	firstTiles := (1 to: 40) collect: [ :i | board tileAt: i ].
	allNoEffect := firstTiles allSatisfy: [ :each |
		               each isKindOf: NoEffect ].
	self deny: allNoEffect
]

{ #category : 'tests' }
BoardFactoryTest >> test011WhenMoonWalkRangeIsFixedThenAllMoonWalksHaveTheSameValue [

	| factory board moonWalks |
	factory := BoardFactory
		           withTiles: 1000
		           totalParsecs: 1000
		           moonWalkMin: 2
		           moonWalkMax: 2
		           hyperJumpParsecs: #( 100 200 ).
	board := factory build.
	moonWalks := (1 to: board numberOfTiles)
		             collect: [ :i | board tileAt: i ]
		             thenSelect: [ :each | each isKindOf: MoonWalk ].

	self deny: moonWalks isEmpty.
	moonWalks do: [ :mw |
			| n |
			n := mw tilesBack.
			self assert: n equals: 2 ]
]

{ #category : 'tests' }
BoardFactoryTest >> test012WhenMoonWalkRangeIsWideThenDifferentMoonWalksCanHaveDifferentValues [

	| factory board moonWalks allEqual |
	factory := BoardFactory
		           withTiles: 1000
		           totalParsecs: 1000
		           moonWalkMin: 1
		           moonWalkMax: 10
		           hyperJumpParsecs: #( 100 ).
	board := factory build.
	moonWalks := (1 to: board numberOfTiles)
		             collect: [ :i | board tileAt: i ]
		             thenSelect: [ :each | each isKindOf: MoonWalk ].
	allEqual := moonWalks allSatisfy: [ :mw |
		            mw tilesBack = moonWalks first tilesBack ].

	self deny: allEqual
]

{ #category : 'tests' }
BoardFactoryTest >> test013WhenAFactoryBuildsASmallBoardThenItStillWorksCorrectly [

	| factory board |
	factory := self factoryWithTiles: 1.
	board := factory build.
	self assert: board numberOfTiles equals: 1.
	self assert: ((board tileAt: 1) isKindOf: NoEffect)
]
