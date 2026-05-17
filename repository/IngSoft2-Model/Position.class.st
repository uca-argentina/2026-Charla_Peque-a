Class {
	#name : 'Position',
	#superclass : 'Object',
	#instVars : [
		'position',
		'lap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Position class >> at: aStartingPosition withLaps: aNumberOfLaps [

	(aStartingPosition < 1) ifTrue: [ Error signal: 'Starting position cannot be less than one.' ].
	(aNumberOfLaps < 1) ifTrue: [ Error signal: 'Number of Laps cannot be less than one.'].

	^(self new) initializeAt: aStartingPosition withLaps: aNumberOfLaps 
]

{ #category : 'game logic' }
Position >> addLap [
	lap := lap + 1
]

{ #category : 'initialization' }
Position >> initializeAt: startingPosition withLaps: laps [

	position := startingPosition .
	lap := laps. 
]

{ #category : 'game logic' }
Position >> updatePosition: aNewPosition [
	position := aNewPosition. 
	
]
