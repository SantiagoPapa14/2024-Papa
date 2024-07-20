Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'myDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalk class >> filterPlayers: players withAffected: affectedPlayer withPolarization: reversedPolarization [ 
reversedPolarization ifTrue:[
	^OrderedCollection with: affectedPlayer.
	].
	^(players clone) remove: affectedPlayer.
]

{ #category : #'as yet unclassified' }
MoonWalk class >> withDistance: aDistance [
 ^((self new) initializeDistance: aDistance) initializePolarity.
]

{ #category : #application }
MoonWalk >> applyEffect: affectedPlayer [
(MoonWalk filterPlayers: players withAffected: affectedPlayer withPolarization: reversed ) do:  [:aPlayer | aPlayer ship getGravity > 0 ifFalse: [
				board move: aPlayer distance: myDistance * -1 ]].
]

{ #category : #initialization }
MoonWalk >> initializeDistance: aDistance [
 myDistance := aDistance.
]
