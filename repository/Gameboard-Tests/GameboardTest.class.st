Class {
	#name : 'GameboardTest',
	#superclass : 'TestCase',
	#category : 'Gameboard-Tests',
	#package : 'Gameboard-Tests'
}

{ #category : 'tests' }
GameboardTest >> test001WhenGameboardAskIfPositionZeroIsValidThenIsFalse [
	| board |
   board := Gameboard new.
   self deny: (board isValidPosition: 0).


]

{ #category : 'tests' }
GameboardTest >> test002WhenGameboardAskForRealPositionIsValidThenIsTrue [
	| board |
	board := Gameboard new.
	self assert: (board isValidPosition: 3).

]
