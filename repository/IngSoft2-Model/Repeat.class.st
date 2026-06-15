Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
Repeat >> playOn: aGame by: aSpaceship target: aTargetSpaceship [

	aGame repeatLastBoardEffectOn: aTargetSpaceship
]
