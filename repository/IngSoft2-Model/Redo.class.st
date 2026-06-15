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

	aGame redoLastCardBy: aSpaceship target: aTarget
]
