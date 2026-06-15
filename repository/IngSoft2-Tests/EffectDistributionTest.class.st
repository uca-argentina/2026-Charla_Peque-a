Class {
	#name : 'EffectDistributionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - configuration' }
EffectDistributionTest >> test001AnEmptyDistributionCannotBuildAnEffect [

	| distribution |
	distribution := EffectDistribution new.
	self
		should: [ distribution buildEffect ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'An effect distribution must have at least one effect.' ]
]

{ #category : 'tests - configuration' }
EffectDistributionTest >> test002ADistributionWhosePercentagesDoNotAddUpToOneHundredIsInvalid [

	| distribution |
	distribution := EffectDistribution new
		                probability: 50 of: [ NoEffect new ];
		                probability: 30 of: [ WormHole new ].
	self
		should: [ distribution buildEffect ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Effect probabilities must add up to one hundred.' ]
]

{ #category : 'tests - configuration' }
EffectDistributionTest >> test003ProbabilitiesAddingUpToOneHundredAreValid [

	| distribution |
	distribution := EffectDistribution new
		                probability: 70 of: [ NoEffect new ];
		                probability: 30 of: [ WormHole new ].
	self assert: distribution totalPercent equals: 100
]

{ #category : 'tests - deterministic by config' }
EffectDistributionTest >> test004ADistributionWithOneHundredPercentOfAnEffectAlwaysBuildsThatEffect [

	| distribution |
	distribution := EffectDistribution new
		                probability: 100
		                of: [ WormHole new ].
	self assert: distribution buildEffect class equals: WormHole.
	self assert: distribution buildEffect class equals: WormHole.
	self assert: distribution buildEffect class equals: WormHole
]

{ #category : 'tests - deterministic by config' }
EffectDistributionTest >> test005ADistributionAtOneHundredPercentNoEffectAlwaysBuildsNoEffect [

	| distribution |
	distribution := EffectDistribution new
		                probability: 100
		                of: [ NoEffect new ].
	self assert: distribution buildEffect class equals: NoEffect
]

{ #category : 'tests - deterministic by config' }
EffectDistributionTest >> test006EachBuildProducesAFreshEffectInstance [

	| distribution first second |
	distribution := EffectDistribution new
		                probability: 100
		                of: [ SpeedUp new ].
	first := distribution buildEffect.
	second := distribution buildEffect.
	self deny: first equals: second
]

{ #category : 'tests - blocks' }
EffectDistributionTest >> test007TheWinningBlockIsTheOneEvaluated [

	| distribution |
	distribution := EffectDistribution new
		                probability: 100
		                of: [ MoonWalk withTilesBack: 3 ].
	self assert: distribution buildEffect class equals: MoonWalk.
	self assert: distribution buildEffect tilesBack equals: 3
]

{ #category : 'tests - blocks' }
EffectDistributionTest >> test008ABlockClosingOverARandomSourceProducesAConfiguredEffect [

	| distribution source |
	source := SequencedRandomSource withValues: { 4 }.
	distribution := EffectDistribution new
		                probability: 100
		                of: [ MoonWalk withTilesBack: (source nextInt: 10) ].
	self assert: distribution buildEffect tilesBack equals: 4
]

{ #category : 'tests - blocks' }
EffectDistributionTest >> test009ABlockBuildingAHyperJumpProducesAHyperJump [

	| distribution converter |
	converter := ParsecConverter withTotalParsecs: 100 numberOfTiles: 10.
	distribution := EffectDistribution new
		                probability: 100
		                of: [
		                HyperJump
			                withParsecs: #( 100 200 )
			                converter: converter ].
	self assert: distribution buildEffect class equals: HyperJump
]

{ #category : 'tests - mixed distribution' }
EffectDistributionTest >> test010AMixedDistributionBuildsEachEffectAccordingToTheRoll [

	| distribution source |
	source := SequencedRandomSource withValues: { 1. 50. 51. 100 }.
	distribution := EffectDistribution withRandomSource: source.
	distribution
		probability: 50 of: [ NoEffect new ];
		probability: 50 of: [ WormHole new ].
	self assert: distribution buildEffect class equals: NoEffect.
	self assert: distribution buildEffect class equals: NoEffect.
	self assert: distribution buildEffect class equals: WormHole.
	self assert: distribution buildEffect class equals: WormHole
]

{ #category : 'tests - deterministic selection' }
EffectDistributionTest >> test011WhenARollFallsInARangeThenTheMatchingEffectIsBuilt [

	| distribution |
	distribution := EffectDistribution new
		                probability: 40 of: [ NoEffect new ];
		                probability: 60 of: [ WormHole new ].
	self assert: (distribution effectForRoll: 1) class equals: NoEffect.
	self assert: (distribution effectForRoll: 40) class equals: NoEffect.
	self assert: (distribution effectForRoll: 41) class equals: WormHole.
	self assert: (distribution effectForRoll: 100) class equals: WormHole
]

{ #category : 'tests - deterministic selection' }
EffectDistributionTest >> test012WhenThreeEffectsAreConfiguredThenEachRangeBuildsItsEffect [

	| distribution |
	distribution := EffectDistribution new
		                probability: 30 of: [ NoEffect new ];
		                probability: 20 of: [ SpeedUp new ];
		                probability: 50 of: [ WormHole new ].
	self assert: (distribution effectForRoll: 30) class equals: NoEffect.
	self assert: (distribution effectForRoll: 31) class equals: SpeedUp.
	self assert: (distribution effectForRoll: 50) class equals: SpeedUp.
	self assert: (distribution effectForRoll: 51) class equals: WormHole
]

{ #category : 'tests - deterministic selection' }
EffectDistributionTest >> test013WhenAChanceEvaluatesItsBlockThenItYieldsAFreshEffect [

	| chance first second |
	chance := EffectChance percent: 100 effectBlock: [ SpeedUp new ].
	self assert: chance percent equals: 100.
	first := chance buildEffect.
	second := chance buildEffect.
	self assert: first class equals: SpeedUp.
	self deny: first equals: second
]
