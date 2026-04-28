Class {
	#name : 'Gameboard',
	#superclass : 'Object',
	#category : 'Gameboard-Model',
	#package : 'Gameboard-Model'
}

{ #category : 'testing' }
Gameboard >> hasNoSpaceships [
	^ true
]

{ #category : 'testing' }
Gameboard >> isValidPosition: anInteger [ 
	^ (anInteger > 0).
]
