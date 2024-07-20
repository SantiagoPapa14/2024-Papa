Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBomb class >> filterPlayers: players withAffected: affectedPlayer withPolarization: reversedPolarization [ 
reversedPolarization ifTrue:[
	^OrderedCollection new.
	].
	^players.
]

{ #category : #application }
AtomicBomb >> applyEffect: affectedPlayer [
	(AtomicBomb filterPlayers: players withAffected: affectedPlayer withPolarization: reversed ) do: [ :aPlayer |
		aPlayer ship getGravity > 0 ifFalse: [ board resetToStart: aPlayer ] ]
]
