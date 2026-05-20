Class {
	#name : 'BoardFactory',
	#superclass : 'Object',
	#instVars : [
		'numberOfTiles',
		'totalParsecs',
		'moonWalkMin',
		'moonWalkMax',
		'hyperJumpParsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
BoardFactory class >> withTiles: aNumberOfTiles totalParsecs: aTotalParsecs moonWalkRange: mwRange hyperJumpParsecs: aHyperJumpCollection [

	aNumberOfTiles < 1 ifTrue: [
		Error signal: 'A board must have at least one tile.' ].
	aTotalParsecs <= 0 ifTrue: [
		Error signal: 'Total parsecs must be positive.' ].
	mwRange isEmpty ifTrue: [
		Error signal: 'MoonWalk range cannot be empty.' ].
	mwRange first < 1 ifTrue: [
		Error signal: 'MoonWalk min must be at least one.' ].
	mwRange last < mwRange first ifTrue: [
		Error signal: 'MoonWalk max must be greater than or equal to min.' ].
	aHyperJumpCollection isEmpty ifTrue: [
		Error signal: 'HyperJump parsecs list cannot be empty.' ].
	^ self new
		  initializeWithTiles: aNumberOfTiles
		  totalParsecs: aTotalParsecs
		  moonWalkRange: mwRange
		  hyperJumpParsecs: aHyperJumpCollection
]

{ #category : 'building' }
BoardFactory >> build [

	| tiles converter |
	converter := ParsecConverter
		             withTotalParsecs: totalParsecs
		             numberOfTiles: numberOfTiles.

	tiles := (1 to: numberOfTiles) collect: [ :i |
		         self randomTileWithConverter: converter ].

	^ Board withTiles: tiles
]

{ #category : 'initialization' }
BoardFactory >> initializeWithTiles: aNumberOfTiles totalParsecs: aTotalParsecs moonWalkRange: mwRange hyperJumpParsecs: aHyperJumpCollection [

	numberOfTiles := aNumberOfTiles.
	totalParsecs := aTotalParsecs.
	moonWalkMin := mwRange first.
	moonWalkMax := mwRange last.
	hyperJumpParsecs := aHyperJumpCollection
]

{ #category : 'private' }
BoardFactory >> randomMoonWalkValue [

	^ (moonWalkMin to: moonWalkMax) atRandom
]

{ #category : 'private' }
BoardFactory >> randomTileWithConverter: converter [

	| roll |
	roll := (1 to: 100) atRandom.

	roll <= 40 ifTrue: [ ^ NoEffect new ].

	roll <= 60 ifTrue: [ ^ WormHole new ].

	roll <= 80 ifTrue: [ ^ SpeedUp new ].

	roll <= 90 ifTrue: [
		^ MoonWalk withTilesBack: self randomMoonWalkValue ].

	roll <= 98 ifTrue: [
		^ HyperJump withParsecs: hyperJumpParsecs converter: converter ].

	^ AtomicBomb new
]
