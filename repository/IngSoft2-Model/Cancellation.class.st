Class {
	#name : 'Cancellation',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
Cancellation >> playOn: aGame by: aSpaceship target: aPermanentCard [

	aGame cancelPermanent: aPermanentCard
]
