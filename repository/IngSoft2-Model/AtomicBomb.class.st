Class {
	#name : 'AtomicBomb',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
AtomicBomb >> applyTriggeredBy: triggeringPlayer in: allPlayers on: aBoard [

	allPlayers do: [ :aShip | aShip position updatePosition: 1 ]
]
