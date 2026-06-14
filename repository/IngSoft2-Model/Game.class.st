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
		'board',
		'hands',
		'deck',
		'activePermanents',
		'lastBoardEffect',
		'lastBoardEffectShip',
		'lastResolvedCard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> playedBy: aSpaceshipCollection reachingLaps: aNumberOfLaps withBoard: aBoard andDiceCup: aDiceCup [

	"Convenience for tests that do not exercise cards: uses a random deck."

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

{ #category : 'cards' }
Game >> activatePermanent: aPermanentCard [

	activePermanents add: aPermanentCard
]

{ #category : 'accessing' }
Game >> activePermanents [

	^ activePermanents copy
]

{ #category : 'game logic' }
Game >> advanceToNextPlayer [

	currentPlayerIndex := currentPlayerIndex \\ players size + 1
]

{ #category : 'board effects' }
Game >> applyBoardEffect: anEffect for: aSpaceship [

	"Applies a board effect and records it so a Repeat card can replay it later.
	 An effect that is not repeatable (NoEffect) is not recorded."

	anEffect applyOn: self for: aSpaceship.
	anEffect isRepeatable ifTrue: [
		lastBoardEffect := anEffect.
		lastBoardEffectShip := aSpaceship ]
]

{ #category : 'cards' }
Game >> cancelPermanent: aPermanentCard [

	(activePermanents includes: aPermanentCard) ifFalse: [
		Error signal: 'Cannot cancel a card that is not active.' ].
	activePermanents remove: aPermanentCard
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

{ #category : 'game logic' }
Game >> effectiveRollFor: aSpaceship [

	| roll modifiers |
	roll := diceCup roll.
	modifiers := activePermanents
		             inject: 0
		             into: [ :sum :card | sum + (card modifierFor: aSpaceship) ].
	^ roll + modifiers
]

{ #category : 'cards' }
Game >> giveCardTo: aSpaceship [

	(hands at: aSpaceship) add: deck draw
]

{ #category : 'private' }
Game >> hand: aSpaceship includes: aCard [

	^ (hands at: aSpaceship ifAbsent: [ ^ false ]) includes: aCard
]

{ #category : 'accessing' }
Game >> handOf: aSpaceship [

	^ (hands at: aSpaceship) copy
]

{ #category : 'testing' }
Game >> hasFinished [

	^ winner notNil
]

{ #category : 'initialization' }
Game >> initializeWithPlayers: aSpaceshipCollection reachingLaps: aNumberOfLaps board: aBoard diceCup: aDiceCup deck: aDeck [

	players := aSpaceshipCollection asOrderedCollection copy.
	lapsToReach := aNumberOfLaps.
	currentPlayerIndex := 1.
	diceCup := aDiceCup.
	board := aBoard.
	deck := aDeck.
	winner := nil.
	activePermanents := OrderedCollection new.
	lastBoardEffect := nil.
	lastBoardEffectShip := nil.
	lastResolvedCard := nil.
	positions := Dictionary new.
	hands := Dictionary new.
	players do: [ :aShip |
		positions at: aShip put: (Position at: 1 withLaps: 1).
		hands at: aShip put: (OrderedCollection with: deck draw with: deck draw) ]
]

{ #category : 'accessing' }
Game >> lapOf: aSpaceship [

	^ (positions at: aSpaceship) laps
]

{ #category : 'movement' }
Game >> moveAllSpaceshipsExcept: aSpaceship by: aNumberOfSteps [

	players do: [ :each |
		each = aSpaceship ifFalse: [
			self moveSpaceship: each by: aNumberOfSteps ] ]
]

{ #category : 'movement' }
Game >> moveSpaceship: aSpaceship by: aNumberOfSteps [

	| currentPosition newPosition |
	currentPosition := positions at: aSpaceship.
	newPosition := currentPosition
		               moveBy: aNumberOfSteps
		               withNumberOfTiles: board numberOfTiles.
	positions at: aSpaceship put: newPosition.
	self checkWinner: aSpaceship
]

{ #category : 'cards' }
Game >> play: aCard by: aSpaceship [

	^ self play: aCard by: aSpaceship target: nil
]

{ #category : 'cards' }
Game >> play: aCard by: aSpaceship target: aTarget [

	self hasFinished ifTrue: [
		Error signal: 'Cannot play a card once the game has finished.' ].

	(self hand: aSpaceship includes: aCard) ifFalse: [
		Error signal: 'A ship can only play a card from its own hand.' ].

	(aCard isPermanent and: [ aSpaceship ~= self currentPlayer ]) ifTrue: [
		Error signal: 'A permanent card can only be played on the owner turn.' ].

	(hands at: aSpaceship) remove: aCard.
	aCard playOn: self by: aSpaceship target: aTarget.
	self recordResolvedCard: aCard
]

{ #category : 'game logic' }
Game >> playNextTurn [

	| effectiveRoll |
	self hasFinished ifTrue: [
		Error signal: 'The game has already finished.' ].

	effectiveRoll := self effectiveRollFor: self currentPlayer.
	self moveSpaceship: self currentPlayer by: effectiveRoll.

	self hasFinished ifFalse: [
		board applyEffectFor: self currentPlayer on: self ].

	self advanceToNextPlayer
]

{ #category : 'accessing' }
Game >> positionOf: aSpaceship [

	^ (positions at: aSpaceship) tile
]

{ #category : 'game logic' }
Game >> ranking [

	^ players asSortedCollection: [ :shipA :shipB |
		  (positions at: shipA) isAheadOf: (positions at: shipB) ]
]

{ #category : 'private' }
Game >> recordResolvedCard: aCard [

	"Stores the last resolved card for Redo. A Redo never stores itself:
	 the card it resolved to is recorded inside redoLastCardBy:target:."

	aCard isRecordableAsLastPlayed ifTrue: [ lastResolvedCard := aCard ]
]

{ #category : 'cards' }
Game >> redoLastCardBy: aSpaceship target: aTarget [

	"Replays the last resolved card (never a Redo) with a fresh copy,
	 so a permanent replay becomes an independent active card."

	| replay |
	lastResolvedCard ifNil: [ ^ self ].
	replay := lastResolvedCard copy.
	replay playOn: self by: aSpaceship target: aTarget.
	lastResolvedCard := replay
]

{ #category : 'board effects' }
Game >> repeatLastBoardEffectOn: aTargetSpaceship [

	"Used by the Repeat card. Re-applies the last recorded board effect
	 onto the chosen ship. Does nothing if no effect has happened yet."

	lastBoardEffect ifNil: [ ^ self ].
	lastBoardEffect applyOn: self for: aTargetSpaceship
]

{ #category : 'movement' }
Game >> sendAllSpaceshipsToFirstTile [

	players do: [ :each |
		positions at: each put: (positions at: each) resetToFirstTile ]
]

{ #category : 'accessing' }
Game >> winner [

	^ winner
]
