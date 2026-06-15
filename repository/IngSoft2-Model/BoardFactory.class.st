Class {
	#name : 'BoardFactory',
	#superclass : 'Object',
	#instVars : [
		'numberOfTiles',
		'distribution'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
BoardFactory class >> withTiles: aNumberOfTiles distribution: aDistribution [

	aNumberOfTiles < 1 ifTrue: [
		Error signal: 'A board must have at least one tile.' ].
	aDistribution ifNil: [
		Error signal: 'A board factory must have an effect distribution.' ].
	^ self new
		  initializeWithTiles: aNumberOfTiles
		  distribution: aDistribution
]

{ #category : 'instance creation' }
BoardFactory class >> withTiles: aNumberOfTiles totalParsecs: aTotalParsecs moonWalkRange: mwRange hyperJumpParsecs: aHyperJumpCollection [

	| converter standardDistribution |
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
	converter := ParsecConverter
		             withTotalParsecs: aTotalParsecs
		             numberOfTiles: aNumberOfTiles.
	standardDistribution := EffectDistribution
		                        standardWithConverter: converter
		                        moonWalkRange: mwRange
		                        hyperJumpParsecs: aHyperJumpCollection
		                        source: RandomNumberSource new.
	^ self withTiles: aNumberOfTiles distribution: standardDistribution
]

{ #category : 'building' }
BoardFactory >> build [

	| tiles |
	tiles := (1 to: numberOfTiles) collect: [ :each |
		         Tile with: distribution buildEffect ].
	^ Board withTiles: tiles
]

{ #category : 'accessing' }
BoardFactory >> distribution [

	^ distribution
]

{ #category : 'initialization' }
BoardFactory >> initializeWithTiles: aNumberOfTiles distribution: aDistribution [

	numberOfTiles := aNumberOfTiles.
	distribution := aDistribution
]
