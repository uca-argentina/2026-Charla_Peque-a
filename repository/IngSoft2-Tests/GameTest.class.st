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
	aGame := Game playedBy: { aShip } reachingLaps: 2 withBoard: aBoard andDiceCup: aDiceCup.
	self deny: aGame hasFinished
	

]

{ #category : 'tests' }
GameTest >> test002AGameEndsWhenTheGoalIsReached [

	| aGame aShip aDiceCup aBoard |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aShip := 'Spaceship 1'.
	aBoard := Board withNumberOfTiles: 5.
	aGame := Game playedBy: { aShip } reachingLaps: 1 withBoard: aBoard andDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> test003ANewSpaceshipStartsAtPositionZero [

	| aGame aShip aDiceCup |
	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.

	aGame := Game playedBy: { aShip } reaching: 10 withDiceCup: aDiceCup.
	self assert: (aGame positionOf: aShip) equals: 0
]

{ #category : 'tests' }
GameTest >> test004APlayerAdvancesInTheCorrectAmountWhenPlayingItsTurn [

	| aGame aShip aDiceCup |
	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aGame := Game playedBy: { aShip } reaching: 20 withDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 6
]

{ #category : 'tests' }
GameTest >> test005WhenASpaceshipReachesTheGoalThenItWins [

	| aGame aShip aDiceCup |
	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aGame := Game playedBy: { aShip } reaching: 5 withDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: aGame winner equals: aShip
]

{ #category : 'tests' }
GameTest >> test006WhenTheGameHasFinishedPlayNextTurnRaisesAnError [

	| aGame aShip aDiceCup |
	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.

	aGame := Game playedBy: { aShip } reaching: 5 withDiceCup: aDiceCup.
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

	| aDiceCup |
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	self
		should: [ Game playedBy: {  } reaching: 10 withDiceCup: aDiceCup ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A game must have at least one player.' ]
]

{ #category : 'tests' }
GameTest >> test008WhenCreatingAGameWithPositionToReachZeroThenErrorIsRaised [

	| aShip aDiceCup |
	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	self
		should: [
		Game playedBy: { aShip } reaching: 0 withDiceCup: aDiceCup ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Board size must be a positive number.' ]
]

{ #category : 'tests' }
GameTest >> test009WhenSpaceshipsAdvancesThenItDoesntAffectOtherSpaceshipsPositions [

	| aShip anotherShip aGame aDiceCup |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.
	aGame := Game
		         playedBy: {
				         aShip.
				         anotherShip }
		         reaching: 10
		         withDiceCup: aDiceCup.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 6.
	self assert: (aGame positionOf: anotherShip) equals: 0
]

{ #category : 'tests' }
GameTest >> test010WhenAGameDoesntHaveADiceCupThenCannotBeCreated [

	| aShip |
	aShip := 'Spaceship 1'.
	self
		should: [ Game playedBy: { aShip } reaching: 10 withDiceCup: nil ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'A game must have a dice cup.' ]
]

{ #category : 'tests' }
GameTest >> test011WhenPlayNextTurnIsCalledTwiceTheSecondPlayerMoves [

	| aShip anotherShip aGame aDiceCup |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.

	aGame := Game
		         playedBy: {
				         aShip.
				         anotherShip }
		         reaching: 10
		         withDiceCup: aDiceCup.

	aGame playNextTurn.
	aGame playNextTurn.

	self assert: (aGame positionOf: aShip) equals: 6.
	self assert: (aGame positionOf: anotherShip) equals: 6
]

{ #category : 'tests' }
GameTest >> test012WhenAllThePlayersPlayedTheirTurnThenTheFirstPlayerPlaysAgain [

	| aShip anotherShip aGame aDiceCup |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.

	aGame := Game
		         playedBy: {
				         aShip.
				         anotherShip }
		         reaching: 20
		         withDiceCup: aDiceCup.

	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 6.
	self assert: (aGame positionOf: anotherShip) equals: 6.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 12.
	self assert: (aGame positionOf: anotherShip) equals: 6
]

{ #category : 'tests' }
GameTest >> test013WhenAPlayerReachesTheBoardSizeDuringATurnTheGameFinishes [

	| aShip aGame aDiceCup |
	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 6) }.

	aGame := Game playedBy: { aShip } reaching: 3 withDiceCup: aDiceCup.

	aGame playNextTurn.
	self assert: aGame hasFinished.
	self assert: aGame winner equals: aShip
]

{ #category : 'tests' }
GameTest >> test014WhenFirstPlayerPlaysThenSecondPlayerIsTheNextToMove [

	| aShip anotherShip aGame aDiceCup |
	aShip := 'Spaceship 1'.
	anotherShip := 'Spaceship 2'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 3) }.
	aGame := Game
		         playedBy: {
				         aShip.
				         anotherShip }
		         reaching: 20
		         withDiceCup: aDiceCup.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 3.
	self assert: (aGame positionOf: anotherShip) equals: 0.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 3.
	self assert: (aGame positionOf: anotherShip) equals: 3.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 6.
	self assert: (aGame positionOf: anotherShip) equals: 3
]

{ #category : 'tests' }
GameTest >> test015WhenASpaceshipCompletesALapThenItRetunsToTheFirstTile [

|aGame aShip aDiceCup aBoard|

	aShip := 'Spaceship 1'.
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: 11) }.
	aBoard := Board withNumberOfTiles: 10.
	aGame := Game playedBy: { aShip } reachingLaps: 2 withBoard: aBoard andDiceCup: aDiceCup.
	
	aGame playNextTurn.
	"Avanza 11 en tablero de 10. Queda en Vuelta 1, Casillero 2"
	self assert: (aGame lapOf: aShip) equals: 1.
	self assert: (aGame positionOf: aShip) equals: 2.
	self deny: aGame hasFinished. 
]
