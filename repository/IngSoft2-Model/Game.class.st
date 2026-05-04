Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'positionToReach',
		'players',
		'winner',
		'diceCup',
		'currentPlayerIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> playedBy: aSpaceshipCollection reaching: aGoalPosition withDiceCup: aDiceCup [
	aSpaceshipCollection isEmpty
		ifTrue: [ Error signal: 'A game must have at least one player.' ].
	aGoalPosition < 1
		ifTrue: [ Error signal: 'Board size must be a positive number.' ].
	aDiceCup
		ifNil: [ Error signal: 'A game must have a dice cup.' ].
	^ (self new) initializeWithPlayers: aSpaceshipCollection reaching: aGoalPosition diceCup: aDiceCup.
]

{ #category : 'testing' }
Game >> hasFinished [
	^ winner isNil not
	 
]

{ #category : 'initialization' }
Game >> initializeWithPlayers: aSpaceshipCollection reaching: aGoalPosition diceCup: aDiceCup [
	players := aSpaceshipCollection. 
	positionToReach := aGoalPosition.
	currentPlayerIndex := 1.
	diceCup := aDiceCup.
	winner := nil.
	
	
	

]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceship steps: aNumberOfSteps [ 
	
	self hasFinished ifTrue: [ Error signal: 'The game has already finished.' ].
	
	aSpaceship moves: aNumberOfSteps.
	
	(aSpaceship position >= positionToReach and: [ winner isNil ]) ifTrue: [ winner := aSpaceship ].
]

{ #category : 'as yet unclassified' }
Game >> playNextTurn [
	| currentPlayer |
	self hasFinished ifTrue: [ Error signal: 'The game has already finished.' ].
	
	currentPlayer := players at: currentPlayerIndex.
	self move: currentPlayer steps: diceCup roll.
	currentPlayerIndex := (currentPlayerIndex \\ players size) + 1.
]

{ #category : 'as yet unclassified' }
Game >> positionOf: aSpaceship [
	^ aSpaceship position.
	
]

{ #category : 'accessing' }
Game >> winner [
 ^ winner.
]
