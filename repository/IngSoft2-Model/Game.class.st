Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'players',
		'winner',
		'diceCup',
		'currentPlayerIndex',
		'lapsToReach',
		'board'
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

{ #category : 'private' }
Game >> checkWinner: aSpaceship [

	aSpaceship laps > lapsToReach ifTrue: [ winner := aSpaceship ]
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
	lapsToReach := aNumberOfLaps.
	currentPlayerIndex := 1.
	diceCup := aDiceCup.
	winner := nil.
	players do: [ :aShip | aShip position: (Position at: 1 withLaps: 1) ].
	board := aBoard
]

{ #category : 'accessing' }
Game >> lapOf: aSpaceship [

	^ aSpaceship laps
]

{ #category : 'private' }
Game >> moveCurrentPlayerByRolling: aNumberOfSteps [

	self hasFinished ifTrue: [
		Error signal: 'The game has already finished.' ].
	self movePlayer: self currentPlayer by: aNumberOfSteps
]

{ #category : 'private' }
Game >> movePlayer: aSpaceship by: aNumberOfSteps [

	board
		moveSpaceship: aSpaceship
		players: players
		advancing: aNumberOfSteps.
	self checkWinner: aSpaceship
]

{ #category : 'game logic' }
Game >> playNextTurn [

	self moveCurrentPlayerByRolling: diceCup roll.
	self advanceToNextPlayer
]

{ #category : 'accessing' }
Game >> positionOf: aSpaceship [

	^ aSpaceship tile
]

{ #category : 'game logic' }
Game >> ranking [
	"Devuelve una colección de naves ordenadas desde la primera hasta la última."

	^ players sorted: [ :shipA :shipB |
			  | posA posB |
			  posA := shipA position.
			  posB := shipB position.
			  posA laps > posB laps or: [
				  posA laps = posB laps and: [ posA tile > posB tile ] ] ]
]

{ #category : 'accessing' }
Game >> winner [

	^ winner
]
