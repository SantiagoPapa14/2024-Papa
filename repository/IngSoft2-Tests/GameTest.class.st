Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].

]

{ #category : #tests }
GameTest >> test01ValidGameCanFinish [

	| game aBoard someDice myPlayer |
	someDice := OrderedCollection with: (LoadedDie of: 11).
	aBoard := Board
		          withSize: 10
		          withWorms: false
		          withParsecs: 3
		          withDice: someDice.
	BoardUtility removeEffectsOnBoard: aBoard.
	game := Game
		        withBoard: aBoard
		        withDice: someDice
		        withPlayers: 1
		        withMaxLaps: 2.
	myPlayer := game getPlayers at: 1.
	aBoard place: myPlayer at: 1.
	game giveTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	game giveTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	game giveTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	game giveTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	game giveTurn: myPlayer.
	game playTurn: myPlayer.
	game skipTurn: myPlayer.
	game giveTurn: myPlayer.
	self assert: game hasWinner equals: true
]

{ #category : #tests }
GameTest >> test02GameCanGetRankingAndOrdersShipsCorrectly [
	|aGame aBoard someDice players|
	someDice := OrderedCollection with: (LoadedDie of: 5).
	aBoard := Board withSize: 30 withWorms: false withParsecs: 3 withDice: someDice.
	aGame := Game withBoard: aBoard withDice: someDice  withPlayers: 3 withMaxLaps: 10.
	players := aGame getPlayers.
	aBoard place: (players at: 1) at: 3.
	aBoard place: (players at: 2) at: 19.
	aBoard place: (players at: 3) at: 29.
	self assert: (aGame getRanking at: 1) equals: (players at: 3).
	self assert: (aGame getLeaderboard at: 1) equals: '3'.
]

{ #category : #tests }
GameTest >> test03PlayerStartsGameWithSomeAmountOfCards [

	| aPlayer someDice aBoard aGame |
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
	self assert: aPlayer getCards size equals: 2
]

{ #category : #tests }
GameTest >> test04PlayerCantMoveWhenItsNotHisTurn [

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
	aBoard place: bPlayer at: 5.
	aBoard place: aPlayer at: 5. 
	aGame giveTurn: aPlayer.
	aGame playTurn: bPlayer.
	self assert: bPlayer ship getShipPosition equals: 5.
]

{ #category : #tests }
GameTest >> test05PlayerCanOnlyWhenItsHisTurn [

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
	aBoard place: bPlayer at: 5.
	aBoard place: aPlayer at: 5. 
	aGame giveTurn: aPlayer.
	aGame playTurn: aPlayer.
	self assert: aPlayer ship getShipPosition equals: 10.
]
