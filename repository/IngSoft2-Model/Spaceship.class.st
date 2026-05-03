Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'id'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Spaceship class >> withId: anID [ 
	^(self new) initializeWithId: anID.
]

{ #category : 'accessing' }
Spaceship >> id [
^id.
]

{ #category : 'initialization' }
Spaceship >> initialize [ 


]

{ #category : 'initialization' }
Spaceship >> initializeWithId: anId [ 
	id:=anId.
	position:=0
]

{ #category : 'as yet unclassified' }
Spaceship >> matchId: anId [
	^(anId = id)
]

{ #category : 'as yet unclassified' }
Spaceship >> moves: anAmount [
	position :=position+anAmount .
]

{ #category : 'accessing' }
Spaceship >> position [ 

^position.
]
