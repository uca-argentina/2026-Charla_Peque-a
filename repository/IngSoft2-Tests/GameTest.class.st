Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001AGameThatStartsIsNotFinished [

	| aGame aShip aDiceCup aBoard |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aShip := 'Spaceship 1'.
	aBoard := Board withNumberOfTiles: 10.
	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 2
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	self deny: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> test002AGameEndsWhenTheGoalIsReached [

	| aGame aShip aDiceCup aBoard |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aShip := 'Spaceship 1'.
	aBoard := Board withNumberOfTiles: 5.
	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 1
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> test003ANewSpaceshipStartsAtPositionOne [

	| aGame aShip aDiceCup aBoard |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aShip := 'Spaceship 1'.
	aBoard := Board withNumberOfTiles: 5.
	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 1
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	self assert: (aGame positionOf: aShip) equals: 1
]

{ #category : 'tests' }
GameTest >> test004APlayerAdvancesInTheCorrectAmountWhenPlayingItsTurn [

	| aGame aShip aDiceCup aBoard |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aShip := 'Spaceship 1'.
	aBoard := Board withNumberOfTiles: 10.
	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 2
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7
]

{ #category : 'tests' }
GameTest >> test005WhenASpaceshipReachesTheGoalThenItWins [

	| aGame aShip aDiceCup aBoard |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aShip := 'Spaceship 1'.
	aBoard := Board withNumberOfTiles: 5.
	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 1
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: aGame winner equals: aShip
]

{ #category : 'tests' }
GameTest >> test006WhenTheGameHasFinishedPlayNextTurnRaisesAnError [

	| aGame aShip aDiceCup aBoard |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aShip := 'Spaceship 1'.
	aBoard := Board withNumberOfTiles: 5.
	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 1
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	aGame playNextTurn.
	self
		should: [ aGame playNextTurn ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'The game has already finished.' ]
]

{ #category : 'tests' }
GameTest >> test007WhenCreatingAGameWithNoPlayersThenErrorIsRaised [

	| aDiceCup aBoard |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aBoard := Board withNumberOfTiles: 10.
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

{ #category : 'tests' }
GameTest >> test008WhenCreatingAGameWithLapsToReachZeroThenErrorIsRaised [

	| aShip aDiceCup aBoard |
	aShip := 'Spaceship 1'.
	aBoard := Board withNumberOfTiles: 20.
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

{ #category : 'tests' }
GameTest >> test009WhenSpaceshipsAdvancesThenItDoesntAffectOtherSpaceshipsPositions [

	| aShip anotherShip aGame aDiceCup aBoard |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aBoard := Board withNumberOfTiles: 15.
	aGame := Game
		         playedBy: {
				         aShip.
				         anotherShip }
		         reachingLaps: 2
		         withBoard: aBoard
		         andDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 1
]

{ #category : 'tests' }
GameTest >> test010WhenAGameDoesntHaveADiceCupThenCannotBeCreated [

	| aShip aBoard |
	aShip := 'Spaceship 1'.
	aBoard := Board withNumberOfTiles: 10.
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

{ #category : 'tests' }
GameTest >> test011WhenPlayNextTurnIsCalledTwiceTheSecondPlayerMoves [

	| aShip anotherShip aGame aDiceCup aBoard |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aBoard := Board withNumberOfTiles: 15.

	aGame := Game
		         playedBy: {
				         aShip.
				         anotherShip }
		         reachingLaps: 2
		         withBoard: aBoard
		         andDiceCup: aDiceCup.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 7
]

{ #category : 'tests' }
GameTest >> test012WhenAllThePlayersPlayedTheirTurnThenTheFirstPlayerPlaysAgain [

	| aShip anotherShip aGame aDiceCup aBoard |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aBoard := Board withNumberOfTiles: 20.
	aGame := Game
		         playedBy: {
				         aShip.
				         anotherShip }
		         reachingLaps: 2
		         withBoard: aBoard
		         andDiceCup: aDiceCup.

	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 7.
	self assert: (aGame positionOf: anotherShip) equals: 7.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 13.
	self assert: (aGame positionOf: anotherShip) equals: 7
]

{ #category : 'tests' }
GameTest >> test013WhenAPlayerReachesTheAmountOfTilesThenTheHeAdvancesToTheFollowingLap [

	| aShip aGame aDiceCup aBoard |
	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aBoard := Board withNumberOfTiles: 5.

	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 2
		         withBoard: aBoard
		         andDiceCup: aDiceCup.

	aGame playNextTurn.
	self assert: (aGame lapOf: aShip) equals: 2
]

{ #category : 'tests' }
GameTest >> test014WhenFirstPlayerPlaysThenSecondPlayerIsTheNextToMove [

	| aShip anotherShip aGame aDiceCup aBoard |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 3) }.
	aBoard := Board withNumberOfTiles: 10.
	aGame := Game
		         playedBy: {
				         aShip.
				         anotherShip }
		         reachingLaps: 2
		         withBoard: aBoard
		         andDiceCup: aDiceCup.

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

{ #category : 'tests' }
GameTest >> test015WhenASpaceshipCompletesALapThenItRetunsToTheFirstTile [

	| aGame aShip aDiceCup aBoard |
	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 11) }.
	aBoard := Board withNumberOfTiles: 10.
	aGame := Game
		         playedBy: { aShip }
		         reachingLaps: 2
		         withBoard: aBoard
		         andDiceCup: aDiceCup.

	aGame playNextTurn.
	"Avanza 11 en tablero de 10. Queda en Vuelta 1, Casillero 2"
	self assert: (aGame lapOf: aShip) equals: 2.
	self assert: (aGame positionOf: aShip) equals: 2.
	self deny: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> test016WhenAShipIsMoreAdvancedThanOtherShipThenItIsHigherInTheRanking [

	| aGame aDiceCup aBoard firstShip secondShip ranking |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 11) }.
	aBoard := Board withNumberOfTiles: 10.
	aGame := Game
		         playedBy: { secondShip. firstShip }
		         reachingLaps: 2
		         withBoard: aBoard
		         andDiceCup: aDiceCup.

	aGame playNextTurn.
	aGame playNextTurn.
	aGame playNextTurn.
	ranking := aGame ranking.
	self assert: (ranking first) equals: secondShip.
	self assert: (ranking last) equals: firstShip.
]
