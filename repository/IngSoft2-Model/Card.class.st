Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'targetPlayer',
		'target',
		'lastEffect',
		'lastCard',
		'board'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card class >> canBeUsedAnytime [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
Card class >> withTargetPlayer: aTargetPlayer withTargetCard: aTargetCard withLastEffect: lastEffect withLastCard: lastCard withBoard: aBoard [
	^(self new) initializeTargetPlayer: aTargetPlayer initializeTarget: aTargetCard initializeLastEffect: lastEffect initializeLastCard: lastCard initializeBoard: aBoard.
]

{ #category : #initialization }
Card >> applyCardEffect [
	self subclassResponsibility.
]

{ #category : #initialization }
Card >> initializeTargetPlayer: aTargetPlayer initializeTarget: aTarget initializeLastEffect: anEffect initializeLastCard: aLastCard initializeBoard: aBoard [
	targetPlayer := aTargetPlayer.
	target := aTarget.
	lastEffect := anEffect.
	lastCard := aLastCard.
	board := aBoard.
	
]
