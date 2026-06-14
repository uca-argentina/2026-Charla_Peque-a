Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
BoardTest >> noEffectTiles: n [

	^ (1 to: n) collect: [ :i | Tile with: NoEffect new ]
]

{ #category : 'tests - instance creation' }
BoardTest >> test001ABoardCannotBeCreatedWithAnEmptyTileCollection [

	self
		should: [ Board withTiles: #(  ) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'A Board must have at least one tile.' ]
]

{ #category : 'tests - instance creation' }
BoardTest >> test002ABoardCannotBeCreatedWithElementsThatAreNotTiles [

	"A board accepts anything that understands the tile protocol (applyOn:for:).
	 A bare string does not, so the board rejects it."

	self
		should: [
			Board withTiles: {
					(Tile with: NoEffect new).
					'not a tile' } ]
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
	self assert: aBoard notNil.
	self assert: aBoard numberOfTiles equals: 10
]

{ #category : 'tests - aliasing' }
BoardTest >> test004ABoardDoesNotChangeWhenTheSourceCollectionIsModified [

	| source aBoard |
	source := (self noEffectTiles: 5) asOrderedCollection.
	aBoard := Board withTiles: source.
	source removeFirst.
	self assert: aBoard numberOfTiles equals: 5
]
