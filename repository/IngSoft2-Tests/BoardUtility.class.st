Class {
	#name : #BoardUtility,
	#superclass : #Object,
	#instVars : [
		'squares',
		'parsecs'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
BoardUtility class >> findSquareWithEffect: anEffect onBoard: aBoard [
	1 to: aBoard boardSize do: [ :x | (((aBoard getSquares at: x) getEffect) class = anEffect) ifTrue:[ ^x] ].
	^-1.
]

{ #category : #'as yet unclassified' }
BoardUtility class >> findWormSquares: aBoard [

	| positions |
	positions := OrderedCollection new.
	1 to: (aBoard boardSize) do: [ :x | (((aBoard getSquares at: x) getEffect) class = WormEffect)ifTrue:[ positions add: x ] ].
	^positions.
]

{ #category : #'as yet unclassified' }
BoardUtility class >> initializeEffect: anEffect initializeAt: aSquare onBoard: aBoard [
	(aBoard getSquare: aSquare) initializeWithEffect: anEffect.
	
]

{ #category : #'as yet unclassified' }
BoardUtility class >> removeEffectsOnBoard: aBoard [
	aBoard getSquares do: [ :square | square initializeWithEffect: NullEffect new ]
]

{ #category : #'as yet unclassified' }
BoardUtility class >> showBoard: aBoard [
	| dockedHere |
	aBoard getSquares do: [ :square |
		square getDockedShips isEmpty
			ifTrue: [ Transcript show: '#' ]
			ifFalse: [
				square getDockedShips do: [ :thisShip |
					Transcript show: thisShip getName ].
				Transcript show: '.' ] ].
	Transcript
		show: ''.
]
