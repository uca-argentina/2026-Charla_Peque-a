Class {
	#name : 'HyperJump',
	#superclass : 'Effect',
	#instVars : [
		'distances',
		'currentIndex',
		'converter'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperJump class >> withDistances: aDistanceList converter: aConverter [

	aDistanceList isEmpty ifTrue: [
		Error signal: 'HyperJump must have at least one parsec value.' ].
	aConverter ifNil: [ Error signal: 'HyperJump must have a converter.' ].
	^ self new
		  initializeWithDistances: aDistanceList
		  converter: aConverter
]

{ #category : 'instance creation' }
HyperJump class >> withParsecs: aParsecsList converter: aConverter [

	| asDistances |
	aParsecsList isEmpty ifTrue: [
		Error signal: 'HyperJump must have at least one parsec value.' ].
	asDistances := aParsecsList collect: [ :each |
		               Distance parsecs: each ].
	^ self withDistances: asDistances converter: aConverter
]

{ #category : 'applying' }
HyperJump >> applyOn: aGame for: aSpaceship [

	| aDistance tiles |
	aDistance := distances at: currentIndex.
	currentIndex := currentIndex \\ distances size + 1.
	tiles := converter tilesForParsecs: aDistance inParsecs.
	aGame moveSpaceship: aSpaceship by: tiles
]

{ #category : 'initialization' }
HyperJump >> initializeWithDistances: aDistanceList converter: aConverter [

	distances := aDistanceList asSortedCollection: [ :a :b |
		             a inParsecs > b inParsecs ].
	currentIndex := 1.
	converter := aConverter
]
