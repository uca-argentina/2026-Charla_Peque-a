Class {
	#name : 'CardsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'helpers' }
CardsTest >> deckOf: aCardCollection [

	^ SequenceDeck withCards: aCardCollection
]

{ #category : 'helpers' }
CardsTest >> gameWith: aBoard players: aShipCollection laps: n dice: aResult deck: aDeck [

	| aDiceCup |
	aDiceCup := DiceCup withDice:
		            { (LoadedDice withForcedResult: aResult) }.
	^ Game
		  playedBy: aShipCollection
		  reachingLaps: n
		  withBoard: aBoard
		  andDiceCup: aDiceCup
		  withDeck: aDeck
]

{ #category : 'helpers' }
CardsTest >> noEffectBoard: n [

	^ Board withTiles:
		  ((1 to: n) collect: [ :i | Tile with: NoEffect new ])
]

{ #category : 'tests - initial deal' }
CardsTest >> test001EachShipStartsWithTwoCards [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Speed new }).
	self assert: (aGame handOf: firstShip) size equals: 2.
	self assert: (aGame handOf: secondShip) size equals: 2
]

{ #category : 'tests - Overload' }
CardsTest >> test002WhenOverloadIsActiveOnAShipThenItsRollIsReducedByTwo [

	| firstShip aGame overload |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Overload new }).
	overload := (aGame handOf: firstShip) first.
	aGame play: overload by: firstShip target: firstShip.
	aGame playNextTurn.
	
	self assert: (aGame positionOf: firstShip) equals: 5
]

{ #category : 'tests - Overload' }
CardsTest >> test003WhenOverloadTargetsAShipThenOnlyThatShipIsAffected [

	| firstShip secondShip aGame overload |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Overload new }).
	overload := (aGame handOf: firstShip) first.
	aGame play: overload by: firstShip target: secondShip.
	aGame playNextTurn.
	
	self assert: (aGame positionOf: firstShip) equals: 7
]

{ #category : 'tests - Speed' }
CardsTest >> test004WhenSpeedIsActiveOnAShipThenItsRollIsIncreasedByOne [

	| firstShip aGame speed |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Speed new }).
	speed := (aGame handOf: firstShip) first.
	aGame play: speed by: firstShip target: firstShip.
	aGame playNextTurn.
	
	self assert: (aGame positionOf: firstShip) equals: 8
]

{ #category : 'tests - Acceleration' }
CardsTest >> test005WhenAccelerationIsActiveThenEveryShipRollIsIncreasedByOne [

	| firstShip secondShip aGame acceleration |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 5
		         deck: (self deckOf: { Acceleration new }).
	acceleration := (aGame handOf: firstShip) first.
	aGame play: acceleration by: firstShip target: nil.
	aGame playNextTurn. 
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 7.
	self assert: (aGame positionOf: secondShip) equals: 7
]

{ #category : 'tests - permanent rules' }
CardsTest >> test006APermanentCardCannotBePlayedOutsideTheOwnerTurn [

	| firstShip secondShip aGame overload |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Overload new }).
	overload := (aGame handOf: secondShip) first.
	
	self
		should: [ aGame play: overload by: secondShip target: firstShip ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A permanent card can only be played on the owner turn.' ]
]

{ #category : 'tests - permanent rules' }
CardsTest >> test007ACardCannotBePlayedIfItIsNotInTheShipHand [

	| firstShip aGame intruder |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Speed new }).
	intruder := Overload new.
	self
		should: [ aGame play: intruder by: firstShip target: firstShip ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'A ship can only play a card from its own hand.' ]
]

{ #category : 'tests - permanent rules' }
CardsTest >> test008WhenACardIsPlayedThenItLeavesTheShipHand [

	| firstShip aGame speed |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Speed new }).
	speed := (aGame handOf: firstShip) first.
	aGame play: speed by: firstShip target: firstShip.
	self assert: (aGame handOf: firstShip) size equals: 1
]

{ #category : 'tests - permanent rules' }
CardsTest >> test009ACardCannotBePlayedOnceTheGameHasFinished [

	| firstShip aGame speed |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 5)
		         players: { firstShip }
		         laps: 1
		         dice: 6
		         deck: (self deckOf: { Speed new }).
	speed := (aGame handOf: firstShip) first.
	aGame playNextTurn.
	self assert: aGame hasFinished.
	self
		should: [ aGame play: speed by: firstShip target: firstShip ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Cannot play a card once the game has finished.' ]
]

{ #category : 'tests - Cancellation' }
CardsTest >> test010WhenCancellationIsPlayedThenItRemovesAnActivePermanent [

	| firstShip aGame overload cancellation |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: {
					          Overload new.
					          Cancellation new }).
	overload := (aGame handOf: firstShip) first.
	cancellation := (aGame handOf: firstShip) second.
	aGame play: overload by: firstShip target: firstShip.
	aGame play: cancellation by: firstShip target: overload.
	aGame playNextTurn.
	
	self assert: (aGame positionOf: firstShip) equals: 7
]

{ #category : 'tests - Cancellation' }
CardsTest >> test011CancellationCannotBePlayedWithoutActivePermanents [

	| firstShip aGame cancellation |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Cancellation new }).
	cancellation := (aGame handOf: firstShip) first.
	self
		should: [
		aGame play: cancellation by: firstShip target: Overload new ]
		raise: Error
		withExceptionDo: [ :error |
				self
					assert: error messageText
					equals: 'Cannot cancel a card that is not active.' ]
]

{ #category : 'tests - Repeat' }
CardsTest >> test012RepeatDoesNothingWhenNoEffectHasHappened [

	| firstShip secondShip aGame repeat |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Repeat new }).
	repeat := (aGame handOf: firstShip) first.
	
	aGame play: repeat by: firstShip target: secondShip.
	self assert: (aGame positionOf: secondShip) equals: 1
]

{ #category : 'tests - Repeat' }
CardsTest >> test013RepeatIgnoresTilesWithNoEffect [

	| firstShip secondShip aGame repeat |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Repeat new }).
	repeat := (aGame handOf: firstShip) first.
	aGame playNextTurn.
	
	aGame play: repeat by: firstShip target: secondShip.
	self assert: (aGame positionOf: secondShip) equals: 1
]

{ #category : 'tests - Redo' }
CardsTest >> test014WhenRedoReplaysAPermanentThenItLeavesAnIndependentActivePermanent [

	| firstShip secondShip aGame overload redo |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: {
					          Overload new.
					          Redo new }).
	overload := (aGame handOf: firstShip) first.
	redo := (aGame handOf: firstShip) second.
	aGame play: overload by: firstShip target: firstShip.
	aGame play: redo by: firstShip target: secondShip.
	
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 5.
	self assert: (aGame positionOf: secondShip) equals: 5
]

{ #category : 'tests - Redo' }
CardsTest >> test015RedoDoesNothingWhenNoCardHasBeenPlayed [

	| firstShip aGame redo |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Redo new }).
	redo := (aGame handOf: firstShip) first.

	aGame play: redo by: firstShip target: firstShip.
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 7
]

{ #category : 'tests - Redo' }
CardsTest >> test016WhenRedoReplaysASpeedCardThenItChoosesItsOwnTarget [

	| firstShip secondShip aGame speed redo |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 5
		         deck: (self deckOf: {
					          Speed new.
					          Redo new }).
	speed := (aGame handOf: firstShip) first.
	redo := (aGame handOf: firstShip) second.
	aGame play: speed by: firstShip target: firstShip.
	aGame play: redo by: firstShip target: secondShip.
	aGame playNextTurn.
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 7.
	self assert: (aGame positionOf: secondShip) equals: 7
]

{ #category : 'tests - Redo' }
CardsTest >> test017WhenRedoFollowsARedoThenItUsesTheLastResolvedCardNotTheRedo [

	| aShip aGame hand speed firstRedo secondRedo |
	aShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (Board withTiles: {
					          (Tile with: NoEffect new).
					          (Tile with: GiveCard new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new) })
		         players: { aShip }
		         laps: 50
		         dice: 1
		         deck: (self deckOf: {
					          Speed new.
					          Redo new.
					          Redo new }).

	aGame playNextTurn.
	self assert: (aGame handOf: aShip) size equals: 3.

	hand := aGame handOf: aShip.
	speed := hand first.
	firstRedo := hand second.
	secondRedo := hand third.

	aGame play: speed by: aShip target: aShip.
	aGame play: firstRedo by: aShip target: aShip.
	aGame play: secondRedo by: aShip target: aShip.

	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 1.
	self assert: (aGame lapOf: aShip) equals: 2
]

{ #category : 'tests - GiveCard tile' }
CardsTest >> test018WhenAShipLandsOnAGiveCardTileThenItReceivesACard [

	| firstShip aGame |
	firstShip := 'Spaceship 1'.

	aGame := self
		         gameWith: (Board withTiles: {
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: GiveCard new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new) })
		         players: { firstShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Speed new }).

	aGame playNextTurn.
	self assert: (aGame handOf: firstShip) size equals: 3
]

{ #category : 'tests - effective roll edge cases' }
CardsTest >> test019WhenOverloadMakesTheEffectiveRollNegativeTheShipRetreatsToTheStart [

	| ship aGame overload |
	ship := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { ship }
		         laps: 5
		         dice: 1
		         deck: (self deckOf: { Overload new }).
	overload := (aGame handOf: ship) first.
	aGame play: overload by: ship target: ship.
	aGame playNextTurn.
	self assert: (aGame positionOf: ship) equals: 1.
	self assert: (aGame lapOf: ship) equals: 1
]

{ #category : 'tests - effective roll edge cases' }
CardsTest >> test020AccelerationAndOverloadOnTheSameShipCombineOnTheTotalRoll [

	| ship aGame acceleration overload |
	ship := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { ship }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: {
					          Acceleration new.
					          Overload new }).
	acceleration := (aGame handOf: ship) first.
	overload := (aGame handOf: ship) second.
	aGame play: acceleration by: ship target: ship.
	aGame play: overload by: ship target: ship.
	aGame playNextTurn.
	self assert: (aGame positionOf: ship) equals: 6
]

{ #category : 'tests - effective roll edge cases' }
CardsTest >> test021WhenOverloadMakesTheEffectiveRollZeroTheShipStaysInPlace [

	| ship aGame overload |
	ship := 'Spaceship 1'.

	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { ship }
		         laps: 5
		         dice: 2
		         deck: (self deckOf: { Overload new }).
	overload := (aGame handOf: ship) first.
	aGame play: overload by: ship target: ship.
	aGame playNextTurn.
	self assert: (aGame positionOf: ship) equals: 1.
	self assert: (aGame lapOf: ship) equals: 1
]

{ #category : 'tests - Cancellation' }
CardsTest >> test022CancellationRemovesTheChosenPermanentAmongSeveralActive [

	| ship otherShip aGame overload speed cancellation |
	ship := 'Spaceship 1'.
	otherShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { ship. otherShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Overload new. Speed new. Cancellation new }).
	overload := (aGame handOf: ship) first.
	speed := (aGame handOf: ship) second.
	cancellation := (aGame handOf: otherShip) first.
	aGame play: overload by: ship target: ship.
	aGame play: speed by: ship target: ship.
	aGame play: cancellation by: otherShip target: overload.
	aGame playNextTurn.
	self assert: (aGame positionOf: ship) equals: 8
]

{ #category : 'tests - card and effect interaction' }
CardsTest >> test023WhenRepeatReappliesAMovingEffectThenItDoesNotChainIntoAnotherEffect [

	| firstShip secondShip aGame repeat |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (Board withTiles: {
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: SpeedUp new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new).
					          (Tile with: WormHole new).
					          (Tile with: NoEffect new).
					          (Tile with: NoEffect new) })
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Repeat new }).
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 8.
	repeat := (aGame handOf: secondShip) first.
	aGame play: repeat by: secondShip target: secondShip.
	self assert: (aGame positionOf: secondShip) equals: 5
]

{ #category : 'tests - Redo and Cancellation' }
CardsTest >> test024WhenRedoFollowsACancellationThenItCancelsTheChosenPermanent [

	| firstShip secondShip aGame overloadA overloadB cancellation redo |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: {
				         firstShip.
				         secondShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: {
					          Overload new.
					          Overload new.
					          Cancellation new.
					          Redo new }).
	overloadA := (aGame handOf: firstShip) first.
	overloadB := (aGame handOf: firstShip) second.
	cancellation := (aGame handOf: secondShip) first.
	redo := (aGame handOf: secondShip) second.
	aGame play: overloadA by: firstShip target: firstShip.
	aGame play: overloadB by: firstShip target: firstShip.
	aGame play: cancellation by: secondShip target: overloadA.
	aGame play: redo by: secondShip target: overloadB.
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 7
]

{ #category : 'tests - permanent combinations' }
CardsTest >> test025WhenOverloadAndSpeedActOnTheSameShipThenModifiersAddUp [

	| ship aGame overload speed |
	ship := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { ship }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: {
					          Overload new.
					          Speed new }).
	overload := (aGame handOf: ship) first.
	speed := (aGame handOf: ship) second.
	aGame play: overload by: ship target: ship.
	aGame play: speed by: ship target: ship.
	aGame playNextTurn.
	self assert: (aGame positionOf: ship) equals: 6
]
