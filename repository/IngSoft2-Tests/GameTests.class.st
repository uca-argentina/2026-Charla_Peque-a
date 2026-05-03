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

|aGame |
aGame := Game reaching: 10 .
aGame move: 'spaceship1' steps: 10.
 

self assert: (aGame hasFinished: 'spaceship1').
]

{ #category : 'tests' }
GameTests >> test003ANewSpaceshipStartsAtPositionZero [

|aGame |
aGame := Game reaching: 10 . 

self assert: (aGame positionOf: 'Spaceship1') equals: 0.
]

{ #category : 'tests' }
GameTests >> test004APlayerAdvancesInTheCorrectAmount [

|aGame |
aGame := Game reaching: 10.
aGame move: 'Spaceship1' steps: 11. 

self assert: (aGame hasFinished: 10). 
]

{ #category : 'tests' }
GameTests >> test005APlayerThatAdvancesInTheRightAmountCannotExceedThePositionToReach [

|aGame |
aGame := Game reaching: 10 . 
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

|aGame aDice|
aGame := Game reaching: 10.  
aDice := Dice withFaces: 6.
aGame move: 'Spaceship1' steps: aDice roll.

self assert: ((aGame positionOf:'Spaceship1') between: 1 and: 6)

]

{ #category : 'tests' }
GameTests >> test008WhenMoreThanOneDiceIsUsedThenThePlayerMovesTheAmountGivenByTheSumOfBothDiceRolls [

|aGame aDiceCup|
aDiceCup := {Dice withFaces: 6. Dice withFaces: 3}.
aGame := Game reaching: 10. 

aGame move: 'Spaceship1' steps: (aGame roll: aDiceCup). 

self assert: ((aGame positionOf:'Spaceship1') between: 1 and: 9)

]

{ #category : 'tests' }
GameTests >> test009WhenTheDiceCupIsEmptyThenThereAreNoDiceToRoll [

|aGame aDiceCup|
aDiceCup := {}.
aGame := Game reaching: 10. 
self should:  [aGame roll: aDiceCup] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'The Dice Cup Cannot Be Empty.']


]

{ #category : 'tests' }
GameTests >> test010WhenThereAreMultipleSpaceshipsTheyAllStartAtPositionZero [

	| aGame aSpaceshipCollection|
	aSpaceshipCollection := OrderedCollection with: 'Spaceship1' with: 'Spaceship2'.
	aGame := Game playedBy: aSpaceshipCollection reaching: 10.
	self assert: (aGame positionOf: 'Spaceship1') equals: 0.
	self assert: (aGame positionOf: 'Spaceship2') equals: 0.
]
