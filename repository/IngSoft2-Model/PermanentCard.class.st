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

	aGame activatePermanent: self
]
