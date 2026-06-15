Class {
	#name : 'RandomNumberSource',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'generating' }
RandomNumberSource >> nextInt: aMaximum [

	^ (1 to: aMaximum) atRandom
]
