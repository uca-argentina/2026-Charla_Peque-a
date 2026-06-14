Class {
	#name : 'SequenceDeck',
	#superclass : 'Deck',
	#instVars : [
		'cards',
		'currentIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
SequenceDeck class >> withCards: aCardCollection [

	aCardCollection isEmpty ifTrue: [
		Error signal: 'A sequence deck cannot be empty.' ].
	^ self new initializeWithCards: aCardCollection
]

{ #category : 'drawing' }
SequenceDeck >> draw [

	"Deterministic deck for testing. Cycles through a fixed sequence of cards,
	 returning a fresh copy each time so callers get independent instances."

	| card |
	card := cards at: currentIndex.
	currentIndex := currentIndex \\ cards size + 1.
	^ card copy
]

{ #category : 'initialization' }
SequenceDeck >> initializeWithCards: aCardCollection [

	cards := aCardCollection asOrderedCollection copy.
	currentIndex := 1
]
