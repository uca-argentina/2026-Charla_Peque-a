Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceshipTest >> test001WhenCreatedWithANameThenItHasThatName [

	| aShip |
	aShip := Spaceship named: 'Apollo'.
	self assert: aShip name equals: 'Apollo'
]

{ #category : 'tests' }
SpaceshipTest >> test002WhenCreatedThenItStartsAtTileOneInLapOne [

	| aShip |
	aShip := Spaceship named: 'Apollo'.
	self assert: aShip tile equals: 1.
	self assert: aShip laps equals: 1
]

{ #category : 'tests' }
SpaceshipTest >> test003WhenPositionIsUpdatedThenTileAndLapsReflectTheNewPosition [

	| aShip aPosition |
	aShip := Spaceship named: 'Apollo'.
	aPosition := Position at: 5 withLaps: 2.
	aShip position: aPosition.
	self assert: aShip tile equals: 5.
	self assert: aShip laps equals: 2
]

{ #category : 'tests' }
SpaceshipTest >> test004WhenAccessingPositionThenItReturnsTheSameObject [

	| aShip aPosition |
	aShip := Spaceship named: 'Apollo'.
	aPosition := Position at: 3 withLaps: 1.
	aShip position: aPosition.
	self assert: aShip position identicalTo: aPosition
]
