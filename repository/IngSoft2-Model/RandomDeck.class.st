Class {
	#name : 'RandomDeck',
	#superclass : 'Deck',
	#instVars : [
		'cardClasses',
		'randomSource'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
RandomDeck class >> new [

	^ self withRandomSource: (RandomNumberSource new)
]

{ #category : 'instance creation' }
RandomDeck class >> withRandomSource: aRandomSource [

	^ self basicNew initializeWithRandomSource: aRandomSource
]

{ #category : 'drawing' }
RandomDeck >> draw [

	"Infinite deck: draws one of the six card types with uniform probability."

	| index |
	index := randomSource nextInt: cardClasses size.
	^ (cardClasses at: index) new
]

{ #category : 'initialization' }
RandomDeck >> initializeWithRandomSource: aRandomSource [

	cardClasses := { Overload. Speed. Acceleration. Cancellation. Redo. Repeat }.
	randomSource := aRandomSource
]
