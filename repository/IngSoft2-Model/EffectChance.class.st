Class {
	#name : 'EffectChance',
	#superclass : 'Object',
	#instVars : [
		'percent',
		'effectBlock'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
EffectChance class >> percent: aPercent effectBlock: aBlock [

	aPercent < 0 ifTrue: [
		Error signal: 'A probability cannot be negative.' ].
	aBlock ifNil: [ Error signal: 'A probability must have a block.' ].
	^ self new initializeWithPercent: aPercent effectBlock: aBlock
]

{ #category : 'building' }
EffectChance >> buildEffect [

	^ effectBlock value
]

{ #category : 'initialization' }
EffectChance >> initializeWithPercent: aPercent effectBlock: aBlock [

	percent := aPercent.
	effectBlock := aBlock
]

{ #category : 'accessing' }
EffectChance >> percent [

	^ percent
]
