Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#instVars : [
		'cardTypes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #application }
CardDealer >> applyEffect: affectedPlayer [
	| somePlayers |
	reversed
		ifTrue: [
			somePlayers := players.
			somePlayers remove: affectedPlayer ]
		ifFalse: [ somePlayers := OrderedCollection with: affectedPlayer].
	somePlayers do: [:aPlayer | aPlayer addCards: (Deck getRandomCards: 1)].
]
