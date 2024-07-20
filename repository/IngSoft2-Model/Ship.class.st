"
Ship needs to have a name, has the responsability to roll the dice each turn and has the satuts winner.
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'gravityLevel',
		'position',
		'fuel',
		'maxFuel',
		'laps',
		'turbines'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Ship class >> withFuel: someFuel [
	^(self new) initializeShipWithFuel: someFuel.
]

{ #category : #getsAndSets }
Ship >> addFuelCapacity: someExtraCapacity [
	maxFuel := maxFuel + someExtraCapacity.
]

{ #category : #getsAndSets }
Ship >> addLaps: lapAmount [ 
	laps:= laps + lapAmount.
]

{ #category : #accessing }
Ship >> canMove: aDistance [

	aDistance = gravityLevel ifTrue: [ gravityLevel := 0 ].
	^ gravityLevel = 0
]

{ #category : #accessing }
Ship >> consumeFuel: someFuel [

	| fuelAmountModule |
	fuelAmountModule := someFuel abs.
	fuel := fuel - fuelAmountModule.
	fuel < 0 ifTrue: [
		fuel := 0.
		^ false ].
	^ true
]

{ #category : #getsAndSets }
Ship >> explodeTurbine [
	turbines := turbines - 1.
]

{ #category : #getsAndSets }
Ship >> getFuel [
	^fuel 
]

{ #category : #getsAndSets }
Ship >> getGravity [
	^gravityLevel.
]

{ #category : #getsAndSets }
Ship >> getLaps [
	^laps.
]

{ #category : #getsAndSets }
Ship >> getShipPosition [
	^position 
]

{ #category : #getsAndSets }
Ship >> initializeShipWithFuel: someFuel [
	maxFuel := someFuel.
	turbines := 3.
	laps := 0.
	gravityLevel := 0.
	fuel := someFuel.
	
]

{ #category : #accessing }
Ship >> resetFuelTank [
	fuel := maxFuel.
]

{ #category : #getsAndSets }
Ship >> setGravity: someLevel [

	gravityLevel := someLevel
]

{ #category : #getsAndSets }
Ship >> setShipPosition:  someSquare [

	position := someSquare
]

{ #category : #getsAndSets }
Ship >> turbinesLeft [
	^turbines.
]
