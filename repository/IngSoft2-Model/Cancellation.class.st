Class {
	#name : #Cancellation,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Cancellation >> applyCardEffect: cardUser [

	targetPlayer isNotNil
		ifTrue: [ targetPlayer deactivateCard: target ]
		ifFalse: [ target getEffect initializePolarity ]
]
