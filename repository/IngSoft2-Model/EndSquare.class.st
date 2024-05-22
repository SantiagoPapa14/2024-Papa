"
End Square sets the winner once it docks a ship.
"
Class {
	#name : #EndSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #modifying }
EndSquare >> dockShip: aShip [
	dockedShips add: aShip.
	^true.
]