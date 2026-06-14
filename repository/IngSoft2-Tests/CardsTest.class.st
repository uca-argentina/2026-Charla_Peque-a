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
	aDiceCup := DiceCup withDice: { (LoadedDice withForcedResult: aResult) }.
	^ Game
		  playedBy: aShipCollection
		  reachingLaps: n
		  withBoard: aBoard
		  andDiceCup: aDiceCup
		  withDeck: aDeck
]

{ #category : 'helpers' }
CardsTest >> noEffectBoard: n [

	^ Board withTiles: ((1 to: n) collect: [ :i | Tile with: NoEffect new ])
]

{ #category : 'tests - initial deal' }
CardsTest >> test001EachShipStartsWithTwoCards [

	| firstShip secondShip aGame |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip. secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Speed new }).
	self assert: (aGame handOf: firstShip) size equals: 2.
	self assert: (aGame handOf: secondShip) size equals: 2
]

{ #category : 'tests - Overload' }
CardsTest >> test002OverloadReducesTheTotalRollOfTheChosenShipByTwo [

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
	"Tira 6, overload -2 → mueve 4. De 1 queda en 5."
	self assert: (aGame positionOf: firstShip) equals: 5
]

{ #category : 'tests - Overload' }
CardsTest >> test003OverloadOnlyAffectsItsTargetShip [

	| firstShip secondShip aGame overload |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip. secondShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Overload new }).
	overload := (aGame handOf: firstShip) first.
	aGame play: overload by: firstShip target: secondShip.
	aGame playNextTurn.
	"firstShip no es target → mueve 6 normal. De 1 queda en 7."
	self assert: (aGame positionOf: firstShip) equals: 7
]

{ #category : 'tests - Speed' }
CardsTest >> test004SpeedIncreasesTheTotalRollOfTheChosenShipByOne [

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
	"Tira 6, speed +1 → mueve 7. De 1 queda en 8."
	self assert: (aGame positionOf: firstShip) equals: 8
]

{ #category : 'tests - Acceleration' }
CardsTest >> test005AccelerationIncreasesTheTotalRollOfEveryShip [

	| firstShip secondShip aGame acceleration |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip. secondShip }
		         laps: 5
		         dice: 5
		         deck: (self deckOf: { Acceleration new }).
	acceleration := (aGame handOf: firstShip) first.
	aGame play: acceleration by: firstShip target: nil.
	aGame playNextTurn. "firstShip: 5+1 → 6, de 1 a 7"
	aGame playNextTurn. "secondShip: 5+1 → 6, de 1 a 7"
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
		         players: { firstShip. secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Overload new }).
	overload := (aGame handOf: secondShip) first.
	"firstShip es el current; secondShip no puede jugar permanente."
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
CardsTest >> test008APlayedCardLeavesTheShipHand [

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
CardsTest >> test010CancellationRemovesAnActivePermanentCard [

	| firstShip aGame overload cancellation |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Overload new. Cancellation new }).
	overload := (aGame handOf: firstShip) first.
	cancellation := (aGame handOf: firstShip) second.
	aGame play: overload by: firstShip target: firstShip.
	aGame play: cancellation by: firstShip target: overload.
	aGame playNextTurn.
	"Overload cancelado → mueve 6 normal. De 1 queda en 7."
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
		should: [ aGame play: cancellation by: firstShip target: Overload new ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Cannot cancel a card that is not active.' ]
]

{ #category : 'tests - Repeat' }
CardsTest >> test012RepeatReappliesTheLastBoardEffectOnTheChosenShip [

	| firstShip secondShip aGame repeat |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	"SpeedUp en pos 4. firstShip cae ahí. Luego Repeat sobre secondShip."
	aGame := self
		         gameWith: (Board withTiles: {
				          (Tile with: NoEffect new). (Tile with: NoEffect new).
				          (Tile with: NoEffect new). (Tile with: SpeedUp new).
				          (Tile with: NoEffect new). (Tile with: NoEffect new).
				          (Tile with: NoEffect new). (Tile with: NoEffect new).
				          (Tile with: NoEffect new). (Tile with: NoEffect new) })
		         players: { firstShip. secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Repeat new }).
	repeat := (aGame handOf: firstShip) first.
	aGame playNextTurn.
	"firstShip: 1 → 4 (SpeedUp) → 8."
	self assert: (aGame positionOf: firstShip) equals: 8.
	aGame play: repeat by: firstShip target: secondShip.
	"Repeat SpeedUp sobre secondShip: de 1 → 5."
	self assert: (aGame positionOf: secondShip) equals: 5
]

{ #category : 'tests - Repeat' }
CardsTest >> test013RepeatDoesNothingWhenNoEffectHasHappened [

	| firstShip secondShip aGame repeat |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip. secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Repeat new }).
	repeat := (aGame handOf: firstShip) first.
	"Nadie tiró todavía → Repeat no hace nada."
	aGame play: repeat by: firstShip target: secondShip.
	self assert: (aGame positionOf: secondShip) equals: 1
]

{ #category : 'tests - Repeat' }
CardsTest >> test014RepeatIgnoresTilesWithNoEffect [

	| firstShip secondShip aGame repeat |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip. secondShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Repeat new }).
	repeat := (aGame handOf: firstShip) first.
	aGame playNextTurn.
	"firstShip cae en NoEffect → no se registra efecto repetible."
	aGame play: repeat by: firstShip target: secondShip.
	self assert: (aGame positionOf: secondShip) equals: 1
]

{ #category : 'tests - Redo' }
CardsTest >> test015RedoOfAPermanentLeavesAnIndependentActivePermanent [

	| firstShip secondShip aGame overload redo |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip. secondShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Overload new. Redo new }).
	overload := (aGame handOf: firstShip) first.
	redo := (aGame handOf: firstShip) second.
	aGame play: overload by: firstShip target: firstShip.
	aGame play: redo by: firstShip target: secondShip.
	"Redo de Overload sobre secondShip → otro Overload activo."
	aGame playNextTurn. "firstShip: 6-2 → 4, de 1 a 5"
	aGame playNextTurn. "secondShip: 6-2 → 4, de 1 a 5"
	self assert: (aGame positionOf: firstShip) equals: 5.
	self assert: (aGame positionOf: secondShip) equals: 5
]

{ #category : 'tests - Redo' }
CardsTest >> test016RedoDoesNothingWhenNoCardHasBeenPlayed [

	| firstShip aGame redo |
	firstShip := 'Spaceship 1'.
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip }
		         laps: 5
		         dice: 6
		         deck: (self deckOf: { Redo new }).
	redo := (aGame handOf: firstShip) first.
	"No se jugó ninguna carta antes → Redo no hace nada."
	aGame play: redo by: firstShip target: firstShip.
	aGame playNextTurn.
	self assert: (aGame positionOf: firstShip) equals: 7
]

{ #category : 'tests - Redo' }
CardsTest >> test017RedoReplaysTheLastResolvedSpeedCardChoosingItsOwnTarget [

	| firstShip secondShip aGame speed redo |
	firstShip := 'Spaceship 1'.
	secondShip := 'Spaceship 2'.
	"firstShip arranca con { Speed. Redo }. Juega Speed sobre sí misma y luego
	 Redo eligiendo a secondShip: el Redo replica el Speed sobre otra nave."
	aGame := self
		         gameWith: (self noEffectBoard: 20)
		         players: { firstShip. secondShip }
		         laps: 5
		         dice: 5
		         deck: (self deckOf: { Speed new. Redo new }).
	speed := (aGame handOf: firstShip) first.
	redo := (aGame handOf: firstShip) second.
	aGame play: speed by: firstShip target: firstShip.
	aGame play: redo by: firstShip target: secondShip.
	aGame playNextTurn. "firstShip: 5+1 → 7"
	aGame playNextTurn. "secondShip: 5+1 → 7"
	self assert: (aGame positionOf: firstShip) equals: 7.
	self assert: (aGame positionOf: secondShip) equals: 7
]

{ #category : 'tests - GiveCard tile' }
CardsTest >> test018LandingOnAGiveCardTileGivesACardToTheShip [

	| firstShip aGame |
	firstShip := 'Spaceship 1'.
	"GiveCard en pos 4. firstShip cae ahí y roba una carta."
	aGame := self
		         gameWith: (Board withTiles: {
				          (Tile with: NoEffect new). (Tile with: NoEffect new).
				          (Tile with: NoEffect new). (Tile with: GiveCard new).
				          (Tile with: NoEffect new). (Tile with: NoEffect new).
				          (Tile with: NoEffect new). (Tile with: NoEffect new).
				          (Tile with: NoEffect new). (Tile with: NoEffect new) })
		         players: { firstShip }
		         laps: 5
		         dice: 3
		         deck: (self deckOf: { Speed new }).
	"Arranca con 2 cartas; al caer en GiveCard suma una tercera."
	aGame playNextTurn.
	self assert: (aGame handOf: firstShip) size equals: 3
]

{ #category : 'tests - Redo' }
CardsTest >> test019RedoOfARedoUsesTheLastResolvedCardNotTheRedo [

	| aShip aGame speed firstRedo secondRedo |
	aShip := 'Spaceship 1'.
	"Mazo determinista: reparte Speed, luego Redo, luego Redo.
	 aShip arranca con { Speed. Redo } y, al caer en la tile 2 (GiveCard),
	 roba la tercera carta: otra Redo. Queda con Speed + Redo + Redo.

	 Jugadas (todas sobre aShip para medir el efecto acumulado):
	   1) Speed  → +1   (última resuelta = Speed)
	   2) Redo   → replica Speed, +1  (última resuelta sigue siendo Speed, no el Redo)
	   3) Redo   → si usa la última resuelta (Speed) suma otro +1.
	              Si erróneamente replicara el Redo, no sumaría nada.

	 Con tres Speed activos sobre aShip y un dado de 1, la tirada efectiva es 4,
	 de modo que en su siguiente turno avanza exactamente 4 casilleros."
	aGame := self
		         gameWith: (Board withTiles: {
				          (Tile with: NoEffect new). (Tile with: GiveCard new).
				          (Tile with: NoEffect new). (Tile with: NoEffect new).
				          (Tile with: NoEffect new) })
		         players: { aShip }
		         laps: 50
		         dice: 1
		         deck: (self deckOf: { Speed new. Redo new. Redo new }).

	"Turno inicial: 1 → tile 2 (GiveCard), roba la segunda Redo."
	aGame playNextTurn.
	self assert: (aGame handOf: aShip) size equals: 3.

	speed := (aGame handOf: aShip) detect: [ :c | c isKindOf: Speed ].
	aGame play: speed by: aShip target: aShip.

	firstRedo := (aGame handOf: aShip) detect: [ :c | c isKindOf: Redo ].
	aGame play: firstRedo by: aShip target: aShip.

	secondRedo := (aGame handOf: aShip) detect: [ :c | c isKindOf: Redo ].
	aGame play: secondRedo by: aShip target: aShip.

	"aShip está en tile 2. Siguiente turno: dado 1 + tres Speed = 4 → tile 6 → wrap a tile 1, lap 2."
	aGame playNextTurn.
	self assert: (aGame positionOf: aShip) equals: 1.
	self assert: (aGame lapOf: aShip) equals: 2
]
