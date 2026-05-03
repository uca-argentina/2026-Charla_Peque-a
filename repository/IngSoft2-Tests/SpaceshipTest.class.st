Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceshipTest >> test001WhenASpaceshipIsCreatedThenItsPositionEqualsToZero [

    |aShip |
	aShip:=Spaceship withId: 'Spaceship1'.
    self assert: aShip position equals: 0.
]

{ #category : 'tests' }
SpaceshipTest >> test002WhenASpaceshipMovesThenItsPositionChanges [

	| aShip|
	
	aShip:=Spaceship withId: 'Space1'.
	aShip moves: 2.
	self assert: aShip position equals: 2

]

{ #category : 'tests' }
SpaceshipTest >> test003WhenASpaceshipIdEqualsTheSentIdThenReturnsTrue [

	| aShip anId|
	anId:='Spaceship1'.
	aShip := Spaceship withId: anId .
	
	self assert: (aShip matchId: 'Spaceship1')

]

{ #category : 'tests' }
SpaceshipTest >> test004WhenASpaceshipIdDoesNotMatchTheSentIdThenReturnsFalse [
 
	| aShip |
	aShip := Spaceship withId: 'Spaceship1'.
	self deny: (aShip matchId: 'AnotherShip')

]
