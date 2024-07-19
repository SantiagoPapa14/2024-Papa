Class {
	#name : #WormEffect,
	#superclass : #Effect,
	#instVars : [
		'linkPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormEffect class >> withLink: linkPos [
	^((self new) initializeLink: linkPos) initializePolarity.
]

{ #category : #application }
WormEffect >> applyEffect: affectedPlayer [

	| somePlayers |
	reversed
		ifTrue: [
			somePlayers := players.
			somePlayers remove: affectedPlayer ]
		ifFalse: [ somePlayers := OrderedCollection with: affectedPlayer ].
	somePlayers do: [ :aPlayer |
		board takeOut: aPlayer.
		board place: aPlayer at: linkPosition ]
]

{ #category : #initialization }
WormEffect >> initializeLink: linkPos [
	linkPosition := linkPos.
]
