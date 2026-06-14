Class {
	#name : 'RandomNumberSource',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'generating' }
RandomNumberSource >> nextInt: aMaximum [

	"Returns a uniformly distributed integer between 1 and aMaximum inclusive."

	^ (1 to: aMaximum) atRandom
]
