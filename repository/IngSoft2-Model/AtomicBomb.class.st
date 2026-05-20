Class {
	#name : 'AtomicBomb',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
AtomicBomb >> applyOn: aGame [ 

	aGame sendAllSpaceshipsToFirstTile
]
