Class {
	#name : 'TargetedPermanentCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect modifier' }
TargetedPermanentCard >> modifierFor: aSpaceship [

	aSpaceship = target ifFalse: [ ^ 0 ].
	^ self rollModifier
]

{ #category : 'playing' }
TargetedPermanentCard >> playOn: aGame by: aSpaceship target: aTargetSpaceship [

	target := aTargetSpaceship.
	aGame activatePermanent: self
]

{ #category : 'effect modifier' }
TargetedPermanentCard >> rollModifier [

	self subclassResponsibility
]

{ #category : 'accessing' }
TargetedPermanentCard >> target [

	^ target
]
