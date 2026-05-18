Class {
	#name : 'MoonWalk',
	#superclass : 'Object',
	#instVars : [
		'stepsBack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
MoonWalk class >> backing: aNumberOfSteps [

	^ self new initializeBacking: aNumberOfSteps
]

{ #category : 'applying' }
MoonWalk >> applyTriggeredBy: triggeringPlayer in: allPlayers on: aBoard [

	allPlayers do: [ :aShip |
			aShip == triggeringPlayer ifFalse: [
				aBoard moveSpaceship: aShip by: stepsBack negated ] ]
]

{ #category : 'initialization' }
MoonWalk >> initializeBacking: aNumberOfSteps [

	stepsBack := aNumberOfSteps
]
