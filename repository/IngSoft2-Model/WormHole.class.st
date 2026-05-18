Class {
	#name : 'WormHole',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
WormHole >> applyOn: aGame [

	aGame moveSpaceship: aGame currentPlayer by: -4
]
