Class {
	#name : 'PositionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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

	| position newPosition |
	position := Position at: 3 withLaps: 1.
	newPosition := position moveBy: 4 withNumberOfTiles: 10.
	self assert: newPosition tile equals: 7.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests - moving forward' }
PositionTest >> test005WhenAPositionMovesForwardToExactlyTheLastTileThenItStaysInTheSameLap [

	| position newPosition |
	position := Position at: 5 withLaps: 1.
	newPosition := position moveBy: 5 withNumberOfTiles: 10.
	self assert: newPosition tile equals: 10.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests - moving forward' }
PositionTest >> test006WhenAPositionMovesForwardBeyondTheLastTileThenItWrapsAroundAndIncrementsLap [

	| position newPosition |
	position := Position at: 8 withLaps: 1.
	newPosition := position moveBy: 5 withNumberOfTiles: 10.
	self assert: newPosition tile equals: 3.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving forward' }
PositionTest >> test007WhenAPositionMovesForwardExactlyOneLapThenItReturnsToFirstTileAndIncrementsLap [

	| position newPosition |
	position := Position at: 1 withLaps: 1.
	newPosition := position moveBy: 5 withNumberOfTiles: 5.
	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving forward' }
PositionTest >> test008WhenAPositionMovesForwardMultipleLapsThenItIncrementsLapCorrectly [

	| position newPosition |
	position := Position at: 3 withLaps: 1.
	newPosition := position moveBy: 12 withNumberOfTiles: 5.
	self assert: newPosition tile equals: 5.
	self assert: newPosition laps equals: 3
]

{ #category : 'tests - moving backward' }
PositionTest >> test009WhenAPositionMovesBackwardWithinTheSameLapThenItRetreatsCorrectly [

	| position newPosition |
	position := Position at: 7 withLaps: 2.
	newPosition := position moveBy: -3 withNumberOfTiles: 10.
	self assert: newPosition tile equals: 4.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving backward' }
PositionTest >> test010WhenAPositionMovesBackwardToExactlyTheFirstTileThenItStaysInTheSameLap [

	| position newPosition |
	position := Position at: 5 withLaps: 2.
	newPosition := position moveBy: -4 withNumberOfTiles: 10.
	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving backward' }
PositionTest >> test011WhenAPositionMovesBackwardBeyondTheFirstTileThenItWrapsAroundAndDecrementsLap [

	| position newPosition |
	position := Position at: 3 withLaps: 2.
	newPosition := position moveBy: -5 withNumberOfTiles: 10.
	self assert: newPosition tile equals: 8.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests - moving backward' }
PositionTest >> test012WhenAPositionMovesBackwardExactlyOneLapThenItGoesToLastTileOfPreviousLap [

	| position newPosition |
	position := Position at: 1 withLaps: 3.
	newPosition := position moveBy: -5 withNumberOfTiles: 5.
	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - moving backward' }
PositionTest >> test013WhenAPositionMovesBackwardMultipleLapsThenItDecrementsLapCorrectly [

	| position newPosition |
	position := Position at: 2 withLaps: 5.
	newPosition := position moveBy: -12 withNumberOfTiles: 5.
	self assert: newPosition tile equals: 5.
	self assert: newPosition laps equals: 2
]

{ #category : 'tests - clamping' }
PositionTest >> test014WhenAPositionMovesBackwardBeforeTheStartThenItClampsToFirstTileAndFirstLap [

	| position newPosition |
	position := Position at: 3 withLaps: 1.
	newPosition := position moveBy: -10 withNumberOfTiles: 10.
	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests - clamping' }
PositionTest >> test015WhenAPositionMovesBackwardManyLapsBeforeTheStartThenItClampsToFirstTileAndFirstLap [

	| position newPosition |
	position := Position at: 2 withLaps: 2.
	newPosition := position moveBy: -50 withNumberOfTiles: 5.
	self assert: newPosition tile equals: 1.
	self assert: newPosition laps equals: 1
]

{ #category : 'tests - comparing' }
PositionTest >> test016WhenAPositionHasMoreLapsThenItIsAheadOfAnotherWithFewerLaps [

	| ahead behind |
	ahead := Position at: 1 withLaps: 3.
	behind := Position at: 9 withLaps: 2.
	self assert: (ahead isAheadOf: behind).
	self deny: (behind isAheadOf: ahead)
]

{ #category : 'tests - comparing' }
PositionTest >> test017WhenTwoPositionsShareLapsThenTheOneOnAFurtherTileIsAhead [

	| ahead behind |
	ahead := Position at: 7 withLaps: 2.
	behind := Position at: 4 withLaps: 2.
	self assert: (ahead isAheadOf: behind).
	self deny: (behind isAheadOf: ahead)
]

{ #category : 'tests - comparing' }
PositionTest >> test018WhenTwoPositionsAreEqualThenNeitherIsAheadOfTheOther [

	| onePosition anotherPosition |
	onePosition := Position at: 5 withLaps: 2.
	anotherPosition := Position at: 5 withLaps: 2.
	self deny: (onePosition isAheadOf: anotherPosition).
	self deny: (anotherPosition isAheadOf: onePosition)
]
