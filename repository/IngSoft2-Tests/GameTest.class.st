Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
GameTest >> gameWithBoard: aBoard players: aShipCollection laps: n dice: aResult [

	| aDiceCup |
	aDiceCup := DiceCup withDice:
		            { (LoadedDice withForcedResult: aResult) }.
	^ Game
		  playedBy: aShipCollection
		  reachingLaps: n
		  withBoard: aBoard
		  andDiceCup: aDiceCup
		  withDeck: (SequenceDeck withCards: { Acceleration new })
]

{ #category : 'helpers' }
GameTest >> noEffectBoard: n [

	^ Board withTiles:
		  ((1 to: n) collect: [ :i | Tile with: NoEffect new ])
]

{ #category : 'tests - game start/finish' }
GameTest >> test001AGameThatStartsIsNotFinished [

	| aGame aShip aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 10.
	aGame := self
		         gameWithBoard: aBoard
		         players: { aShip }
		         laps: 2
		         dice: 6.
	self deny: aGame hasFinished
]

{ #category : 'tests - game start/finish' }
GameTest >> test002WhenTheGoalIsReachedThenTheGameEnds [

	| aGame aShip aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 5.
	aGame := self
		         gameWithBoard: aBoard
		         players: { aShip }
		         laps: 1
		         dice: 6.
	aGame playNextTurn.
	self assert: aGame hasFinished
]

{ #category : 'tests - game logic' }
GameTest >> test003ANewSpaceshipStartsAtPositionOne [

	| aGame aShip aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 5.
	aGame := self
		         gameWithBoard: aBoard
		         players: { aShip }
		         laps: 1
		         dice: 6.
	self assert: (aGame positionOf: aShip) equals: 1
]

{ #category : 'tests - game logic' }
GameTest >> test004WhenAPlayerPlaysItsTurnThenItAdvancesByTheRoll [

	| aGame aShip aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 10.
	aGame := self
		         gameWithBoard: aBoard
		         players: { aShip }
		         laps: 2
		         dice: 6.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7
]

{ #category : 'tests - game logic' }
GameTest >> test005WhenASpaceshipReachesTheGoalThenItWins [

	| aGame aShip aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 5.
	aGame := self
		         gameWithBoard: aBoard
		         players: { aShip }
		         laps: 1
		         dice: 6.
	aGame playNextTurn.
	self assert: aGame winner equals: aShip
]

{ #category : 'tests - game start/finish' }
GameTest >> test006WhenTheGameHasFinishedPlayNextTurnRaisesAnError [

	| aGame aShip aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 5.
	aGame := self
		         gameWithBoard: aBoard
		         players: { aShip }
		         laps: 1
		         dice: 6.
	aGame playNextTurn.
	self
		should: [ aGame playNextTurn ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'The game has already finished.' ]
]

{ #category : 'tests - instance creation' }
GameTest >> test007WhenCreatingAGameWithNoPlayersThenErrorIsRaised [

	| aDiceCup aBoard |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aBoard := self noEffectBoard: 10.
	self
		should: [
				Game
					playedBy: {  }
					reachingLaps: 2
					withBoard: aBoard
					andDiceCup: aDiceCup ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A game must have at least one player.' ]
]

{ #category : 'tests - instance creation' }
GameTest >> test008WhenCreatingAGameWithLapsToReachZeroThenErrorIsRaised [

	| aShip aDiceCup aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 20.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	self
		should: [
				Game
					playedBy: { aShip }
					reachingLaps: 0
					withBoard: aBoard
					andDiceCup: aDiceCup ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'The game must reach at least one lap' ]
]

{ #category : 'tests - game logic' }
GameTest >> test009WhenSpaceshipsAdvancesThenItDoesntAffectOtherSpaceshipsPositions [

	| aShip anotherShip aGame aBoard |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aBoard := self noEffectBoard: 15.
	aGame := self
		         gameWithBoard: aBoard
		         players: {
				         aShip.
				         anotherShip }
		         laps: 2
		         dice: 6.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 1
]

{ #category : 'tests - instance creation' }
GameTest >> test010WhenAGameDoesntHaveADiceCupThenCannotBeCreated [

	| aShip aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 10.
	self
		should: [
				Game
					playedBy: { aShip }
					reachingLaps: 10
					withBoard: aBoard
					andDiceCup: nil ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'A game must have a dice cup.' ]
]

{ #category : 'tests - game logic' }
GameTest >> test011WhenPlayNextTurnIsCalledTwiceTheSecondPlayerMoves [

	| aShip anotherShip aGame aBoard |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aBoard := self noEffectBoard: 15.
	aGame := self
		         gameWithBoard: aBoard
		         players: {
				         aShip.
				         anotherShip }
		         laps: 2
		         dice: 6.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 7
]

{ #category : 'tests - game logic' }
GameTest >> test012WhenAllThePlayersPlayedTheirTurnThenTheFirstPlayerPlaysAgain [

	| aShip anotherShip aGame aBoard |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aBoard := self noEffectBoard: 20.
	aGame := self
		         gameWithBoard: aBoard
		         players: {
				         aShip.
				         anotherShip }
		         laps: 2
		         dice: 6.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 7.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 13.
	self assert: (aGame positionOf: anotherShip) equals: 7
]

{ #category : 'tests - game logic' }
GameTest >> test013WhenAPlayerReachesTheAmountOfTilesThenItAdvancesToTheFollowingLap [

	| aShip aGame aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 5.
	aGame := self
		         gameWithBoard: aBoard
		         players: { aShip }
		         laps: 2
		         dice: 6.
	aGame playNextTurn.
	self assert: (aGame lapOf: aShip) equals: 2
]

{ #category : 'tests - game logic' }
GameTest >> test014WhenFirstPlayerPlaysThenSecondPlayerIsTheNextToMove [

	| aShip anotherShip aGame aBoard |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aBoard := self noEffectBoard: 10.
	aGame := self
		         gameWithBoard: aBoard
		         players: {
				         aShip.
				         anotherShip }
		         laps: 2
		         dice: 3.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 1.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 4.
	self assert: (aGame positionOf: anotherShip) equals: 4.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 4
]

{ #category : 'tests - game logic' }
GameTest >> test015WhenASpaceshipCompletesALapThenItReturnsToTheFirstTile [

	| aGame aShip aBoard |
	aShip := 'Spaceship 1'.
	aBoard := self noEffectBoard: 10.
	aGame := self
		         gameWithBoard: aBoard
		         players: { aShip }
		         laps: 2
		         dice: 11.
	aGame playNextTurn.
	self assert: (aGame lapOf: aShip) equals: 2.
	self assert: (aGame positionOf: aShip) equals: 2.
	self deny: aGame hasFinished
]

{ #category : 'tests - ranking' }
GameTest >> test016WhenAShipIsMoreAdvancedThanOtherShipThenItIsHigherInTheRanking [

	| aGame aBoard firstShip secondShip ranking |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aBoard := self noEffectBoard: 10.
	aGame := self
		         gameWithBoard: aBoard
		         players: {
				         secondShip.
				         firstShip }
		         laps: 5
		         dice: 11.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	ranking := aGame ranking.
	self assert: ranking first equals: secondShip.
	self assert: ranking last equals: firstShip
]

{ #category : 'tests - ranking' }
GameTest >> test017RankingContainsAllPlayersAtStartOfGame [

	| aGame aBoard firstShip secondShip ranking |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aBoard := self noEffectBoard: 10.
	aGame := self
		         gameWithBoard: aBoard
		         players: {
				         firstShip.
				         secondShip }
		         laps: 2
		         dice: 1.
	ranking := aGame ranking.
	self assert: ranking size equals: 2.
	self assert: (ranking includes: firstShip).
	self assert: (ranking includes: secondShip)
]

{ #category : 'tests - ranking' }
GameTest >> test018WhenRankingShipsThenLapsAreConsideredBeforeTileWithinTheLap [

	| aGame aBoard firstShip secondShip ranking |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aBoard := self noEffectBoard: 10.
	aGame := self
		         gameWithBoard: aBoard
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 11.
	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	ranking := aGame ranking.
	self assert: ranking first equals: firstShip.
	self assert: ranking last equals: secondShip
]

{ #category : 'tests - instance creation' }
GameTest >> test019AGameCannotBeCreatedWithoutABoard [

	| aShip aDiceCup |
	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	self
		should: [
				Game
					playedBy: { aShip }
					reachingLaps: 2
					withBoard: nil
					andDiceCup: aDiceCup ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'A game must have a board' ]
]
