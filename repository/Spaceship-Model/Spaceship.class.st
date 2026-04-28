Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'Spaceship-Model',
	#package : 'Spaceship-Model'
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
