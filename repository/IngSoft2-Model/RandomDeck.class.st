Class {
	#name : 'RandomDeck',
	#superclass : 'Deck',
	#instVars : [
		'cardPrototypes',
		'randomSource'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
RandomDeck class >> new [

	^ self withRandomSource: RandomNumberSource new
]

{ #category : 'instance creation' }
RandomDeck class >> withRandomSource: aRandomSource [

	aRandomSource ifNil: [
		Error signal: 'A random deck must have a source.' ].
	^ self basicNew initializeWithRandomSource: aRandomSource
]

{ #category : 'drawing' }
RandomDeck >> draw [

	| index |
	index := randomSource nextInt: cardPrototypes size.
	^ (cardPrototypes at: index) new
]

{ #category : 'initialization' }
RandomDeck >> initializeWithRandomSource: aRandomSource [

	cardPrototypes := {
		                  Overload.
		                  Speed.
		                  Acceleration.
		                  Cancellation.
		                  Redo.
		                  Repeat }.
	randomSource := aRandomSource
]
