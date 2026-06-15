Class {
	#name : 'EffectDistribution',
	#superclass : 'Object',
	#instVars : [
		'chances',
		'randomSource'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
EffectDistribution class >> new [

	^ self withRandomSource: RandomNumberSource new
]

{ #category : 'standard distribution' }
EffectDistribution class >> standardWithConverter: aConverter moonWalkRange: mwRange hyperJumpParsecs: aHyperJumpCollection source: aSource [

	| distribution moonWalkMin moonWalkMax |
	moonWalkMin := mwRange first.
	moonWalkMax := mwRange last.
	distribution := self withRandomSource: aSource.
	distribution
		probability: 30 of: [ NoEffect new ];
		probability: 20 of: [ WormHole new ];
		probability: 20 of: [ SpeedUp new ];
		probability: 10 of: [
				MoonWalk withTilesBack:
						moonWalkMin + (aSource nextInt: moonWalkMax - moonWalkMin + 1)
						- 1 ];
		probability: 8
		of: [
			HyperJump withParsecs: aHyperJumpCollection converter: aConverter ];
		probability: 2 of: [ AtomicBomb new ];
		probability: 10 of: [ GiveCard new ].
	^ distribution
]

{ #category : 'instance creation' }
EffectDistribution class >> withRandomSource: aRandomSource [

	^ self basicNew initializeWithRandomSource: aRandomSource
]

{ #category : 'building' }
EffectDistribution >> buildEffect [

	^ self effectForRoll: (randomSource nextInt: 100)
]

{ #category : 'building' }
EffectDistribution >> effectForRoll: aRoll [

	| cumulative |
	self validate.
	cumulative := 0.
	chances do: [ :each |
			cumulative := cumulative + each percent.
			aRoll <= cumulative ifTrue: [ ^ each buildEffect ] ]
]

{ #category : 'initialization' }
EffectDistribution >> initializeWithRandomSource: aRandomSource [

	chances := OrderedCollection new.
	randomSource := aRandomSource
]

{ #category : 'configuring' }
EffectDistribution >> probability: aPercent of: aBlock [

	chances add: (EffectChance percent: aPercent effectBlock: aBlock).
	^ self
]

{ #category : 'accessing' }
EffectDistribution >> totalPercent [

	^ chances inject: 0 into: [ :sum :each | sum + each percent ]
]

{ #category : 'validating' }
EffectDistribution >> validate [

	chances isEmpty ifTrue: [
		Error signal:
			'An effect distribution must have at least one effect.' ].
	self totalPercent = 100 ifFalse: [
		Error signal: 'Effect probabilities must add up to one hundred.' ]
]
