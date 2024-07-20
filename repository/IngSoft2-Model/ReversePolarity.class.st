Class {
	#name : #ReversePolarity,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ReversePolarity >> applyCardEffect: cardUser [
	target getEffect reverseEffectPolarity.
]
