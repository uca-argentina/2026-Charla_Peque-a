Class {
	#name : 'Acceleration',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect modifier' }
Acceleration >> modifierFor: aSpaceship [

	"Acceleration affects every ship's total roll."

	^ 1
]
