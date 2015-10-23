## Ruby Final Project - Chess Game

From [The Odin Project](http://www.theodinproject.com/ruby-programming/ruby-final-project)<br><br>
Build a command line Chess game where two players can play against each other.<br>
To run the game, launch `chess.rb`<br>
<br>

## Functionalities Implemented:

* **Prints "Check!" when a king is in check**
<br>The player in check has no choice but to move his king on a safe case, to move a
<br>piece between his king and the adverse piece, or to take this adverse piece.

* **Prints "Checmate!" when a king is in checkmate and exit the game**
<br>Happens when the player's king is in check and has no solution to avoid the same
<br>situation the following turn.

* **Prints "Draw!" if the game finishes in a draw**
<br>When only the kings remain on the board.

* **Prints "Slatemate!" if the game finishes with a slatemate**
<br>When the player has got only his king remaining on the board, and can't move it without putting it in check.

* **Pawn can double case when at initial location**

* **Pawn can be changed in another piece when reaches opposite side**
<br>Piece selected by player.

* **Castling can be made**
<br>If the player's king is not in check and can't be on the way to castle. And if the king and the rook concerned have not moved since beginning of game.

* **Game can be saved at beginning of every turn**
<br>If so, exit the game. Player chooses to load a game or create a new one at beginning of game.
