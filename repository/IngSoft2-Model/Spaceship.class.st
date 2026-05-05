Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Spaceship >> hasReached: aPosition [ 
	^ position >= aPosition 
]

{ #category : 'initialization' }
Spaceship >> initialize [ 
position:=0.
]

{ #category : 'as yet unclassified' }
Spaceship >> moves: anAmount [
	position :=position+anAmount .
]

{ #category : 'accessing' }
Spaceship >> position [ 

^position.
]
