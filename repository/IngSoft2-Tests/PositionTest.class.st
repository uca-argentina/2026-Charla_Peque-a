Class {
	#name : 'PositionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
PositionTest >> boardWithTiles: n [

	^ Board withTiles: ((1 to: n) collect: [ :i | NoEffect new ])
]

{ #category : 'tests - instance creation' }
PositionTest >> test001WhenCreatingAPositionWithValidParametersThenItIsCreated [

	| position |
	position := Position at: 5 withLaps: 2.
	self assert: position tile equals: 5.
	self assert: position laps equals: 2
]

{ #category : 'tests - instance creation' }
PositionTest >> test002WhenCreatingAPositionWithTileLessThanOneThenItCannotBeCreated [

	self
		should: [ Position at: 0 withLaps: 1 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Starting position cannot be less than one.' ]
]

{ #category : 'tests - instance creation' }
PositionTest >> test003WhenCreatingAPositionWithLapsLessThanOneThenItCannotBeCreated [

	self
		should: [ Position at: 1 withLaps: 0 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Number of Laps cannot be less than one.' ]
]

{ #category : 'tests - moving forward' }
PositionTest >> test004WhenAPositionMovesForwardWithinTheSameLapThenItAdvancesCorrectly [

	| board position newPosition |
	board := self boardWithTiles: 10.
	position := Position at: 3 withLaps: 1.
	newPosition := position moveBy: 4 on: board.

	self assert: newPosition tile equals: 7.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests - moving forward' }
PositionTest >> test005WhenAPositionMovesForwardToExactlyTheLastTileThenItStaysInTheSameLap [

	| board position newPosition |
	board := self boardWithTiles: 10.
	position := Position at: 5 withLaps: 1.
	newPosition := position moveBy: 5 on: board.

	self assert: newPosition tile equals: 10.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests - moving forward' }
PositionTest >> test006WhenAPositionMovesForwardBeyondTheLastTileThenItWrapsAroundAndIncrementsLap [

	| board position newPosition |
	board := self boardWithTiles: 10.
	position := Position at: 8 withLaps: 1.
	newPosition := position moveBy: 5 on: board.
	self assert: newPosition tile equals: 3.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving forward' }
PositionTest >> test007WhenAPositionMovesForwardExactlyOneLapThenItReturnsToFirstTileAndIncrementsLap [

	| board position newPosition |
	board := self boardWithTiles: 5.
	position := Position at: 1 withLaps: 1.
	newPosition := position moveBy: 5 on: board.

	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving forward' }
PositionTest >> test008WhenAPositionMovesForwardMultipleLapsThenItIncrementsLapCorrectly [

	| board position newPosition |
	board := self boardWithTiles: 5.
	position := Position at: 3 withLaps: 1.
	newPosition := position moveBy: 12 on: board.

	self assert: newPosition tile equals: 5.
	self assert: newPosition laps equals: 3
]

{ #category : 'tests - moving backward' }
PositionTest >> test009WhenAPositionMovesBackwardWithinTheSameLapThenItRetreatsCorrectly [

	| board position newPosition |
	board := self boardWithTiles: 10.
	position := Position at: 7 withLaps: 2.
	newPosition := position moveBy: -3 on: board.

	self assert: newPosition tile equals: 4.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving backward' }
PositionTest >> test010WhenAPositionMovesBackwardToExactlyTheFirstTileThenItStaysInTheSameLap [

	| board position newPosition |
	board := self boardWithTiles: 10.
	position := Position at: 5 withLaps: 2.
	newPosition := position moveBy: -4 on: board.

	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving backward' }
PositionTest >> test011WhenAPositionMovesBackwardBeyondTheFirstTileThenItWrapsAroundAndDecrementsLap [

	| board position newPosition |
	board := self boardWithTiles: 10.
	position := Position at: 3 withLaps: 2.
	newPosition := position moveBy: -5 on: board.
	self assert: newPosition tile equals: 8.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests - moving backward' }
PositionTest >> test012WhenAPositionMovesBackwardExactlyOneLapThenItGoesToLastTileOfPreviousLap [

	| board position newPosition |
	board := self boardWithTiles: 5.
	position := Position at: 1 withLaps: 3.
	newPosition := position moveBy: -5 on: board.

	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving backward' }
PositionTest >> test013WhenAPositionMovesBackwardMultipleLapsThenItDecrementsLapCorrectly [

	| board position newPosition |
	board := self boardWithTiles: 5.
	position := Position at: 2 withLaps: 5.
	newPosition := position moveBy: -12 on: board.
	self assert: newPosition tile equals: 5.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - clamping' }
PositionTest >> test014WhenAPositionMovesBackwardBeforeTheStartThenItClampsToFirstTileAndFirstLap [

	| board position newPosition |
	board := self boardWithTiles: 10.
	position := Position at: 3 withLaps: 1.
	newPosition := position moveBy: -10 on: board.
	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests - clamping' }
PositionTest >> test015WhenAPositionMovesBackwardManyLapsBeforeTheStartThenItClampsToFirstTileAndFirstLap [

	| board position newPosition |
	board := self boardWithTiles: 5.
	position := Position at: 2 withLaps: 2.
	newPosition := position moveBy: -50 on: board.

	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 1
]
