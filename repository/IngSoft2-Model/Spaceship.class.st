Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'name',
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Spaceship class >> named: aString [

	^ self new initializeNamed: aString
]

{ #category : 'initialization' }
Spaceship >> initializeNamed: aName [

	name := aName.
	position := Position at: 1 withLaps: 1
]

{ #category : 'accessing' }
Spaceship >> laps [

	^ position laps
]

{ #category : 'accessing' }
Spaceship >> name [

	^ name
]

{ #category : 'accessing' }
Spaceship >> position [

	^ position
]

{ #category : 'accessing' }
Spaceship >> position: aPosition [

	position := aPosition
]

{ #category : 'accessing' }
Spaceship >> tile [

	^ position tile
]
