Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'positionToReach',
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> reaching: aPositionToReach [ 
	^(self new) initializeWithGameGoal: aPositionToReach.  
]

{ #category : 'testing' }
Game >> hasFinished: aSpaceship [
	^(self positionOf: aSpaceship) >= positionToReach
	 
]

{ #category : 'initialization' }
Game >> initializeWithGameGoal: aPositionToReach [ 
	positionToReach := aPositionToReach .
	position := 0. 
	

]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceship steps: aNumberOfSteps [ 
	
	position := (position + aNumberOfSteps) min: positionToReach.
	
	

]

{ #category : 'as yet unclassified' }
Game >> positionOf: aSpaceship [ 
	^ position. 
]
