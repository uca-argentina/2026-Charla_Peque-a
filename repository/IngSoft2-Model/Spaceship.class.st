Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Spaceship >> advance: anAmount [ 

    position := position + anAmount.

]

{ #category : 'initialization' }
Spaceship >> initialize [  
	super initialize.
	position :=0
]

{ #category : 'accessing' }
Spaceship >> position [ 

^position 
]
