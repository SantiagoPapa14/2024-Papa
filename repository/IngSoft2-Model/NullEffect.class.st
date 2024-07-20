Class {
	#name : #NullEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
NullEffect class >> filterPlayers: players withAffected: affectedPlayer withPolarization: reversedPolarization [ 
^OrderedCollection with: affectedPlayer.
]

{ #category : #application }
NullEffect >> applyEffect: affectedPlayer [
	^ true
]
