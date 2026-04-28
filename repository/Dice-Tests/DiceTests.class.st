Class {
	#name : 'DiceTests',
	#superclass : 'TestCase',
	#category : 'Dice-Tests',
	#package : 'Dice-Tests'
}

{ #category : 'tests' }
DiceTests >> test001WhenTheDiceIsRolledANumberIsReturned [

|aDice |

aDice := Dice withFaces: 6.

self assert: (aDice roll isNumber)
]

{ #category : 'tests' }
DiceTests >> test002WhenTheDiceIsRolledAPositiveNumberIsReturned [

|aDice |

aDice := Dice withFaces: 6.

self assert: (aDice roll strictlyPositive)
]

{ #category : 'tests' }
DiceTests >> test003WhenADiceWith6FacesIsRolledThenTheResultIsBetweenOneAndSix [

|aDice |

aDice := Dice withFaces: 6.

self assert: (aDice roll between: 1 and: 6)
]

{ #category : 'tests' }
DiceTests >> test004WhenTheNumberOfFacesIsEqualToZeroThenTheDiceIsNotCreated [


self should:  [Dice withFaces: 0.] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'A Dice cannot have zero (0) number of faces.']
]

{ #category : 'tests' }
DiceTests >> test005WhenTheNumberOfFacesIsNegativeThenTheDiceIsNotCreated [


self should:  [Dice withFaces: -8.] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'A Dice cannot have a negative (<0) number of faces.']
]
