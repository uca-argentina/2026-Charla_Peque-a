Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'players',
		'diceCup',
		'currentPlayerIndex',
		'board',
		'tracker',
		'history',
		'cardManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> playedBy: aSpaceshipCollection reachingLaps: aNumberOfLaps withBoard: aBoard andDiceCup: aDiceCup [

	^ self
		  playedBy: aSpaceshipCollection
		  reachingLaps: aNumberOfLaps
		  withBoard: aBoard
		  andDiceCup: aDiceCup
		  withDeck: RandomDeck new
]

{ #category : 'instance creation' }
Game class >> playedBy: aSpaceshipCollection reachingLaps: aNumberOfLaps withBoard: aBoard andDiceCup: aDiceCup withDeck: aDeck [

	aSpaceshipCollection isEmpty ifTrue: [
		Error signal: 'A game must have at least one player.' ].
	aNumberOfLaps < 1 ifTrue: [
		Error signal: 'The game must reach at least one lap' ].
	aBoard ifNil: [ Error signal: 'A game must have a board' ].
	aDiceCup ifNil: [ Error signal: 'A game must have a dice cup.' ].
	aDeck ifNil: [ Error signal: 'A game must have a deck.' ].
	^ self new
		  initializeWithPlayers: aSpaceshipCollection
		  reachingLaps: aNumberOfLaps
		  board: aBoard
		  diceCup: aDiceCup
		  deck: aDeck
]

{ #category : 'card callbacks' }
Game >> activatePermanent: aPermanentCard [

	cardManager activatePermanent: aPermanentCard
]

{ #category : 'public api' }
Game >> activePermanents [

	^ cardManager activePermanents
]

{ #category : 'private' }
Game >> advanceToNextPlayer [

	currentPlayerIndex := currentPlayerIndex \\ players size + 1
]

{ #category : 'private' }
Game >> applyBoardEffect: anEffect for: aSpaceship [

	anEffect applyOn: self for: aSpaceship.
	history recordBoardEffect: anEffect for: aSpaceship
]

{ #category : 'private' }
Game >> applyTileEffectFor: aSpaceship [

	| tile appliedEffect |
	tile := board tileFor: (self positionOf: aSpaceship).
	appliedEffect := tile applyOn: self for: aSpaceship.
	history recordBoardEffect: appliedEffect for: aSpaceship
]

{ #category : 'card callbacks' }
Game >> cancelPermanent: aPermanentCard [

	cardManager cancelPermanent: aPermanentCard
]

{ #category : 'public api' }
Game >> currentPlayer [

	^ players at: currentPlayerIndex
]

{ #category : 'private' }
Game >> effectiveRollFor: aSpaceship [

	^ diceCup roll + (cardManager totalModifierFor: aSpaceship)
]

{ #category : 'effect callbacks' }
Game >> giveCardTo: aSpaceship [

	cardManager giveCardTo: aSpaceship
]

{ #category : 'public api' }
Game >> handOf: aSpaceship [

	^ cardManager handOf: aSpaceship
]

{ #category : 'public api' }
Game >> hasFinished [

	^ tracker hasWinner
]

{ #category : 'initialization' }
Game >> initializeWithPlayers: aSpaceshipCollection reachingLaps: aNumberOfLaps board: aBoard diceCup: aDiceCup deck: aDeck [

	players := aSpaceshipCollection asOrderedCollection copy.
	currentPlayerIndex := 1.
	diceCup := aDiceCup.
	board := aBoard.
	tracker := SpaceshipTracker
		           withShips: players
		           numberOfTiles: aBoard numberOfTiles
		           reachingLaps: aNumberOfLaps.
	history := GameHistory new.
	cardManager := CardManager withShips: players deck: aDeck
]

{ #category : 'public api' }
Game >> lapOf: aSpaceship [

	^ tracker lapOf: aSpaceship
]

{ #category : 'effect callbacks' }
Game >> moveAllSpaceshipsExcept: aSpaceship by: aNumberOfSteps [

	tracker moveAllExcept: aSpaceship by: aNumberOfSteps
]

{ #category : 'effect callbacks' }
Game >> moveSpaceship: aSpaceship by: aNumberOfSteps [

	tracker move: aSpaceship by: aNumberOfSteps
]

{ #category : 'public api' }
Game >> play: aCard by: aSpaceship target: aTarget [

	self hasFinished ifTrue: [
		Error signal: 'Cannot play a card once the game has finished.' ].

	(cardManager hand: aSpaceship includes: aCard) ifFalse: [
		Error signal: 'A ship can only play a card from its own hand.' ].

	(aCard isPermanent and: [ aSpaceship ~= self currentPlayer ])
		ifTrue: [
			Error signal:
				'A permanent card can only be played on the owner turn.' ].

	cardManager removeFromHand: aCard of: aSpaceship.
	aCard playOn: self by: aSpaceship target: aTarget.
	history recordResolvedCard: aCard
]

{ #category : 'public api' }
Game >> playNextTurn [

	| effectiveRoll |
	self hasFinished ifTrue: [
		Error signal: 'The game has already finished.' ].

	effectiveRoll := self effectiveRollFor: self currentPlayer.
	self moveSpaceship: self currentPlayer by: effectiveRoll.

	self hasFinished ifFalse: [
		self applyTileEffectFor: self currentPlayer ].

	self advanceToNextPlayer
]

{ #category : 'public api' }
Game >> positionOf: aSpaceship [

	^ tracker positionOf: aSpaceship
]

{ #category : 'public api' }
Game >> ranking [

	^ tracker rankingOf: players
]

{ #category : 'card callbacks' }
Game >> redoLastCardBy: aSpaceship target: aTarget [

	| replay |
	history hasResolvedCard ifFalse: [ ^ self ].
	replay := history lastResolvedCard copy.
	replay playOn: self by: aSpaceship target: aTarget
]

{ #category : 'card callbacks' }
Game >> repeatLastBoardEffectOn: aTargetSpaceship [

	history hasBoardEffect ifFalse: [ ^ self ].
	history lastBoardEffect applyOn: self for: aTargetSpaceship
]

{ #category : 'effect callbacks' }
Game >> sendAllSpaceshipsToFirstTile [

	tracker sendAllToFirstTile
]

{ #category : 'public api' }
Game >> winner [

	^ tracker winner
]
