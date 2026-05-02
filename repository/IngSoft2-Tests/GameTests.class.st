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
self assert: (aGame hasFinished: 11).
]

{ #category : 'tests' }
GameTests >> test003ANewPlayerStartsAtPositionZero [

|aGame|
aGame := Game reaching: 10.  

self assert: (aGame positionOf: 'Spaceship1') equals: 0.
]

{ #category : 'tests' }
GameTests >> test003APlayerAdvancesInTheCorrectAmount [

|aGame|
aGame := Game reaching: 10.  
aGame move: 'Spaceship1' steps: 4. 

self assert: (aGame positionOf: 'Spaceship1') equals: 4.
]
