Class {
	#name : 'HyperJump',
	#superclass : 'Tile',
	#instVars : [
		'parsecsList',
		'currentIndex',
		'converter'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperJump class >> withParsecs: aParsecsList converter: aConverter [

	aParsecsList isEmpty ifTrue: [
		Error signal: 'HyperJump must have at least one parsec value.' ].
	aConverter ifNil: [ Error signal: 'HyperJump must have a converter.' ].
	^ self new initializeWithParsecs: aParsecsList converter: aConverter
]

{ #category : 'applying' }
HyperJump >> applyOn: aGame [

	| parsecs tiles |
	parsecs := parsecsList at: currentIndex.
	currentIndex := currentIndex \\ parsecsList size + 1.
	tiles := converter tilesForParsecs: parsecs.
	aGame moveSpaceship: aGame currentPlayer by: tiles
]

{ #category : 'initialization' }
HyperJump >> initializeWithParsecs: aParsecsList converter: aConverter [

	parsecsList := aParsecsList asSortedCollection: [ :a :b | a > b ].
	currentIndex := 1.
	converter := aConverter
]
