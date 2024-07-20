Class {
	#name : #WormTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormTest >> test01WormHolesAreInitialized [

	|aBoard wormPositions|
	aBoard := Board withSize: 20 withWorms: true withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	wormPositions := BoardUtility findWormSquares: aBoard.
	self assert: (((wormPositions at: 1) isNotNil) and: ((wormPositions at: 2) isNotNil )).
]

{ #category : #tests }
WormTest >> test02WormHolesTeleportShips [
	| aPlayer someDice aBoard aGame worms|
	someDice := OrderedCollection with: (LoadedDie of: 5).

	aBoard := Board
			                 withSize: 20
			                 withWorms: true
			                 withParsecs: 1
			                 withDice: someDice.
	aGame := Game
		         withBoard: aBoard
		         withDice: someDice
		         withPlayers: 2
		         withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.

	worms := BoardUtility findWormSquares: aBoard.
	aBoard place: aPlayer at: (worms at: 1) - 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: (worms at: 2)
	
]
