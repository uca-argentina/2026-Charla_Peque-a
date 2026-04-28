Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SpaceshipTest >> test001WhenSpaceshipIsInitializedPositionIsInOrigin [ 
| aSpaceship |

aSpaceship:= Spaceship new. 

self assert: aSpaceship position equals: 0.
]

{ #category : 'tests' }
SpaceshipTest >> test002WhenSpaceshipAdvancesThenPositionChanges [ 

    | aSpaceship |

    aSpaceship := Spaceship new.
    aSpaceship advance: 5.

    self assert: aSpaceship position equals: 5
]

{ #category : 'tests' }
SpaceshipTest >> test003WhenSpaceshipAdvancesTwiceThenPositionAccumulates [ 

    | aSpaceship |

    aSpaceship := Spaceship new.
    aSpaceship advance: 3.
    aSpaceship advance: 4.

    self assert: aSpaceship position equals: 7.
]
