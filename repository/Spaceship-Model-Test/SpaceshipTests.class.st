Class {
	#name : 'SpaceshipTests',
	#superclass : 'TestCase',
	#category : 'Spaceship-Model-Test',
	#package : 'Spaceship-Model-Test'
}

{ #category : 'tests' }
SpaceshipTests >> test001WhenSpaceshipIsInitializedPositionIsInOrigin [
| aSpaceship |

aSpaceship:= Spaceship new. 

self assert: aSpaceship position equals: 0.
]

{ #category : 'tests' }
SpaceshipTests >> test002WhenSpaceshipAdvancesThenPositionChanges [

    | aSpaceship |

    aSpaceship := Spaceship new.
    aSpaceship advance: 5.

    self assert: aSpaceship position equals: 5
]

{ #category : 'tests' }
SpaceshipTests >> test003WhenSpaceshipAdvancesTwiceThenPositionAccumulates [

    | aSpaceship |

    aSpaceship := Spaceship new.
    aSpaceship advance: 3.
    aSpaceship advance: 4.

    self assert: aSpaceship position equals: 7.
]

{ #category : 'tests' }
SpaceshipTests >> test004WhenSpaceshipAdvancesZeroThenPositionDoesNotChange [

    | aSpaceship |

    aSpaceship := Spaceship new.
    aSpaceship advance: 0.

    self assert: aSpaceship position equals: 0.
]

{ #category : 'tests' }
SpaceshipTests >> test005SpaceshipCannotAdvanceNegativeAmount [

    | aSpaceship |

    aSpaceship := Spaceship new.

    self should: [ aSpaceship advance: -2 ] raise: Error.
]
