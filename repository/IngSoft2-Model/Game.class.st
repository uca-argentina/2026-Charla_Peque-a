Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'positionToReach',
		'position',
		'diceCup',
		'players',
		'positions',
		'aCollectionOfSpaceships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> playedBy: aSpaceshipCollection reaching: aGoalPosition [ 
	^(self new) initializeWithPlayers: aSpaceshipCollection reaching: aGoalPosition 
]

{ #category : 'as yet unclassified' }
Game class >> reaching: aPositionToReach [ 
	^(self new) initializeWithGameGoal: aPositionToReach.  
]

{ #category : 'as yet unclassified' }
Game class >> reaching: aPosition with: aDiceCup [ 
	 ^(self new) initializeWithGameGoal: 10 and: aDiceCup.
	

]

{ #category : 'testing' }
Game >> hasFinished: aSpaceship [
	^(self positionOf: aSpaceship) >= positionToReach
	 
]

{ #category : 'initialization' }
Game >> initializeWithGameGoal: aGoalPosition [ 
	positionToReach := aGoalPosition 
]

{ #category : 'initialization' }
Game >> initializeWithPlayers: aSpaceshipCollection reaching: aGoalPosition [ 
	players := aSpaceshipCollection. 
	positionToReach := aGoalPosition. 
	positions := Dictionary new. 
	aCollectionOfSpaceships do: [ :eachSpaceship | positions at: eachSpaceship put: 0 ]. 
	
	
	

]

{ #category : 'as yet unclassified' }
Game >> move: aSpaceship steps: aNumberOfSteps [ 
	
	position := (position + aNumberOfSteps) min: positionToReach.
	
	

]

{ #category : 'as yet unclassified' }
Game >> positionOf: aPlayer [ 
	^true. 
]

{ #category : 'as yet unclassified' }
Game >> roll: aDiceCup [ 
	(aDiceCup isEmptyOrNil ) ifTrue: [Error signal: 'The Dice Cup Cannot Be Empty.' ]. 
	^ aDiceCup sum: [ :aDice | aDice roll].
]
