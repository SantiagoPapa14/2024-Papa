Class {
	#name : #BlackHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
BlackHole >> applyEffect: affectedPlayer [

	| somePlayers |
	reversed
		ifTrue: [
			somePlayers := players.
			somePlayers remove: affectedPlayer ]
		ifFalse: [ somePlayers := OrderedCollection with: affectedPlayer ].

	somePlayers do: [ :aPlayer | board move: affectedPlayer distance: -4 ]
]
