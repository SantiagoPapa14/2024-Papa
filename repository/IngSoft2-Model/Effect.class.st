Class {
	#name : #Effect,
	#superclass : #Object,
	#instVars : [
		'players',
		'board',
		'reversed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Effect class >> createEffect [
	^(self new) initializePolarity.
]

{ #category : #'as yet unclassified' }
Effect class >> filterPlayers: players withAffected: affectedPlayer withPolarization: reversedPolarization [ 
self subclassResponsibility.
]

{ #category : #application }
Effect >> applyEffect: affectedPlayer [

	self subclassResponsibility
]

{ #category : #application }
Effect >> initializePlayers: somePlayers initializeBoard: aBoard [
players := somePlayers.
board := aBoard.
]

{ #category : #application }
Effect >> initializePolarity [
	reversed := false.
]

{ #category : #application }
Effect >> reverseEffectPolarity [
	reversed
		ifTrue: [ reversed := false ]
		ifFalse: [ reversed := true ]
]
