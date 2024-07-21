Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> test01PlayerCanUseInstantCardsAnytime [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (BlackHole createEffect ) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (BlackHole new) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (BlackHole createEffect ) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aPlayer addCards: (OrderedCollection with: Repeat).
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer target: nil.
	self assert: (bPlayer ship getShipPosition) equals: 1. 
]

{ #category : #tests }
CardTest >> test04AccelerationIncreasesAllPlayersThrow [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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

	| aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).

	aBoard := Board
			                 withSize: 20
			                 withWorms: false
			                 withParsecs: 1
			                 withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	aGame := Game
		         withBoard: aBoard
		         withDice: someDice
		         withPlayers: 2
		         withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.

	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	
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
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (BlackHole createEffect ) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer target: nil.
	self assert: (aPlayer getActiveCards size) equals: 1.



]

{ #category : #tests }
CardTest >> test08AllyCardAndItsEffectCanBeRemovedFromPlayer [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (BlackHole createEffect ) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (BlackHole createEffect ) initializeAt: 10 onBoard: aBoard .

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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
CardTest >> test12RedoCardCopiesRepeatCard [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (BlackHole createEffect ) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	bPlayer addCards: (OrderedCollection with: Redo).
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
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (BlackHole createEffect ) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
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
	|aPlayer someDice aBoard aGame|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	(aBoard getSquare: 10) initializeWithEffect: (AtomicBomb createEffect).
	
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 1 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aPlayer addCards: (OrderedCollection with: ReversePolarity).
	aBoard place: aPlayer at: 5.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10). 
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10. 
]

{ #category : #tests }
CardTest >> test16BlackHoleIsReversedWhenReversePolarityCardGetsUsedOnIt [
	|aPlayer bPlayer someDice aBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	anEffect := BlackHole createEffect.
	BoardUtility initializeEffect: (anEffect) initializeAt: 10 onBoard: aBoard.
	
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aPlayer addCards: (OrderedCollection with: ReversePolarity).
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 10.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10). 
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 10. 
	self assert: (bPlayer ship getShipPosition) equals: 6. 
	

]

{ #category : #tests }
CardTest >> test17EffectsWorkNormallyWhenReversePolarityCardGetsUsedOnThemTwice [
	|aPlayer bPlayer someDice aBoard aGame anEffect|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	anEffect := BlackHole createEffect.
	BoardUtility initializeEffect: (anEffect) initializeAt: 10 onBoard: aBoard.
	
	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	aPlayer addCards: (OrderedCollection with: ReversePolarity with: ReversePolarity).
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 10.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10). 
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10).
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 6. 
	self assert: (bPlayer ship getShipPosition) equals: 10. 
	

]

{ #category : #tests }
CardTest >> test18AccelerationAndRedoCombinedAddsTwoAccelerations [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration targetPlayer: (aGame getPlayers) target: nil.
	aGame player: aPlayer throwsCard: Redo targetPlayer: (aGame getPlayers) target: Acceleration.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 12.
	self assert: (bPlayer ship getShipPosition) equals: 12.



]

{ #category : #tests }
CardTest >> test19AccelerationAndRedoCombinedThenCancelOnlyRemovesOneAcceleration [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration with: Redo with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration targetPlayer: (aGame getPlayers) target: nil.
	aGame player: aPlayer throwsCard: Redo targetPlayer: (aGame getPlayers) target: Acceleration.
	aGame player: aPlayer throwsCard: Cancellation targetPlayer: aPlayer target: Acceleration.
	aGame playTurn: aPlayer.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 11.
	self assert: (bPlayer ship getShipPosition) equals: 12.



]

{ #category : #tests }
CardTest >> test20RepeatCardAppliesMoonwalkEffectConsideringPolarization [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (MoonWalk withDistance: 4) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat with: ReversePolarity).
	
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10).
	aGame playTurn: aPlayer.
	self assert: (aPlayer ship getShipPosition) equals: 6.
	aPlayer ship resetFuelTank.
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer target: nil.
	self assert: (bPlayer ship getShipPosition) equals: 1.
]

{ #category : #tests }
CardTest >> test21RepeatCardDoesNotApplyPolarizedAtomicBomb [
	|aPlayer bPlayer someDice aBoard aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility initializeEffect: (AtomicBomb createEffect) initializeAt: 10 onBoard: aBoard.

	aGame := Game withBoard: aBoard withDice: someDice withPlayers: 2 withMaxLaps: 100.
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard place: aPlayer at: 5.
	aBoard place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat with: ReversePolarity).
	
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10).
	aGame playTurn: aPlayer.
	aPlayer ship resetFuelTank.
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer target: nil.
	self assert: (bPlayer ship getShipPosition) equals: 5.
	self assert: (aPlayer ship getShipPosition) equals: 10.
]

{ #category : #tests }
CardTest >> test22RedoCardCopiesAccelerationCard [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Acceleration).
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Acceleration targetPlayer: (OrderedCollection with: bPlayer) target: nil.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetPlayer: (OrderedCollection with: bPlayer)  target: nil.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 12.



]

{ #category : #tests }
CardTest >> test23RedoCardCopiesAllyCard [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Ally).
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer target: nil.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetPlayer: aPlayer  target: nil.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	aGame playTurn: bPlayer.
	aGame playTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getFuel) equals: 0.



]

{ #category : #tests }
CardTest >> test24RedoCardCopiesOverloadCard [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Overload).
	bPlayer addCards: (OrderedCollection with: Redo).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Overload targetPlayer: bPlayer target: nil.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetPlayer: bPlayer  target: nil.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 6.



]

{ #category : #tests }
CardTest >> test25RedoCardCopiesReversePolarityCard [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: ReversePolarity).
	bPlayer addCards: (OrderedCollection with: Redo).
	BoardUtility initializeEffect: (AtomicBomb createEffect) initializeAt: 10 onBoard: aBoard. 
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10).
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Redo targetPlayer: nil  target: (aBoard getSquare: 10).
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 1.



]

{ #category : #tests }
CardTest >> test26RedoCardCopiesCancellationCard [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.

	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Overload with: Ally).
	bPlayer addCards: (OrderedCollection with: Redo with: Cancellation).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: Ally targetPlayer: bPlayer target: nil.
	aGame player: aPlayer throwsCard: Overload targetPlayer: bPlayer target: nil.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: Cancellation targetPlayer: aPlayer target: Ally.
	aGame player: bPlayer throwsCard: Redo targetPlayer: bPlayer target: Overload.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 10.



]

{ #category : #tests }
CardTest >> test27RepeatCardResetsShipsWhenLastEffectIsAtomicBomb [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (AtomicBomb createEffect) initializeAt: 10  onBoard: aBoard. 
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	bPlayer addCards: (OrderedCollection with: Repeat).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	bPlayer ship resetFuelTank.
	self assert: (bPlayer ship getShipPosition) equals: 1.
	aGame playTurn: bPlayer.
	self assert: (bPlayer ship getShipPosition) equals: 6.
	aGame player: bPlayer throwsCard: Repeat targetPlayer: bPlayer  target: nil. 
	self assert: (bPlayer ship getShipPosition) equals: 1.
]

{ #category : #tests }
CardTest >> test28RepeatCardMovesOtherShipsBackWhenLastEffectIsMoonwalk [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (MoonWalk withDistance: 1) initializeAt: 10  onBoard: aBoard. 
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	bPlayer addCards: (OrderedCollection with: Repeat).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	bPlayer ship resetFuelTank.
	self assert: (aPlayer ship getShipPosition) equals: 4.
	aGame player: bPlayer throwsCard: Repeat targetPlayer: aPlayer  target: nil. 
	self assert: (bPlayer ship getShipPosition) equals: 9.
]

{ #category : #tests }
CardTest >> test29RepeatCardGivesShipCardsWhenLastEffectIsCardDealer [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (CardDealer createEffect) initializeAt: 10  onBoard: aBoard. 
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	self assert: (bPlayer getCards size) equals: 3.
	aGame player: aPlayer throwsCard: Repeat targetPlayer: bPlayer  target: nil. 
	self assert: (bPlayer getCards size) equals: 4.
]

{ #category : #tests }
CardTest >> test30RepeatGravitatesPlayerWhenLastEffectIsHyperG [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 1  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (HyperGravity withNecessaryRolledResult: 20) initializeAt: 10  onBoard: aBoard. 
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	aGame player: aPlayer throwsCard: Repeat targetPlayer: aPlayer  target: nil. 
	self assert: (aPlayer ship getGravity) equals: 20.
]

{ #category : #tests }
CardTest >> test31RepeatMovesShipForwardWhenLastEffectIsHyperJump [
	|aPlayer bPlayer someDice aBoard  aGame |
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 5  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (HyperJump withUnits: (OrderedCollection with: (Parsec withUnits: 1)) withBoard: aBoard) initializeAt: 10  onBoard: aBoard. 
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	aPlayer addCards: (OrderedCollection with: Repeat).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	bPlayer ship resetFuelTank.
	aGame player: aPlayer throwsCard: Repeat targetPlayer: aPlayer  target: nil. 
	self assert: (bPlayer ship getShipPosition) equals: (aPlayer ship getShipPosition + 5).
]

{ #category : #tests }
CardTest >> test32RepeatTPsShipWhenLastEffectIsWormHole [
	|aPlayer bPlayer someDice aBoard  aGame wormPositions|
	someDice := OrderedCollection with: (LoadedDie of: 3).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 5  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	aBoard initializeWormSquares.
	wormPositions := BoardUtility findWormSquares: aBoard.
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: (wormPositions at: 1) - 3.
	aBoard  place: bPlayer at: (wormPositions at: 1) - 3.
	aPlayer addCards: (OrderedCollection with: Repeat).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame playTurn: bPlayer.
	bPlayer ship resetFuelTank.
	aGame player: aPlayer throwsCard: Repeat targetPlayer: aPlayer  target: nil. 
	self assert: (bPlayer ship getShipPosition) equals: (wormPositions at: 2).
	self assert: (aPlayer ship getShipPosition) equals: (wormPositions at: 2).
]

{ #category : #tests }
CardTest >> test33ReversePolarityMakesCardDealerGiveEveryoneElseCards [
	|aPlayer bPlayer someDice aBoard  aGame|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 5  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (CardDealer createEffect) initializeAt: 10 onBoard: aBoard.
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	bPlayer addCards: (OrderedCollection with: ReversePolarity ).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10). 
	aGame playTurn: bPlayer.
	self assert: (aPlayer getCards size) equals: (3).
]

{ #category : #tests }
CardTest >> test34ReversePolarityMakesHyperGravityAffectAllOtherShips [
	|aPlayer bPlayer someDice aBoard  aGame|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 5  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (HyperGravity withNecessaryRolledResult: 10) initializeAt: 10 onBoard: aBoard.
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	bPlayer addCards: (OrderedCollection with: ReversePolarity ).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10). 
	aGame playTurn: bPlayer.
	self assert: (aPlayer ship getGravity) equals: (10).
]

{ #category : #tests }
CardTest >> test35ReversePolarityMakesHyperJumpAffectAllOtherShips [
	|aPlayer bPlayer someDice aBoard  aGame|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 5  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	BoardUtility initializeEffect: (HyperJump withUnits: (OrderedCollection with: (Parsec withUnits: 1)) withBoard: aBoard) initializeAt: 10  onBoard: aBoard. 
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: 5.
	aBoard  place: bPlayer at: 5.
	bPlayer addCards: (OrderedCollection with: ReversePolarity ).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: bPlayer.
	aGame player: bPlayer throwsCard: ReversePolarity targetPlayer: nil target: (aBoard getSquare: 10). 
	aGame playTurn: bPlayer.
	self deny: (aPlayer ship getShipPosition) equals: (5).
]

{ #category : #tests }
CardTest >> test36ReversedPolarityWormHoleTPsAllOtherShips [
	|aPlayer bPlayer someDice aBoard  aGame wormPositions|
	someDice := OrderedCollection with: (LoadedDie of: 3).
	
	aBoard  := Board withSize: 20 withWorms: false  withParsecs: 5  withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	aBoard initializeWormSquares.
	wormPositions := BoardUtility findWormSquares: aBoard.
	aGame := Game withBoard: aBoard  withDice: someDice withPlayers: 2 withMaxLaps: 100.
	
	aPlayer := aGame getPlayers at: 1.
	bPlayer := aGame getPlayers at: 2.
	aBoard  place: aPlayer at: (wormPositions at: 1) - 3.
	aBoard  place: bPlayer at: (wormPositions at: 1) - 3.
	aPlayer addCards: (OrderedCollection with: ReversePolarity).
	'--------------------------------------------------------------------------'.
	aGame giveTurn: aPlayer.
	aGame player: aPlayer throwsCard: ReversePolarity targetPlayer: nil  target: (aBoard getSquare: (wormPositions at: 1)). 
	aGame playTurn: aPlayer.
	self assert: (bPlayer ship getShipPosition) equals: (wormPositions at: 2).
]

{ #category : #tests }
CardTest >> test37DeckCanReturnRandomCardHand [
	|aDeck aHand|
	aDeck := Deck getDeck.
	aHand := Deck getRandomCards: 1.
	self assert:( aDeck includes: (aHand at: 1)).
	aHand := Deck getRandomCards: 3.
	self assert:( aDeck includes: (aHand at: 1)).
	self assert:( aDeck includes: (aHand at: 2)).
	self assert:( aDeck includes: (aHand at: 3)).
]

{ #category : #tests }
CardTest >> test38DeckKnowsAllCards [
	|aDeck|
	aDeck := Deck getDeck.
	self assert: aDeck size equals: 6.
	self assert: (aDeck includes: Cancellation).
	self assert: (aDeck includes: Repeat).
	self assert: (aDeck includes: Acceleration).
	self assert: (aDeck includes: Ally).
	self assert: (aDeck includes: Overload).
	self assert: (aDeck includes: Redo).
]
