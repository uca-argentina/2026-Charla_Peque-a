Class {
	#name : 'Gameboard',
	#superclass : 'Object',
	#instVars : [
		'size'
	],
	#category : 'Gameboard-Model',
	#package : 'Gameboard-Model'
}

{ #category : 'instance creation' }
Gameboard class >> withSize: anInteger [ 
	^ (self new) withSize: anInteger.
]

{ #category : 'testing' }
Gameboard >> hasNoSpaceships [
	^ true
]

{ #category : 'testing' }
Gameboard >> isValidPosition: anInteger [ 
	^ (anInteger > 0) and: (anInteger <= size).
]

{ #category : 'instance creation' }
Gameboard >> withSize: anInteger [
	(anInteger > 0) ifTrue: [ size := anInteger ] ifFalse: [ Error signal ].
]
