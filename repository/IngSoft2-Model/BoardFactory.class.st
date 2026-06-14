Class {
	#name : 'BoardFactory',
	#superclass : 'Object',
	#instVars : [
		'numberOfTiles',
		'totalParsecs',
		'moonWalkMin',
		'moonWalkMax',
		'hyperJumpParsecs',
		'randomSource'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
BoardFactory class >> withTiles: aNumberOfTiles totalParsecs: aTotalParsecs moonWalkRange: mwRange hyperJumpParsecs: aHyperJumpCollection [

	^ self
		  withTiles: aNumberOfTiles
		  totalParsecs: aTotalParsecs
		  moonWalkRange: mwRange
		  hyperJumpParsecs: aHyperJumpCollection
		  randomSource: RandomNumberSource new
]

{ #category : 'instance creation' }
BoardFactory class >> withTiles: aNumberOfTiles totalParsecs: aTotalParsecs moonWalkRange: mwRange hyperJumpParsecs: aHyperJumpCollection randomSource: aRandomSource [

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
		  randomSource: aRandomSource
]

{ #category : 'building' }
BoardFactory >> build [

	| tiles converter |
	converter := ParsecConverter
		             withTotalParsecs: totalParsecs
		             numberOfTiles: numberOfTiles.

	tiles := (1 to: numberOfTiles) collect: [ :i |
		         Tile with: (self randomEffectWithConverter: converter) ].

	^ Board withTiles: tiles
]

{ #category : 'initialization' }
BoardFactory >> initializeWithTiles: aNumberOfTiles totalParsecs: aTotalParsecs moonWalkRange: mwRange hyperJumpParsecs: aHyperJumpCollection randomSource: aRandomSource [

	numberOfTiles := aNumberOfTiles.
	totalParsecs := aTotalParsecs.
	moonWalkMin := mwRange first.
	moonWalkMax := mwRange last.
	hyperJumpParsecs := aHyperJumpCollection.
	randomSource := aRandomSource
]

{ #category : 'private' }
BoardFactory >> randomEffectWithConverter: converter [

	"Distribution (entrega 3):
	 NoEffect 30%, WormHole 20%, SpeedUp 20%, MoonWalk 10%,
	 HyperJump 8%, AtomicBomb 2%, GiveCard 10%."

	| roll |
	roll := randomSource nextInt: 100.

	roll <= 30 ifTrue: [ ^ NoEffect new ].
	roll <= 50 ifTrue: [ ^ WormHole new ].
	roll <= 70 ifTrue: [ ^ SpeedUp new ].
	roll <= 80 ifTrue: [ ^ MoonWalk withTilesBack: self randomMoonWalkValue ].
	roll <= 88 ifTrue: [ ^ HyperJump withParsecs: hyperJumpParsecs converter: converter ].
	roll <= 90 ifTrue: [ ^ AtomicBomb new ].
	^ GiveCard new
]

{ #category : 'private' }
BoardFactory >> randomMoonWalkValue [

	| span offset |
	span := moonWalkMax - moonWalkMin + 1.
	offset := randomSource nextInt: span.
	^ moonWalkMin + offset - 1
]
