Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#instVars : [
		'cardTypes'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardDealer class >> filterPlayers: players withAffected: affectedPlayer withPolarization: reversedPolarization [ 
reversedPolarization ifTrue:[
	^(players clone) remove: affectedPlayer.
	].
	^OrderedCollection with: affectedPlayer.
]

{ #category : #application }
CardDealer >> applyEffect: affectedPlayer [
(CardDealer filterPlayers: players withAffected: affectedPlayer withPolarization: reversed ) do: [:aPlayer | aPlayer addCards: (Deck getRandomCards: 1)].
]
