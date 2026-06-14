Class {
	#name : 'Distance',
	#superclass : 'Object',
	#instVars : [
		'parsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Distance class >> lightYears: aNumberOfLightYears [

	aNumberOfLightYears < 0 ifTrue: [
		Error signal: 'A distance cannot be negative.' ].
	^ self new initializeWithParsecs: aNumberOfLightYears / 3
]

{ #category : 'instance creation' }
Distance class >> parsecs: aNumberOfParsecs [

	aNumberOfParsecs < 0 ifTrue: [
		Error signal: 'A distance cannot be negative.' ].
	^ self new initializeWithParsecs: aNumberOfParsecs
]

{ #category : 'comparing' }
Distance >> = anotherDistance [

	^ (anotherDistance isKindOf: Distance) and: [
		  parsecs = anotherDistance inParsecs ]
]

{ #category : 'comparing' }
Distance >> hash [

	^ parsecs hash
]

{ #category : 'converting' }
Distance >> inLightYears [

	^ parsecs * 3
]

{ #category : 'converting' }
Distance >> inParsecs [

	^ parsecs
]

{ #category : 'initialization' }
Distance >> initializeWithParsecs: aNumberOfParsecs [

	parsecs := aNumberOfParsecs
]
