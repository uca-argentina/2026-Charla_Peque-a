Class {
	#name : 'GameboardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameboardTest >> test001WhenGameboardAskIfPositionZeroIsValidThenIsFalse [
	| board |
   board := Gameboard withSize: 10.
   self deny: (board isValidPosition: 0).


]

{ #category : 'tests' }
GameboardTest >> test002WhenGameboardAskForRealPositionIsValidThenIsTrue [
	| board |
	board := Gameboard withSize: 10.
	self assert: (board isValidPosition: 3).

]

{ #category : 'tests' }
GameboardTest >> test003WhenGameboardAskForRealPositionAndIsOutOfRangeThenIsFalse [
	| board |
	board := Gameboard withSize: 50.
	self deny: (board isValidPosition: 80).

]

{ #category : 'tests' }
GameboardTest >> test004WhenGameboardStartsWithNegativeSizeThenIsNotValid [

	self should: [ Gameboard withSize: -2 ] raise: Error.

]
