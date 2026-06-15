Class {
	#name : 'AtomicBomb',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
AtomicBomb >> applyOn: aGame for: aSpaceship [

	aGame sendAllSpaceshipsToFirstTile
]
