Class {
	#name : 'GameTests',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTests >> test001AGameThatStartsIsNotFinished [

|aGame|
aGame := Game reaching: 10. 

self deny: (aGame hasFinished: 9).
]

{ #category : 'tests' }
GameTests >> test002AGameEndsWhenTheGoalIsReached [

|aGame|
aGame := Game reaching: 10.
aGame move: 'spaceship1' steps: 10.
 

self assert: (aGame hasFinished: 'spaceship1').
]

{ #category : 'tests' }
GameTests >> test003ANewSpaceshipStartsAtPositionZero [

|aGame|
aGame := Game reaching: 10.  

self assert: (aGame positionOf: 'Spaceship1') equals: 0.
]

{ #category : 'tests' }
GameTests >> test004APlayerAdvancesInTheCorrectAmount [

|aGame|
aGame := Game reaching: 10.  
aGame move: 'Spaceship1' steps: 11. 

self assert: (aGame hasFinished: 10). 
]

{ #category : 'tests' }
GameTests >> test005APlayerThatAdvancesInTheRightAmountCannotExceedThePositionToReach [

|aGame|
aGame := Game reaching: 10.  
aGame move: 'Spaceship1' steps: 11. 

self assert: (aGame positionOf: 'Spaceship1') equals: 10.
]

{ #category : 'tests' }
GameTests >> test006WhenASpaceshipReachesTheGoalPositionThenTheGameEnds [

|aGame|
aGame := Game reaching: 10.  
aGame move: 'Spaceship1' steps: 11. 

self assert: (aGame hasFinished: 'Spaceship1'). 
]

{ #category : 'tests' }
GameTests >> test007WhenSpaceshipAdvancesThenTheAmountOfStepsIsDeterminedByADice [

|aGame aDice numberOfSteps|
aGame := Game reaching: 10.  
aDice := Random new. 
numberOfSteps := aDice nextInteger: 6. 
aGame move: 'Spaceship1' steps: numberOfSteps. 

self assert:((aGame positionOf:'Spaceship1') between: 1 and: 6). 
]
