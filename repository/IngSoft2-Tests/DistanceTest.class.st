Class {
	#name : 'DistanceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests - parsecs' }
DistanceTest >> test001ADistanceInParsecsReportsItsParsecs [

	self assert: (Distance parsecs: 10) inParsecs equals: 10
]

{ #category : 'tests - parsecs' }
DistanceTest >> test002ADistanceInParsecsConvertsToLightYears [

	self assert: (Distance parsecs: 10) inLightYears equals: 30
]

{ #category : 'tests - light years' }
DistanceTest >> test003ADistanceInLightYearsConvertsToParsecs [

	self assert: (Distance lightYears: 60) inParsecs equals: 20
]

{ #category : 'tests - light years' }
DistanceTest >> test004ADistanceInLightYearsReportsItsLightYears [

	self assert: (Distance lightYears: 60) inLightYears equals: 60
]

{ #category : 'tests - light years' }
DistanceTest >> test005OneParsecEqualsThreeLightYears [

	self assert: (Distance parsecs: 1) inLightYears equals: 3.
	self assert: (Distance lightYears: 3) inParsecs equals: 1
]

{ #category : 'tests - light years' }
DistanceTest >> test006LightYearsNotDivisibleByThreeKeepAFractionalParsecValue [

	self assert: (Distance lightYears: 10) inParsecs equals: 10 / 3.
	self assert: (Distance lightYears: 10) inLightYears equals: 10
]

{ #category : 'tests - equality' }
DistanceTest >> test007TwoDistancesWithTheSameParsecsAreEqual [

	self assert: (Distance parsecs: 5) equals: (Distance parsecs: 5)
]

{ #category : 'tests - equality' }
DistanceTest >> test008TwoDistancesWithDifferentParsecsAreNotEqual [

	self deny: (Distance parsecs: 5) equals: (Distance parsecs: 6)
]

{ #category : 'tests - equality' }
DistanceTest >> test009ADistanceInParsecsEqualsTheSameDistanceInLightYears [

	self assert: (Distance parsecs: 5) equals: (Distance lightYears: 15)
]

{ #category : 'tests - equality' }
DistanceTest >> test010ADistanceIsNotEqualToANonDistanceObject [

	self deny: (Distance parsecs: 5) equals: 5.
	self deny: (Distance parsecs: 5) equals: 'five parsecs'
]

{ #category : 'tests - equality' }
DistanceTest >> test011EqualDistancesShareTheSameHash [

	self
		assert: (Distance parsecs: 7) hash
		equals: (Distance parsecs: 7) hash
]

{ #category : 'tests - validation' }
DistanceTest >> test012ADistanceInParsecsCannotBeNegative [

	self
		should: [ Distance parsecs: -1 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A distance cannot be negative.' ]
]

{ #category : 'tests - validation' }
DistanceTest >> test013ADistanceInLightYearsCannotBeNegative [

	self
		should: [ Distance lightYears: -1 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A distance cannot be negative.' ]
]

{ #category : 'tests - validation' }
DistanceTest >> test014ADistanceOfZeroIsValid [

	self assert: (Distance parsecs: 0) inParsecs equals: 0.
	self assert: (Distance lightYears: 0) inLightYears equals: 0
]
