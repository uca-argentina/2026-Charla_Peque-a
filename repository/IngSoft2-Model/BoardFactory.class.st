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
BoardFactory class >> withTiles: aNumberOfTiles totalParsecs: aTotalParsecs moonWalkMin: aMin moonWalkMax: aMax hyperJumpParsecs: aHyperJumpCollection [

	aNumberOfTiles < 1 ifTrue: [
		Error signal: 'A board must have at least one tile.' ].
	aTotalParsecs <= 0 ifTrue: [
		Error signal: 'Total parsecs must be positive.' ].
	aMin < 1 ifTrue: [
		Error signal: 'MoonWalk min must be at least one.' ].
	aMax < aMin ifTrue: [
		Error signal: 'MoonWalk max must be greater than or equal to min.' ].
	aHyperJumpCollection isEmpty ifTrue: [
		Error signal: 'HyperJump parsecs list cannot be empty.' ].
	^ self new
		  initializeWithTiles: aNumberOfTiles
		  totalParsecs: aTotalParsecs
		  moonWalkMin: aMin
		  moonWalkMax: aMax
		  hyperJumpParsecs: aHyperJumpCollection
]

{ #category : 'building' }
BoardFactory >> build [

	| tiles converter counts |
	counts := self computeCounts.
	converter := ParsecConverter
		             withTotalParsecs: totalParsecs
		             numberOfTiles: numberOfTiles.

	tiles := OrderedCollection new.
	(counts at: #noEffect) timesRepeat: [ tiles add: NoEffect new ].
	(counts at: #wormHole) timesRepeat: [ tiles add: WormHole new ].
	(counts at: #speedUp) timesRepeat: [ tiles add: SpeedUp new ].
	(counts at: #moonWalk) timesRepeat: [
		tiles add: (MoonWalk withTilesBack: self randomMoonWalkValue) ].
	(counts at: #hyperJump) timesRepeat: [
			tiles add:
				(HyperJump withParsecs: hyperJumpParsecs converter: converter) ].
	(counts at: #atomicBomb) timesRepeat: [ tiles add: AtomicBomb new ].

	^ Board withTiles: (self shuffle: tiles)
]

{ #category : 'private' }
BoardFactory >> computeCounts [


	| counts noEffectCount wormHoleCount speedUpCount moonWalkCount hyperJumpCount atomicBombCount assigned remainder |
	wormHoleCount := (numberOfTiles * 20 / 100) truncated.
	speedUpCount := (numberOfTiles * 20 / 100) truncated.
	moonWalkCount := (numberOfTiles * 10 / 100) truncated.
	hyperJumpCount := (numberOfTiles * 8 / 100) truncated.
	atomicBombCount := (numberOfTiles * 2 / 100) truncated.
	noEffectCount := (numberOfTiles * 40 / 100) truncated.

	assigned := noEffectCount + wormHoleCount + speedUpCount
	            + moonWalkCount + hyperJumpCount + atomicBombCount.
	remainder := numberOfTiles - assigned.
	noEffectCount := noEffectCount + remainder.

	counts := Dictionary new.
	counts at: #noEffect put: noEffectCount.
	counts at: #wormHole put: wormHoleCount.
	counts at: #speedUp put: speedUpCount.
	counts at: #moonWalk put: moonWalkCount.
	counts at: #hyperJump put: hyperJumpCount.
	counts at: #atomicBomb put: atomicBombCount.
	^ counts
]

{ #category : 'initialization' }
BoardFactory >> initializeWithTiles: aNumberOfTiles totalParsecs: aTotalParsecs moonWalkMin: aMin moonWalkMax: aMax hyperJumpParsecs: aHyperJumpCollection [

	numberOfTiles := aNumberOfTiles.
	totalParsecs := aTotalParsecs.
	moonWalkMin := aMin.
	moonWalkMax := aMax.
	hyperJumpParsecs := aHyperJumpCollection
]

{ #category : 'private' }
BoardFactory >> randomMoonWalkValue [

^(moonWalkMin to: moonWalkMax ) atRandom .
]

{ #category : 'private' }
BoardFactory >> shuffle: aCollection [

	| array n j temp random |
	random:= Random new.
	array := aCollection asArray copy.
	n := array size.
	n to: 2 by: -1 do: [ :i |
			j := random nextInteger: i.
			temp := array at: i.
			array at: i put: (array at: j).
			array at: j put: temp ].
	^ array
]
