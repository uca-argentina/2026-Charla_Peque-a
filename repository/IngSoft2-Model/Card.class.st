Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Card >> isPermanent [

	self subclassResponsibility
]

{ #category : 'testing' }
Card >> isPlayableOutsideTurn [

	^ self isPermanent not
]

{ #category : 'testing' }
Card >> isRecordableAsLastPlayed [

	^ true
]

{ #category : 'effect modifier' }
Card >> modifierFor: aSpaceship [

	^ 0
]

{ #category : 'playing' }
Card >> playOn: aGame by: aSpaceship target: aTargetSpaceship [

	self subclassResponsibility
]
