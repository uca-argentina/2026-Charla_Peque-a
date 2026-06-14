Class {
	#name : 'WormHole',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
WormHole >> applyOn: aGame for: aSpaceship [

	aGame moveSpaceship: aSpaceship by: -4
]
