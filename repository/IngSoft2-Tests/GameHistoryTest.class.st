Class {
	#name : 'GameHistoryTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - board effects' }
GameHistoryTest >> test001ANewHistoryHasNoBoardEffect [

	self deny: GameHistory new hasBoardEffect
]

{ #category : 'tests - board effects' }
GameHistoryTest >> test002ARepeatableEffectIsRecorded [

	| history ship |
	history := GameHistory new.
	ship := 'Spaceship 1'.
	history recordBoardEffect: SpeedUp new for: ship.
	self assert: history hasBoardEffect.
	self assert: history lastBoardEffect class equals: SpeedUp
]

{ #category : 'tests - board effects' }
GameHistoryTest >> test003ANonRepeatableEffectIsNotRecorded [

	| history ship |
	history := GameHistory new.
	ship := 'Spaceship 1'.
	history recordBoardEffect: NoEffect new for: ship.
	self deny: history hasBoardEffect
]

{ #category : 'tests - cards' }
GameHistoryTest >> test004ANewHistoryHasNoResolvedCard [

	self deny: GameHistory new hasResolvedCard
]

{ #category : 'tests - cards' }
GameHistoryTest >> test005ARecordableCardIsRemembered [

	| history |
	history := GameHistory new.
	history recordResolvedCard: Speed new.
	self assert: history hasResolvedCard.
	self assert: history lastResolvedCard class equals: Speed
]

{ #category : 'tests - cards' }
GameHistoryTest >> test006ARedoIsNotRecordedAsTheLastResolvedCard [

	| history |
	history := GameHistory new.
	history recordResolvedCard: Redo new.
	self deny: history hasResolvedCard
]
