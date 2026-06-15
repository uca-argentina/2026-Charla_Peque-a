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

	^ true
]
