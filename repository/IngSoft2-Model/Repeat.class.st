Class {
	#name : 'Repeat',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
Repeat >> playOn: aGame by: aSpaceship target: aTargetSpaceship [

	"Re-applies the last board effect that took place in the game,
	 onto the chosen target ship. If no effect has happened (nobody
	 rolled, or the last tile had no effect) it does nothing."

	aGame repeatLastBoardEffectOn: aTargetSpaceship
]
