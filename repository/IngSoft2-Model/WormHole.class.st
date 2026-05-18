Class {
	#name : 'WormHole',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
WormHole >> applyTriggeredBy: triggeringPlayer in: allPlayers on: aBoard [

	aBoard moveSpaceship: triggeringPlayer by: -4
]
