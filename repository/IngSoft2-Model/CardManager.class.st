Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'hands',
		'deck',
		'activePermanents'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardManager class >> withShips: aSpaceshipCollection deck: aDeck [

	^ self new initializeWithShips: aSpaceshipCollection deck: aDeck
]

{ #category : 'cards' }
CardManager >> activatePermanent: aPermanentCard [

	activePermanents add: aPermanentCard
]

{ #category : 'accessing' }
CardManager >> activePermanents [

	^ activePermanents copy
]

{ #category : 'cards' }
CardManager >> cancelPermanent: aPermanentCard [

	aPermanentCard ifNil: [ Error signal: 'Cannot cancel a nil card.' ].
	(activePermanents includes: aPermanentCard) ifFalse: [
		Error signal: 'Cannot cancel a card that is not active.' ].
	activePermanents remove: aPermanentCard
]

{ #category : 'cards' }
CardManager >> giveCardTo: aSpaceship [

	(hands at: aSpaceship) add: deck draw
]

{ #category : 'testing' }
CardManager >> hand: aSpaceship includes: aCard [

	^ (hands at: aSpaceship ifAbsent: [ ^ false ]) includes: aCard
]

{ #category : 'accessing' }
CardManager >> handOf: aSpaceship [

	^ (hands at: aSpaceship) copy
]

{ #category : 'initialization' }
CardManager >> initializeWithShips: aSpaceshipCollection deck: aDeck [

	deck := aDeck.
	activePermanents := OrderedCollection new.
	hands := Dictionary new.
	aSpaceshipCollection do: [ :aShip |
			hands
				at: aShip
				put: (OrderedCollection with: deck draw with: deck draw) ]
]

{ #category : 'cards' }
CardManager >> removeFromHand: aCard of: aSpaceship [

	(hands at: aSpaceship) remove: aCard
]

{ #category : 'effect modifier' }
CardManager >> totalModifierFor: aSpaceship [

	^ activePermanents sum: [ :card | card modifierFor: aSpaceship ]
]
