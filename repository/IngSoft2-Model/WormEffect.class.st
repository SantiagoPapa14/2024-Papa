Class {
	#name : #WormEffect,
	#superclass : #Effect,
	#instVars : [
		'linkPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormEffect class >> filterPlayers: players withAffected: affectedPlayer withPolarization: reversedPolarization [ 
reversedPolarization ifTrue:[
	^players select: [ :player | (player ~= affectedPlayer)].
	].
	^OrderedCollection with: affectedPlayer.
]

{ #category : #'as yet unclassified' }
WormEffect class >> withLink: linkPos [
	^((self new) initializeLink: linkPos) initializePolarity.
]

{ #category : #application }
WormEffect >> applyEffect: affectedPlayer [
(WormEffect filterPlayers: players withAffected: affectedPlayer withPolarization: reversed ) do: [ :aPlayer |
		board takeOut: aPlayer.
		board place: aPlayer at: linkPosition ]
]

{ #category : #initialization }
WormEffect >> initializeLink: linkPos [
	linkPosition := linkPos.
]
