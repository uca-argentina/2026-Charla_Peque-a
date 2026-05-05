Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceshipTest >> test001WhenASpaceshipIsCreatedThenItsPositionEqualsToZero [

    |aShip |
	aShip:=Spaceship new.
    self assert: aShip position equals: 0.
]

{ #category : 'tests' }
SpaceshipTest >> test002WhenASpaceshipMovesThenItsPositionChanges [

	| aShip|
	
	aShip:=Spaceship new.
	aShip moves: 2.
	self assert: aShip position equals: 2

]

{ #category : 'tests' }
SpaceshipTest >> test003WhenASpaceshipReachesAPositionThenHasReachedReturnsTrue [

    | aShip |
    aShip := Spaceship new.
    aShip moves: 5.
    self assert: (aShip hasReached: 5).


]

{ #category : 'tests' }
SpaceshipTest >> test004WhenASpaceshipHasNotReachedAPositionThenHasReachedReturnsFalse [

    | aShip |
    aShip := Spaceship new.
    aShip moves: 3.
    self deny: (aShip hasReached: 5).
]
