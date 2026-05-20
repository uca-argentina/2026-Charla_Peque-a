Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'players',
		'winner',
		'diceCup',
		'currentPlayerIndex',
		'positions',
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

	(positions at: aSpaceship) laps > lapsToReach ifTrue: [
		winner := aSpaceship ]
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
	positions := Dictionary new.
	players do: [ :aShip |
		positions at: aShip put: (Position at: 1 withLaps: 1) ].
	board := aBoard.
]

{ #category : 'accessing' }
Game >> lapOf: aSpaceship [

	^ (positions at: aSpaceship) laps
]

{ #category : 'game logic' }
Game >> moveAllSpaceshipsExceptCurrentBy: aNumberOfSteps [
	"Mensaje invocado por los efectos para mover a todas las naves excepto una.
	No dispara nuevos efectos."
	players do: [ :each |
		(each = (self currentPlayer)) ifFalse: [
			self moveSpaceship: each by: aNumberOfSteps ] ]
]

{ #category : 'game logic' }
Game >> moveCurrentPlayerByRolling: aNumberOfSteps [

	self hasFinished ifTrue: [
		Error signal: 'The game has already finished.' ].

	self moveSpaceship: self currentPlayer by: aNumberOfSteps.

	self hasFinished ifFalse: [
		board applyEffectFor: self currentPlayer on: self ]
]

{ #category : 'game logic' }
Game >> moveSpaceship: aSpaceship by: aNumberOfSteps [

	| currentPosition newPosition |
	currentPosition := positions at: aSpaceship.
	newPosition := currentPosition moveBy: aNumberOfSteps on: board.
	positions at: aSpaceship put: newPosition.
	self checkWinner: aSpaceship
]

{ #category : 'game logic' }
Game >> playNextTurn [

	self moveCurrentPlayerByRolling: diceCup roll.
	self advanceToNextPlayer
]

{ #category : 'accessing' }
Game >> positionOf: aSpaceship [

	^ (positions at: aSpaceship) tile
]

{ #category : 'game logic' }
Game >> ranking [
	"Devuelve una colección de naves ordenadas desde la primera hasta la última."
	^ players sorted: [ :shipA :shipB |
		| posA posB |
		posA := positions at: shipA.
		posB := positions at: shipB.
		
		posA laps > posB laps or: [
			posA laps = posB laps and: [ posA tile > posB tile ] ] ].
]

{ #category : 'game logic' }
Game >> sendAllSpaceshipsToFirstTile [

	players do: [ :each |
		positions at: each put: (positions at: each) resetToFirstTile ]
]

{ #category : 'accessing' }
Game >> winner [

	^ winner
]
