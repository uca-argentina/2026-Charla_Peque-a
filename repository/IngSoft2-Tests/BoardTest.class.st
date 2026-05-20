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

{ #category : 'tests - instance creation' }
BoardTest >> test001ABoardCannotBeCreatedWithAnEmptyTileCollection [
 
	self
		should: [ Board withTiles: #() ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A Board must have at least one tile.' ]

]

{ #category : 'tests - instance creation' }
BoardTest >> test002ABoardCannotBeCreatedWithNonTileElements [
 
	self
		should: [ Board withTiles: { NoEffect new. 'not a cel'}]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'All elements of a Board must be tiles.' ]
]

{ #category : 'tests - instance creation' }
BoardTest >> test003ABoardCanBeCreatedFromACollectionOfTiles [
 
	| aBoard |
	aBoard := Board withTiles: (self noEffectTiles: 10).
	self assert: aBoard notNil
]
