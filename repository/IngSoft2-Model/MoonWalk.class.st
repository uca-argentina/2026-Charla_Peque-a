Class {
	#name : 'MoonWalk',
	#superclass : 'Tile',
	#instVars : [
		'tilesBack'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
MoonWalk class >> withTilesBack: aNumberOfTiles [

	aNumberOfTiles < 1 ifTrue: [
		Error signal: 'MoonWalk must move at least one tile back.' ].
	^ self new initializeWithTilesBack: aNumberOfTiles
]

{ #category : 'applying' }
MoonWalk >> applyOn: aGame [

	aGame moveAllSpaceshipsExceptCurrentBy: tilesBack negated
]

{ #category : 'initialization' }
MoonWalk >> initializeWithTilesBack: aNumberOfTiles [

	tilesBack := aNumberOfTiles
]
