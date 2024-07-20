Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].

]

{ #category : #tests }
ShipTest >> test01PassesWhenShipCanRollMultipleDice [
	
	|aPlayer dice |
	dice:= OrderedCollection new.
	dice add: (LoadedDie of: 4).
	dice add: (LoadedDie of: 5).
	aPlayer := Player named: 'Pepe' withShip: 1.
	self assert: ((aPlayer rollDice: dice) = 9).
]

{ #category : #tests }
ShipTest >> test02IsValidWhenShipsFuelReducesProportionallyToMovement [

	| aShip aPlayer aBoard |
	aBoard := Board withSize: 20 withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aShip := Ship withFuel: 10.
	aPlayer := Player named: 'Pepe' withShip: aShip.
	aBoard place: aPlayer at: 1.
	aBoard move: aPlayer distance: 5.
	self assert: aShip getFuel equals: 5
]

{ #category : #tests }
ShipTest >> test03ShipsPositionIsResetWhenShipDoesNotHaveEnoughFuelToMove [
	|aPlayer aBoard aGame|
	aBoard := Board withSize: 100 withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 5)).
	BoardUtility removeEffectsOnBoard: aBoard.
	aGame := Game withBoard: aBoard withDice: (OrderedCollection with: (LoadedDie of: 5)) withPlayers: 1  withMaxLaps: 1.
	aPlayer := (aGame getPlayers) at: 1.
	aBoard place: aPlayer at: 2.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 1. 
]

{ #category : #tests }
ShipTest >> test04ShipDoesntMoveWhenSkipsTurn [
	|aPlayer aBoard aGame|
	aBoard := Board withSize: 20 withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aGame := Game withBoard: aBoard withDice: (OrderedCollection with: (LoadedDie of: 3)) withPlayers: 1  withMaxLaps: 1.
	aPlayer := (aGame getPlayers) at: 1.
	aBoard place: aPlayer at: 1.
	aGame skipTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 1. 
]

{ #category : #tests }
ShipTest >> test05ShipGetsRefueledWhenSkipsTurn [
	|aPlayer aBoard aGame|
	aBoard :=Board withSize: 20 withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	BoardUtility removeEffectsOnBoard: aBoard.
	aGame := Game withBoard: aBoard withDice: (OrderedCollection with: (LoadedDie of: 3)) withPlayers: 1  withMaxLaps: 1.
	aPlayer := (aGame getPlayers) at: 1.
	aBoard place: aPlayer at: 1.
	aBoard move: aPlayer distance: 3.
	aGame giveTurn: aPlayer.
	aGame skipTurn: aPlayer.
	self assert: (aPlayer ship getFuel) equals: 6. 
]

{ #category : #tests }
ShipTest >> test06ShipsLapsIncreseWhenItGoesPastEndSquare [
	|aBoard aBoardSize aPlayer|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 1000).
	aBoard place: aPlayer at: 1. 
	aBoard move: aPlayer distance: 14.
	self assert: (aPlayer ship getLaps ) equals: 1.
]

{ #category : #tests }
ShipTest >> test07ShipsLapsReduceWhenExceedsBoardGoingBackwards [
	|aBoard aBoardSize aPlayer|
	aBoardSize := 10.
	aBoard := Board withSize: aBoardSize withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	aPlayer := Player named: 'Pepe' withShip: (Ship withFuel: 1000).
	aBoard place: aPlayer at: 1. 
	aBoard move: aPlayer distance: -5.
	aPlayer ship addLaps: 2.
	self assert: (aPlayer ship getLaps ) equals: 1.
]

{ #category : #tests }
ShipTest >> test08ShipCanNotMoveWithoutTurbines [
	|aPlayer someDice aBoard aGame|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aPlayer ship explodeTurbine.
	aPlayer ship explodeTurbine.
	aPlayer ship explodeTurbine.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 5. 
]

{ #category : #tests }
ShipTest >> test09ShipsTurbineExplodesWhenRollResultIsNotEqualsToGravityLevel [
	|aPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (HyperGravity withNecessaryRolledResult: 1) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship turbinesLeft) equals: 1. 
	
]

{ #category : #tests }
ShipTest >> test10ShipsTurbineExplodesWhenItGoesThroughBlackHole [
	|aPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (BlackHole createEffect) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship turbinesLeft) equals: 2. 
	
]

{ #category : #tests }
ShipTest >> test11ShipsTurbineExplodesIfItDoesNotHaveEnoughFuelToMove [
	|aPlayer aBoard aGame|
	aBoard := Board withSize: 100 withWorms: false withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 5)).
	BoardUtility removeEffectsOnBoard: aBoard.
	aGame := Game withBoard: aBoard withDice: (OrderedCollection with: (LoadedDie of: 5)) withPlayers: 1  withMaxLaps: 1.
	aPlayer := (aGame getPlayers) at: 1.
	aBoard place: aPlayer at: 2.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship turbinesLeft) equals: 1. 
]
