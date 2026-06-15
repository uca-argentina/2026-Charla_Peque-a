Class {
	#name : 'GameHistory',
	#superclass : 'Object',
	#instVars : [
		'lastBoardEffect',
		'lastBoardEffectShip',
		'lastResolvedCard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
GameHistory class >> new [

	^ self basicNew initialize
]

{ #category : 'board effects' }
GameHistory >> hasBoardEffect [

	^ lastBoardEffect notNil
]

{ #category : 'cards' }
GameHistory >> hasResolvedCard [

	^ lastResolvedCard notNil
]

{ #category : 'board effects' }
GameHistory >> lastBoardEffect [

	^ lastBoardEffect
]

{ #category : 'cards' }
GameHistory >> lastResolvedCard [

	^ lastResolvedCard
]

{ #category : 'board effects' }
GameHistory >> recordBoardEffect: anEffect for: aSpaceship [

	anEffect isRepeatable ifTrue: [
			lastBoardEffect := anEffect.
			lastBoardEffectShip := aSpaceship ]
]

{ #category : 'cards' }
GameHistory >> recordResolvedCard: aCard [

	aCard isRecordableAsLastPlayed ifTrue: [ lastResolvedCard := aCard ]
]
