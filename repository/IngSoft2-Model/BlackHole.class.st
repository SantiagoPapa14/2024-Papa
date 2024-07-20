Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
BlackHole class >> filterPlayers: players withAffected: affectedPlayer withPolarization: reversedPolarization [ 
reversedPolarization ifTrue:[
	^(players clone) remove: affectedPlayer.
	].
	^OrderedCollection with: affectedPlayer.
]

{ #category : #application }
BlackHole >> applyEffect: affectedPlayer [
(BlackHole filterPlayers: players withAffected: affectedPlayer withPolarization: reversed ) do: [ :aPlayer | board move: aPlayer distance: -4 ]
	

]
