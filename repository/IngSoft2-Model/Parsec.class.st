Class {
	#name : #Parsec,
	#superclass : #MeasureUnit,
	#category : #'IngSoft2-Model'
}

{ #category : #converting }
Parsec >> parseToSquares: aSize parsecAmount: anAmount [
	^(distanceUnits * (aSize/anAmount )) truncated.
]
