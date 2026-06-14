Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
PermanentCard >> isPermanent [

	^ true
]

{ #category : 'playing' }
PermanentCard >> playOn: aGame by: aSpaceship target: aTargetSpaceship [

	"A permanent card registers itself as active in the game.
	 Its effect on rolls is applied later through modifierFor:."

	aGame activatePermanent: self
]
