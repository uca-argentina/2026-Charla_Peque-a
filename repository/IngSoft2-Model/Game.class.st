Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'positionToReach',
		'players',
		'winner',
		'diceCup',
		'currentPlayerIndex',
		'positions',
		'lapsToReach',
		'board',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> playedBy: aSpaceshipCollection reachingLaps: aNumberOfLaps withBoard: aBoard andDiceCup: aDiceCup [

	aSpaceshipCollection isEmpty ifTrue: [
		Error signal: 'A game must have at least one player.' ].

	aNumberOfLaps < 1 ifTrue: [
		Error signal: 'The game must reach at least one lap' ].

	aBoard ifNil: [ Error signal: 'A game must have a board' ].

	aDiceCup ifNil: [ Error signal: 'A game must have a dice cup.' ].
	^ self new
		  initializeWithPlayers: aSpaceshipCollection
		  reachingLaps: aNumberOfLaps
		  board: aBoard
		  diceCup: aDiceCup
]

{ #category : 'game logic' }
Game >> advanceToNextPlayer [

	currentPlayerIndex := currentPlayerIndex \\ players size + 1
]

{ #category : 'accessing' }
Game >> currentPlayer [

	^ players at: currentPlayerIndex
]

{ #category : 'testing' }
Game >> hasFinished [

	^ winner notNil
]

{ #category : 'initialization' }
Game >> initializeWithPlayers: aSpaceshipCollection reachingLaps: aNumberOfLaps board: aBoard diceCup: aDiceCup [

	players := aSpaceshipCollection.
	lapsToReach := aNumberOfLaps .
	currentPlayerIndex := 1.
	diceCup := aDiceCup.
	winner := nil.
	positions := Dictionary new.
	laps := Dictionary new. 
	players do: [ :aShip | positions at: aShip put: (Position at: 1 withLaps: 1)]. 
	board:= aBoard.
]

{ #category : 'private' }
Game >> moveCurrentPlayerByRolling: aNumberOfSteps [

	self hasFinished ifTrue: [
		Error signal: 'The game has already finished.' ].
	
	self movePlayer: self currentPlayer by: aNumberOfSteps
]

{ #category : 'private' }
Game >> movePlayer: aSpaceship by: aNumberOfSteps [

	| newPositionValue newPosition |
	newPositionValue := (positions at: aSpaceship) + aNumberOfSteps.
	newPositionValue >= positionToReach ifTrue: [ winner := aSpaceship ]


	
	

	positions at: aSpaceship put: newPosition.
	newPosition >= positionToReach ifTrue: [ winner := aSpaceship ]
]

{ #category : 'game logic' }
Game >> playNextTurn [

	self moveCurrentPlayerByRolling: diceCup roll.
	self advanceToNextPlayer
]

{ #category : 'accessing' }
Game >> positionOf: aSpaceship [

	^ positions at: aSpaceship
]

{ #category : 'accessing' }
Game >> winner [

	^ winner
]
