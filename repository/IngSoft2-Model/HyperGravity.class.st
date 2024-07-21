Class {
	#name : #HyperGravity,
	#superclass : #Effect,
	#instVars : [
		'necessaryRolledResult'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperGravity class >> filterPlayers: players withAffected: affectedPlayer withPolarization: reversedPolarization [ 
reversedPolarization ifTrue:[
	^players select: [ :player | (player ~= affectedPlayer)].
	].
	^OrderedCollection with: affectedPlayer.
]

{ #category : #'as yet unclassified' }
HyperGravity class >> withNecessaryRolledResult: someResult [
	^((self new) initializeNecesaryRolledResult: someResult) initializePolarity.
]

{ #category : #application }
HyperGravity >> applyEffect: affectedPlayer [
	(HyperGravity
		 filterPlayers: players
		 withAffected: affectedPlayer
		 withPolarization: reversed) do:  [:aPlayer |
	 aPlayer ship setGravity: necessaryRolledResult].
]

{ #category : #initialization }
HyperGravity >> initializeNecesaryRolledResult: aResult [
necessaryRolledResult := aResult.
]
