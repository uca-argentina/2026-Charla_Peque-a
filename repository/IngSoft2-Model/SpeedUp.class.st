Class {
	#name : 'SpeedUp',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
SpeedUp >> applyTriggeredBy: triggeringPlayer in: allPlayers on: aBoard [

	aBoard moveSpaceship: triggeringPlayer by: 4
]
