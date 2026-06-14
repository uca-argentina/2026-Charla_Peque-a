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

	"Instant cards can be played any time; permanent cards only on the owner's turn."

	^ self isPermanent not
]

{ #category : 'testing' }
Card >> isRecordableAsLastPlayed [

	"Whether this card should be remembered as the last resolved card,
	 so a future Redo can replay it. A Redo never records itself; it records
	 the card it resolved to."

	^ true
]

{ #category : 'effect modifier' }
Card >> modifierFor: aSpaceship [

	"How much this card adds to a ship's total roll while active.
	 Non-roll-modifying cards contribute zero."

	^ 0
]

{ #category : 'playing' }
Card >> playOn: aGame by: aSpaceship target: aTargetSpaceship [

	self subclassResponsibility
]
