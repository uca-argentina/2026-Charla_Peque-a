Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
BoardTest >> noEffectTiles: n [
 
	^ (1 to: n) collect: [ :i | NoEffect new ]
]

{ #category : 'tests' }
BoardTest >> test001ABoardCannotBeCreatedWithAnEmptyTileCollection [
 
	self
		should: [ Board withTiles: #() ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A Board must have at least one tile.' ]

]

{ #category : 'tests' }
BoardTest >> test002ABoardCannotBeCreatedWithNonTileElements [
 
	self
		should: [ Board withTiles: { NoEffect new. 'not a cell' } ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'All elements of a Board must be tiles.' ]
]

{ #category : 'tests' }
BoardTest >> test003ABoardCanBeCreatedFromACollectionOfTiles [
 
	| aBoard |
	aBoard := Board withTiles: (self noEffectTiles: 10).
	self assert: aBoard notNil
]

{ #category : 'tests' }
BoardTest >> test004WhenAdvancingFromAPositionThenANewPositionIsReturned [
 
	| aBoard aPosition newPosition |
	aBoard := Board withTiles: (self noEffectTiles: 10).
	aPosition := Position at: 3 withLaps: 1.
	newPosition := aBoard fromPosition: aPosition advancing: 4.
	self assert: newPosition tile equals: 7.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests' }
BoardTest >> test005WhenAdvancingPastTheLastTileThenLapIncreases [
 
	| aBoard aPosition newPosition |
	aBoard := Board withTiles: (self noEffectTiles: 10).
	aPosition := Position at: 8 withLaps: 1.
	newPosition := aBoard fromPosition: aPosition advancing: 5.
	self assert: newPosition tile equals: 3.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests' }
BoardTest >> test006WhenMovingBackwardsThenPositionDecreases [
 
	| aBoard aPosition newPosition |
	aBoard := Board withTiles: (self noEffectTiles: 10).
	aPosition := Position at: 5 withLaps: 2.
	newPosition := aBoard fromPosition: aPosition advancing: -3.
	self assert: newPosition tile equals: 2.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests' }
BoardTest >> test007WhenMovingBackwardsPastFirstTileThenLapDecreases [
 
	| aBoard aPosition newPosition |
	aBoard := Board withTiles: (self noEffectTiles: 10).
	aPosition := Position at: 2 withLaps: 2.
	newPosition := aBoard fromPosition: aPosition advancing: -5.
	self assert: newPosition tile equals: 7.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests' }
BoardTest >> test008WhenMovingBackwardsBeyondStartThenPositionClampsToOrigin [
 
	| aBoard aPosition newPosition |
	aBoard := Board withTiles: (self noEffectTiles: 10).
	aPosition := Position at: 1 withLaps: 1.
	newPosition := aBoard fromPosition: aPosition advancing: -5.
	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 1
]
