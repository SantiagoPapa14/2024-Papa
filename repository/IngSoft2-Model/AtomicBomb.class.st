Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #application }
AtomicBomb >> applyEffect: affectedPlayer [
	reversed ifFalse: [
		Transcript show: reversed.
		players do: [ :aPlayer |
			aPlayer ship getGravity > 0 ifFalse: [ board resetToStart: aPlayer ] ] ]
]
