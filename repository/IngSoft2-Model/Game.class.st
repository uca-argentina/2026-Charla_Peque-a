Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'positionToReach'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> reaching: aPositionToReach [ 
	^(self new) initializeWithGameGoal: aPositionToReach.  
]

{ #category : 'testing' }
Game >> hasFinished: aPosition [

	(aPosition >= positionToReach) ifTrue: [^true]. 
	^false
	 
]

{ #category : 'initialization' }
Game >> initializeWithGameGoal: aPositionToReach [ 
	positionToReach := aPositionToReach 
]

{ #category : 'as yet unclassified' }
Game >> move: aString steps: anInteger [ 
	self shouldBeImplemented.
]

{ #category : 'as yet unclassified' }
Game >> positionOf: aSpaceship [ 
	^0.
]
