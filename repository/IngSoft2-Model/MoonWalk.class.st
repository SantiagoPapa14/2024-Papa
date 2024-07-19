Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'myDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalk class >> withDistance: aDistance [
 ^((self new) initializeDistance: aDistance) initializePolarity.
]

{ #category : #application }
MoonWalk >> applyEffect: affectedPlayer [
	| somePlayers |
	reversed
		ifFalse: [
			somePlayers := players.
			somePlayers remove: affectedPlayer ]
		ifTrue: [ somePlayers := OrderedCollection with: affectedPlayer].
	somePlayers do: [:aPlayer | aPlayer ship getGravity > 0 ifFalse: [
				board move: aPlayer distance: myDistance * -1 ]].
]

{ #category : #initialization }
MoonWalk >> initializeDistance: aDistance [
 myDistance := aDistance.
]
