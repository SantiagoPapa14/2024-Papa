Class {
	#name : #LightYear,
	#superclass : #MeasureUnit,
	#category : #'IngSoft2-Model'
}

{ #category : #converting }
LightYear >> parseToSquares: aSize parsecAmount: anAmount [
	^(1/3)*(distanceUnits * (aSize/anAmount)) truncated.
]
