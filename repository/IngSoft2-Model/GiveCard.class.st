Class {
	#name : 'GiveCard',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
GiveCard >> applyOn: aGame for: aSpaceship [

	aGame giveCardTo: aSpaceship
]
