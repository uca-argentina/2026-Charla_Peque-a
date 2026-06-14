Class {
	#name : 'Redo',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Redo >> isRecordableAsLastPlayed [

	^ false
]

{ #category : 'playing' }
Redo >> playOn: aGame by: aSpaceship target: aTarget [

	"Redo takes the same nature and effect as the last card that was
	 actually played in the game, choosing its own target. The game
	 stores the last *resolved* card (never a Redo), so if the previous
	 card was itself a Redo, the card it resolved to is used."

	aGame redoLastCardBy: aSpaceship target: aTarget
]
