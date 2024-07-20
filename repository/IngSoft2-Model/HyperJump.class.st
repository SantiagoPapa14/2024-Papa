Class {
	#name : #HyperJump,
	#superclass : #Effect,
	#instVars : [
		'distanceList'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
HyperJump class >> filterPlayers: players withAffected: affectedPlayer withPolarization: reversedPolarization [ 
reversedPolarization ifTrue:[
	^players select: [ :player | (player ~= affectedPlayer)].
	].
	^OrderedCollection with: affectedPlayer.
]

{ #category : #'as yet unclassified' }
HyperJump class >> withUnits: aUnitList withBoard: aBoard [
	^((self new) initializeDistances: aUnitList initializeBoard: aBoard) initializePolarity.
]

{ #category : #application }
HyperJump >> applyEffect: affectedPlayer [
(HyperJump filterPlayers: players withAffected: affectedPlayer withPolarization: reversed ) do: [ :aPlayer |
		board move: affectedPlayer distance: self cycleDistance ]
]

{ #category : #utility }
HyperJump >> cycleDistance [
	| temp |
	temp := distanceList at: distanceList size.
	distanceList removeLast.
	distanceList addFirst: temp.
	^ temp
]

{ #category : #utility }
HyperJump >> initializeDistances: aUnitList initializeBoard: aBoard [
	distanceList := OrderedCollection new.
	aUnitList do: [ :someUnit | distanceList add: (someUnit parseToSquares: (aBoard boardSize) parsecAmount: (aBoard getParsecs) )].
	distanceList sort.
]
