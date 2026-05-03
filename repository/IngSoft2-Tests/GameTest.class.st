Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001AGameThatStartsIsNotFinished [

| aGame aShip |
	aShip := Spaceship withId: 'Spaceship1'.
	aGame := Game playedBy: { aShip } reaching: 10.
	self deny: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> test002AGameEndsWhenTheGoalIsReached [

	| aGame aShip |
	aShip := Spaceship withId: 'Spaceship1'.
	aGame := Game playedBy: { aShip } reaching: 5.
	aGame move: aShip steps: 5.
	self assert: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> test003ANewSpaceshipStartsAtPositionZero [

	| aGame aShip |
	aShip := Spaceship withId: 'Spaceship1'.

	aGame := Game playedBy: { aShip } reaching: 10.
	self assert: (aGame positionOf: aShip ) equals: 0.

]

{ #category : 'tests' }
GameTest >> test004APlayerAdvancesInTheCorrectAmount [
| aGame aShip  |
	aShip := Spaceship withId: 'Spaceship1'.
	aGame := Game playedBy: { aShip } reaching: 20.
	aGame move: aShip steps: 10.
	self assert: (aGame positionOf: aShip) equals: 10.
 
]

{ #category : 'tests' }
GameTest >> test005WhenASpaceshipReachesTheGoalThenItWins [
	| aGame aShip |
	aShip := Spaceship withId: 'Spaceship1'.

	aGame := Game playedBy: { aShip } reaching: 5.
	aGame move: aShip steps: 5.
	self assert: aGame winner equals: aShip
]

{ #category : 'tests' }
GameTest >> test006WhenTheGameHasFinishedThenNoMoreMovesAreAllowed [

	| aGame aShip |
	aShip := Spaceship withId: 'Spaceship1'.

	aGame := Game playedBy: { aShip } reaching: 5.
	aGame move: aShip steps:5. 
	self
		should: [ aGame move: aShip steps: 1 ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'The game has already finished.' ]

]

{ #category : 'tests' }
GameTest >> test007WhenCreatingAGameWithNoPlayersThenErrorIsRaised [

	self
		should: [ Game playedBy: {} reaching: 10 ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'A game must have at least one player.' ]

]

{ #category : 'tests' }
GameTest >> test008WhenCreatingAGameWithPositionToReachZeroThenErrorIsRaised [

| aShip |
	aShip := Spaceship withId: 'Spaceship1'.
	self
		should: [ Game playedBy: { aShip } reaching: 0 ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: error messageText equals: 'Board size must be a positive number.' ]
 

]

{ #category : 'tests' }
GameTest >> test009WhenTheDiceCupIsEmptyThenThereAreNoDiceToRoll [

|aGame aDiceCup|
aDiceCup := {}.
aGame := Game reaching: 10. 
self should:  [aGame roll: aDiceCup] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'The Dice Cup Cannot Be Empty.']


]

{ #category : 'tests' }
GameTest >> test010WhenThereAreMultipleSpaceshipsTheyAllStartAtPositionZero [

    | aGame ship1 ship2 aSpaceshipCollection |
	ship1:=Spaceship new.
	ship2:=Spaceship new.
    aSpaceshipCollection := OrderedCollection with: ship1 with: ship2.
    
    aGame := Game playedBy: aSpaceshipCollection reaching: 10.
    
    "El assert le pregunta a la nave, no al juego"
    self assert: ship1 position equals: 0.
    self assert: ship2 position equals: 0.
]
