Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> test01AtomicBombResetsAllShip [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (AtomicBomb createEffect) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 2.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	
	self assert: (bPlayer ship getShipPosition) equals: 1.
	self assert: (aPlayer ship getShipPosition) equals: 1. 
	 
	
	 
]

{ #category : #tests }
EffectTest >> test02AtomicBombDoesNotAffectFuel [
	|aPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (AtomicBomb createEffect) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getFuel) equals: 5. 
	
	 
]

{ #category : #tests }
EffectTest >> test03AtomicBombDoesNotAffectLaps [
	|aPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (AtomicBomb createEffect ) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aPlayer ship addLaps: 2.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getLaps) equals: 2. 
	
	 
]

{ #category : #tests }
EffectTest >> test04MoonWalkEffectMovesAllOtherShipBackwards [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (MoonWalk withDistance: 1) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	self assert: (bPlayer ship getShipPosition) equals: 4. 
	
]

{ #category : #tests }
EffectTest >> test05MoonWalkResetsShipPositionIfItDoesNotHaveEnoughFuelToMoveAndSkipsTwoTurns [

	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice .
	BoardUtility removeEffectsOnBoard: aBoard. 
	BoardUtility initializeEffect: (MoonWalk withDistance: 100) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 1.
	
	
]

{ #category : #tests }
EffectTest >> test06BlackHoleEffectMovesShipBackwards [
	|aPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (BlackHole createEffect ) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 6. 
]

{ #category : #tests }
EffectTest >> test07HyperJumpMovesShipCorrectSquareAmountAccordingToParsecs [
	|aPlayer someDice aBoard aGame myUnits|
	someDice := OrderedCollection with: (LoadedDie of: 10).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 10  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	
	
	myUnits := OrderedCollection with: (Parsec withUnits: 2) with: (Parsec withUnits: 4).
	BoardUtility initializeEffect: (HyperJump withUnits: myUnits withBoard: aBoard) initializeAt: 15 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 3. 
]

{ #category : #tests }
EffectTest >> test08HyperJumpParsecListResets [
	|aPlayer someDice aBoard aGame myUnits |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 10  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	myUnits := OrderedCollection with: (Parsec withUnits: 2) with: (Parsec withUnits: 4).
	BoardUtility initializeEffect: (HyperJump withUnits: myUnits withBoard: aBoard) initializeAt: 15 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aPlayer ship initializeShipWithFuel: 100101012.
	aBoard place: aPlayer at: 10.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aBoard takeOut: aPlayer.
		aBoard place: aPlayer at: 10.
	aGame playTurn: aPlayer.
	aBoard takeOut: aPlayer.
		aBoard place: aPlayer at: 10.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 3. 
]

{ #category : #tests }
EffectTest >> test09ShipDoesNotMoveWhenRollsDifferentThanHyperGravityNecessaryRolledResult [
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
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	
]

{ #category : #tests }
EffectTest >> test10ShipMovesWhenRollsHyperGravityNecessaryRolledResult [
	|aPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (HyperGravity withNecessaryRolledResult: 5) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame skipTurn: aPlayer.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 15. 
]

{ #category : #tests }
EffectTest >> test11ShipDoesNotGetAffectedByEffectsIfInHyperGravity [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (HyperGravity withNecessaryRolledResult: 10) initializeAt: 6 onBoard:aBoard .
	BoardUtility initializeEffect: (AtomicBomb createEffect) initializeAt: 10 onBoard:aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aBoard place: aPlayer at: 1.
	aBoard place: bPlayer at: 5.
	
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 6.
	
]

{ #category : #tests }
EffectTest >> test12OnlyOneEffectIsAppliedPerTurn [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (MoonWalk withDistance: 1) initializeAt: 10 onBoard: aBoard.
	BoardUtility initializeEffect: (AtomicBomb createEffect ) initializeAt: 4 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 4.
]

{ #category : #tests }
EffectTest >> test13HyperJumpMovesShipCorrectSquareAmountAccordingToLightYears [
	|aPlayer someDice aBoard aGame myUnits|
	someDice := OrderedCollection with: (LoadedDie of: 10).
	
	aBoard := Board withSize: 30 withWorms: false  withParsecs: 10  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	
	
	myUnits := OrderedCollection with: (LightYear withUnits: 1).
	BoardUtility initializeEffect: (HyperJump withUnits: myUnits withBoard: aBoard) initializeAt: 15 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 16. 
]

{ #category : #tests }
EffectTest >> test14PlayerGetsACardWhenItLandsOnCardDealer [
	|aPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (CardDealer createEffect) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer getCards size) equals: 3.
]

{ #category : #tests }
EffectTest >> test15AtomicBombDoesNotDoAnythingWhenReversed [
	|aPlayer someDice aBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	anEffect := AtomicBomb createEffect.
	BoardUtility initializeEffect: (anEffect) initializeAt: 10 onBoard: aBoard.
	anEffect reverseEffectPolarity.
	
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10. 
]

{ #category : #tests }
EffectTest >> test16BlackHoleMovesEveryoneExceptTheOneWhoLandedWhenReversed [
	|aPlayer bPlayer someDice aBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	anEffect := BlackHole createEffect.
	BoardUtility initializeEffect: (anEffect) initializeAt: 10 onBoard: aBoard.
	anEffect reverseEffectPolarity.
	
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 10.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	self assert: (bPlayer ship getShipPosition) equals: 6. 
	

]

{ #category : #tests }
EffectTest >> test17AllPlayersGetRandomCardWhenCardDealerIsReversed [
	|aPlayer bPlayer cPlayer someDice aBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	anEffect := CardDealer createEffect.
	BoardUtility initializeEffect: (anEffect) initializeAt: 10 onBoard: aBoard.
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 3 withMaxLaps: 100.
	anEffect reverseEffectPolarity.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	cPlayer := aGame getPlayers at: 3.
	
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	
	self assert: (bPlayer getCards size) equals: 3.
	self assert: (cPlayer getCards size) equals: 3.
]

{ #category : #tests }
EffectTest >> test18HyperGravityAffectsAllPlayersExceptTheOneWhoLandedWhenReversed [
	|aPlayer bPlayer cPlayer someDice aBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	anEffect := CardDealer createEffect.
	BoardUtility initializeEffect: (anEffect) initializeAt: 10 onBoard: aBoard.
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 3 withMaxLaps: 100.
	anEffect reverseEffectPolarity.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	cPlayer := aGame getPlayers at: 3.
	
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	
	self assert: (bPlayer getCards size) equals: 3.
	self assert: (cPlayer getCards size) equals: 3.
]

{ #category : #tests }
EffectTest >> test19HyperJumpAffectsAllPlayersExceptTheOneWhoLandedWhenReversed [
	|aPlayer bPlayer cPlayer someDice aBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	anEffect := CardDealer createEffect.
	BoardUtility initializeEffect: (anEffect) initializeAt: 10 onBoard: aBoard.
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 3 withMaxLaps: 100.
	anEffect reverseEffectPolarity.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	cPlayer := aGame getPlayers at: 3.
	
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	
	self assert: (bPlayer getCards size) equals: 3.
	self assert: (cPlayer getCards size) equals: 3.
]

{ #category : #tests }
EffectTest >> test20MoonwalkAffectsTheOneWhoLandedWhenReversed [
	|aPlayer bPlayer cPlayer someDice aBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	anEffect := CardDealer createEffect.
	BoardUtility initializeEffect: (anEffect) initializeAt: 10 onBoard: aBoard.
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 3 withMaxLaps: 100.
	anEffect reverseEffectPolarity.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	cPlayer := aGame getPlayers at: 3.
	
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	
	self assert: (bPlayer getCards size) equals: 3.
	self assert: (cPlayer getCards size) equals: 3.
]

{ #category : #tests }
EffectTest >> test21WormHoleAffectsAllPlayersExceptTheOneWhoLandedWhenReversed [
	|aPlayer bPlayer cPlayer someDice aBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	anEffect := CardDealer createEffect.
	BoardUtility initializeEffect: (anEffect) initializeAt: 10 onBoard: aBoard.
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 3 withMaxLaps: 100.
	anEffect reverseEffectPolarity.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	cPlayer := aGame getPlayers at: 3.
	
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	
	self assert: (bPlayer getCards size) equals: 3.
	self assert: (cPlayer getCards size) equals: 3.
]

{ #category : #tests }
EffectTest >> test22WormHolesAreInitialized [

	|aBoard wormPositions|
	aBoard := Board withSize: 20 withWorms: true withParsecs: 1 withDice: (OrderedCollection with: (LoadedDie of: 3)).
	wormPositions := BoardUtility findWormSquares: aBoard.
	self assert: (((wormPositions at: 1) isNotNil) and: ((wormPositions at: 2) isNotNil )).
]

{ #category : #tests }
EffectTest >> test23WormHolesTeleportShips [
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

{ #category : #tests }
EffectTest >> test24NullEffectDoesNothing [
	|aPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (NullEffect createEffect) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	
]
