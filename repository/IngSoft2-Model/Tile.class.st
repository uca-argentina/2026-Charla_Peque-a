Class {
	#name : 'Tile',
	#superclass : 'Object',
	#instVars : [
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Tile class >> with: anEffect [

	anEffect ifNil: [ Error signal: 'A tile must have an effect.' ].
	^ self new initializeWith: anEffect
]

{ #category : 'applying' }
Tile >> applyOn: aGame for: aSpaceship [

	effect applyOn: aGame for: aSpaceship
]

{ #category : 'accessing' }
Tile >> effect [

	^ effect
]

{ #category : 'initialization' }
Tile >> initializeWith: anEffect [

	effect := anEffect
]
