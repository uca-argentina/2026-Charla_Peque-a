Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001AGameThatStartsIsNotFinished [

	| aGame aShip aDiceCup |
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	aShip := Spaceship withId: 'Spaceship1'.
	aGame := Game playedBy: { aShip } reaching: 10 withDiceCup: aDiceCup.
	self deny: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> test002AGameEndsWhenTheGoalIsReached [

	| aGame aShip aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	aGame := Game playedBy: { aShip } reaching: 5 withDiceCup: aDiceCup.
	aGame move: aShip steps: 5.
	self assert: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> test003ANewSpaceshipStartsAtPositionZero [

	| aGame aShip aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.

	aGame := Game playedBy: { aShip } reaching: 10 withDiceCup: aDiceCup.
	self assert: (aGame positionOf: aShip ) equals: 0.

]

{ #category : 'tests' }
GameTest >> test004APlayerAdvancesInTheCorrectAmount [
| aGame aShip aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	aGame := Game playedBy: { aShip } reaching: 20 withDiceCup: aDiceCup.
	aGame move: aShip steps: 10.
	self assert: (aGame positionOf: aShip) equals: 10.
 
]

{ #category : 'tests' }
GameTest >> test005WhenASpaceshipReachesTheGoalThenItWins [
	| aGame aShip aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.

	aGame := Game playedBy: { aShip } reaching: 5 withDiceCup: aDiceCup.
	aGame move: aShip steps: 5.
	self assert: aGame winner equals: aShip
]

{ #category : 'tests' }
GameTest >> test006WhenTheGameHasFinishedThenNoMoreMovesAreAllowed [

	| aGame aShip aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.

	aGame := Game playedBy: { aShip } reaching: 5 withDiceCup: aDiceCup.
	aGame move: aShip steps: 5. 
	self
		should: [ aGame move: aShip steps: 1 ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'The game has already finished.' ]

]

{ #category : 'tests' }
GameTest >> test007WhenCreatingAGameWithNoPlayersThenErrorIsRaised [
	| aDiceCup |
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	self
		should: [ Game playedBy: {} reaching: 10 withDiceCup: aDiceCup ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'A game must have at least one player.' ]

]

{ #category : 'tests' }
GameTest >> test008WhenCreatingAGameWithPositionToReachZeroThenErrorIsRaised [

| aShip aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	self
		should: [ Game playedBy: { aShip } reaching: 0 withDiceCup: aDiceCup ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'Board size must be a positive number.' ]
 

]

{ #category : 'tests' }
GameTest >> test009WhenSpaceshipsAdvancesThenItDoesntAffectOtherSpaceshipsPositions [

	| aShip anotherShip aGame aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	anotherShip := Spaceship withId: 'Spaceship2'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	
	aGame := Game playedBy: { aShip. anotherShip } reaching: 10 withDiceCup: aDiceCup.
	
	aGame move: aShip steps: 2.
	aGame move: anotherShip steps: 5.
	
	self deny: ( aGame positionOf: aShip ) equals: ( aGame positionOf: anotherShip ).
]

{ #category : 'tests' }
GameTest >> test010WhenAGameDoesntHaveADiceCupThenCannotBeCreated [

	| aShip |
    aShip := Spaceship withId: 'Spaceship1'.
    self
        should: [ Game playedBy: { aShip } reaching: 10 withDiceCup: nil ]
        raise: Error
        withExceptionDo: [ :error |
            self assert: error messageText equals: 'A game must have a dice cup.' ]
]

{ #category : 'tests' }
GameTest >> test011WhenAGamePlayNextTurnThenTheCurrentPlayerMoves [

	| aShip anotherShip aGame aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	anotherShip := Spaceship withId: 'Spaceship2'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	
	aGame := Game playedBy: { aShip. anotherShip } reaching: 10 withDiceCup: aDiceCup.
	
   aGame playNextTurn.
   self assert: aShip position > 0.
   self assert: anotherShip position equals: 0.
]

{ #category : 'tests' }
GameTest >> test012WhenPlayNextTurnIsCalledTwiceTheSecondPlayerMoves [

	| aShip anotherShip aGame aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	anotherShip := Spaceship withId: 'Spaceship2'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	
	aGame := Game playedBy: { aShip. anotherShip } reaching: 10 withDiceCup: aDiceCup.
	
	aGame playNextTurn.
	aGame playNextTurn.
	
   self assert: aShip position > 0.
   self assert: anotherShip position > 0.
]

{ #category : 'tests' }
GameTest >> test013WhenAPlayerReachesTheBoardSizeDuringATurnTheGameFinishes [

	| aShip aGame aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	
	aGame := Game playedBy: { aShip } reaching: 3 withDiceCup: aDiceCup.
	
	[ aGame hasFinished ] whileFalse: [ aGame playNextTurn ].
   self assert: aGame hasFinished.
   self assert: aGame winner equals: aShip.
]

{ #category : 'tests' }
GameTest >> test014WhenTheGameHasFinishedPlayNextTurnRaisesAnError [

	| aShip aGame aDiceCup |
	aShip := Spaceship withId: 'Spaceship1'.
	aDiceCup := DiceCup withDices: { Dice withFaces: 6 }.
	
	aGame := Game playedBy: { aShip } reaching: 3 withDiceCup: aDiceCup.
	
	[ aGame hasFinished ] whileFalse: [ aGame playNextTurn ].
   
	self should: [ aGame playNextTurn ] raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'The game has already finished.' ].
]
