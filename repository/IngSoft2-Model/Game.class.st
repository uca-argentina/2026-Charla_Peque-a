Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'positionToReach',
		'players',
		'winner',
		'diceCup',
		'currentPlayerIndex',
		'positions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> playedBy: aSpaceshipCollection reaching: aGoalPosition withDiceCup: aDiceCup [

	aSpaceshipCollection isEmpty ifTrue: [
		Error signal: 'A game must have at least one player.' ].
	aGoalPosition < 1 ifTrue: [
		Error signal: 'Board size must be a positive number.' ].
	aDiceCup ifNil: [ Error signal: 'A game must have a dice cup.' ].
	^ self new
		  initializeWithPlayers: aSpaceshipCollection
		  reaching: aGoalPosition
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
Game >> initializeWithPlayers: aSpaceshipCollection reaching: aGoalPosition diceCup: aDiceCup [

	players := aSpaceshipCollection.
	positionToReach := aGoalPosition.
	currentPlayerIndex := 1.
	diceCup := aDiceCup.
	winner := nil.
	positions := Dictionary new.
	players do: [ :aShip | positions at: aShip put: 0 ]
]

{ #category : 'private' }
Game >> moveCurrentPlayerByRolling: aNumberOfSteps [

	self hasFinished ifTrue: [
		Error signal: 'The game has already finished.' ].
	self movePlayer: self currentPlayer by: aNumberOfSteps
]

{ #category : 'private' }
Game >> movePlayer: aSpaceship by: aNumberOfSteps [

	| newPosition |
	newPosition := (positions at: aSpaceship) + aNumberOfSteps.
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
