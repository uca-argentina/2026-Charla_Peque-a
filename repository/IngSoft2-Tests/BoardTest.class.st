Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001WhenTheNumberOfTilesIsNegativeThenTheBoardIsNotCreated [

	self
		should: [ Board withNumberOfTiles: -1 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A Board must have at least one tile.' ]
]

{ #category : 'tests' }
BoardTest >> test002WhenTheNumberOfTilesIsPositiveThenTheBoardIsCreated [
	
	|aBoard|
	aBoard := Board withNumberOfTiles: 10.
	self assert: aBoard notNil. 
]

{ #category : 'tests' }
BoardTest >> test003WhenTheNumberOfTilesIsEqualToZeroThenTheBoardIsNotCreated [

	self
		should: [ Board withNumberOfTiles: 0 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A Board must have at least one tile.' ]
]
