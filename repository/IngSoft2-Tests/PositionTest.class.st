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
