Class {
	#name : 'LoadedDice',
	#superclass : 'Object',
	#instVars : [
		'forcedResult'
	],
	#classInstVars : [
		'forcedResult'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
LoadedDice class >> withForcedResult: aNumber [
		aNumber < 0 ifTrue: [ Error signal: 'The forced result cannot be negative '   ].
		
		^ (self new) initializeWithForcedResult: aNumber 
	
]

{ #category : 'initialization' }
LoadedDice >> initializeWithForcedResult: aNumber [

	forcedResult := aNumber
]

{ #category : 'game logic' }
LoadedDice >> roll [

	^ forcedResult
]
