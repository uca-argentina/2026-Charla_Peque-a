Class {
	#name : 'Effect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
Effect >> applyOn: aGame for: aSpaceship [

	self subclassResponsibility
]

{ #category : 'testing' }
Effect >> isRepeatable [

	"Whether a Repeat card can replay this effect. Most effects can; NoEffect cannot."

	^ true
]
