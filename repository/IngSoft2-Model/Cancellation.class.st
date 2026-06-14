Class {
	#name : 'Cancellation',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
Cancellation >> playOn: aGame by: aSpaceship target: aPermanentCard [

	"Removes a chosen permanent card that is currently active.
	 The target is the permanent card to cancel, not a spaceship."

	aGame cancelPermanent: aPermanentCard
]
