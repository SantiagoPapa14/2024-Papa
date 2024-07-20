Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> test01PlayerCanUseInstantCardsAnytime [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole createEffect ) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer target: nil.
	self assert: (bPlayer ship getShipPosition) equals: 1.
















]

{ #category : #tests }
CardTest >> test02PlayerCanOnlyUsePermanentCardOnHisTurn [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole new) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer target: nil.
	self deny: (aPlayer getAlly) equals: bPlayer.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer target: nil.
	self assert: (aPlayer getAlly) equals: bPlayer.
	
















]

{ #category : #tests }
CardTest >> test03RepeatCardMovesTargetShipBackwarsWhenLastEffectIsBlackHole [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (BlackHole createEffect ) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer target: nil.
	self assert: (bPlayer ship getShipPosition) equals: 1. 
]

{ #category : #tests }
CardTest >> test04AccelerationIncreasesAllPlayersThrow [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration targetPlayer: (aGame getPlayers) target: nil.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 11.
	self assert: (bPlayer ship getShipPosition) equals: 11.



]

{ #category : #tests }
CardTest >> test05OverloadReducesPlayersThrow [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Overload).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Overload targetPlayer: bPlayer target: nil.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 8.



]

{ #category : #tests }
CardTest >> test06AllyCardSetsAnAlly [

	| aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).

	aLoadedBoard := LoadedBoard clone: (Board
			                 withSize: 20
			                 withWorms: false
			                 withParsecs: 1
			                 withDice: someDice).
	aLoadedBoard removeEffects.
	aGame := Game
		         withBoard: aLoadedBoard
		         withDice: someDice
		         withPlayers: 2
		         withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.

	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	
	aPlayer addCards: (OrderedCollection with: (Ally)).	
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer target: nil.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: aPlayer ship getShipPosition equals: 20.
	self assert: bPlayer ship getFuel equals: 5.
]

{ #category : #tests }
CardTest >> test07AllyCardLeavesActiveCardInPlayer [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole createEffect ) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer target: nil.
	self assert: (aPlayer getActiveCards size) equals: 1.



]

{ #category : #tests }
CardTest >> test08AllyCardAndItsEffectCanBeRemovedFromPlayer [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole createEffect ) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer target: nil.
	aPlayer deactivateCard: Ally.
	self assert: (aPlayer getActiveCards size) equals: 0.



]

{ #category : #tests }
CardTest >> test09CancellationCanRemoveAccelerationCard [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration).
	bPlayer addCards: (OrderedCollection with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration targetPlayer: (aGame getPlayers) target: nil.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Cancellation targetPlayer: bPlayer target: Acceleration.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 10.



]

{ #category : #tests }
CardTest >> test10CancellationCanRemoveOverloadCard [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Overload).
	bPlayer addCards: (OrderedCollection with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Overload targetPlayer: bPlayer target: nil.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Cancellation targetPlayer: bPlayer target: Overload.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 10.



]

{ #category : #tests }
CardTest >> test11CancellationCardCanRemoveAllyEfect [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole createEffect ) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	bPlayer addCards: (OrderedCollection with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer target: nil.
	aGame player: bPlayer throwsCard: Cancellation targetPlayer: aPlayer target: Ally.
	
	self assert: (aPlayer getActiveCards size) equals: 0.



]

{ #category : #tests }
CardTest >> test12RedoCardCopiesLastCard [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole createEffect ) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	bPlayer addCards: (OrderedCollection with: Redo with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer target: nil.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame player: bPlayer throwsCard: Redo targetPlayer: aPlayer target: nil.
	self assert: (aPlayer ship getShipPosition) equals: 2.



]

{ #category : #tests }
CardTest >> test13RedoCardDoesNothingIfNoCardsWereUsed [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: bPlayer throwsCard: Redo targetPlayer: aPlayer target: nil.
	self assert: (aPlayer ship getShipPosition) equals: 10.
	self assert: (bPlayer ship getShipPosition) equals: 5.


]

{ #category : #tests }
CardTest >> test14RedoCardCanBeThrownMultipleTimesInARow [
	|aPlayer bPlayer someDice aLoadedBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard removeEffects.
	aLoadedBoard initializeEffect: (BlackHole createEffect ) initializeAt: 10.

	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	bPlayer addCards: (OrderedCollection with: Redo with: Redo with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer target: nil.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame player: bPlayer throwsCard: Redo targetPlayer: aPlayer target: nil.
	aGame giveTurn: aPlayer.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetPlayer: aPlayer target: nil.
	aGame giveTurn: aPlayer.
	aGame skipTurn: aPlayer. 'FOR FUEL'.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetPlayer: aPlayer target: nil.
	self assert: (aPlayer ship getShipPosition) equals: 14.



]

{ #category : #tests }
CardTest >> test15ReversePolarityCardMakesAtomicBombDoNothing [
	|aPlayer someDice aLoadedBoard aGame|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	aLoadedBoard initializeEffect: (AtomicBomb createEffect) initializeAt: 10.
	
	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aPlayer addCards: (OrderedCollection with: ReversePolarity).
	aLoadedBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aLoadedBoard getSquare: 10). 
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10. 
]

{ #category : #tests }
CardTest >> test16BlackHoleIsReversedWhenReversePolarityCardGetsUsedOnIt [
	|aPlayer bPlayer someDice aLoadedBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	anEffect := BlackHole createEffect.
	aLoadedBoard initializeEffect: (anEffect) initializeAt: 10.
	
	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aPlayer addCards: (OrderedCollection with: ReversePolarity).
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 10.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aLoadedBoard getSquare: 10). 
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	self assert: (bPlayer ship getShipPosition) equals: 6. 
	

]

{ #category : #tests }
CardTest >> test17BlackHoleWorksNormallyWhenReversePolarityCardGetsUsedOnItTwice [
	|aPlayer bPlayer someDice aLoadedBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aLoadedBoard := LoadedBoard clone: (Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice ).
	anEffect := BlackHole createEffect.
	aLoadedBoard initializeEffect: (anEffect) initializeAt: 10.
	
	aGame := Game withBoard: aLoadedBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aPlayer addCards: (OrderedCollection with: ReversePolarity with: ReversePolarity).
	bPlayer := aGame getPlayers at: 2.
	aLoadedBoard place: aPlayer at: 5.
	aLoadedBoard place: bPlayer at: 10.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aLoadedBoard getSquare: 10). 
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aLoadedBoard getSquare: 10).
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 6. 
	self assert: (bPlayer ship getShipPosition) equals: 10. 
	

]
