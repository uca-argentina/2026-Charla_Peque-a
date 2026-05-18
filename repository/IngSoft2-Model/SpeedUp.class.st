Class {
	#name : 'SpeedUp',
	#superclass : 'Tile',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
SpeedUp >> applyOn: aGame [ 

	aGame moveSpaceship: aGame currentPlayer by: 4.
]
