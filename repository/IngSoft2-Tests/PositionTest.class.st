Class {
	#name : 'PositionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PositionTest >> test001WhenInitializationParameterLapIsLessThanOneThenPositionCannotBeCreated [

	self
		should: [ Position at: 1 withLaps: -1 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Number of Laps cannot be less than one.' ]
]

{ #category : 'tests' }
PositionTest >> test002WhenInitializationParameterPositionIsLessThanOneThenObjectPositionCannotBeCreated [

	self
		should: [ Position at: -1 withLaps: 1 ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Starting position cannot be less than one.' ]
]
