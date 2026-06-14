Class {
	#name : 'SequencedRandomSource',
	#superclass : 'Object',
	#instVars : [
		'values',
		'currentIndex'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
SequencedRandomSource class >> withValues: aCollection [

	aCollection isEmpty ifTrue: [
		Error signal: 'A sequenced random source cannot be empty.' ].
	^ self new initializeWithValues: aCollection
]

{ #category : 'initialization' }
SequencedRandomSource >> initializeWithValues: aCollection [

	values := aCollection asOrderedCollection copy.
	currentIndex := 1
]

{ #category : 'generating' }
SequencedRandomSource >> nextInt: aMaximum [

	"Returns the next forced value, ignoring aMaximum. Cycles through the sequence.
	 Lets tests drive BoardFactory and RandomDeck deterministically."

	| value |
	value := values at: currentIndex.
	currentIndex := currentIndex \\ values size + 1.
	^ value
]
