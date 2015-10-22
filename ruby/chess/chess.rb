# Chess
#
# Player vs Player
# Script to launch a new game
#
# Functionalities implemented:
#
# - Prints "Check!" when a king is in check
#     The player in check has no choice but to move his king on a safe case, to move a
#     piece between his king and the adverse piece, or to take this adverse piece.
#
# - Prints "Checmate!" when a king is in checkmate and exit the game
#     Happens when the player's king is in check and has no solution to avoid the same
#     situation the following turn.
#
# - Prints "Draw!" if the game finishes in a draw
#     When only the kings remain on the board.
#
# - Prints "Slatemate!" if the game finishes with a slatemate
#     When the player has got only his king remaining on the board, and can't move it
#     without putting it in check.
#
# - Pawn can double case when at initial location
#
# - Pawn can be changed in another piece when reaches opposite side
#     Piece selected by player.
#
# - Castling can be made
#     If the player's king is not in check and can't be on the way to castle. And if the
#     king and the rook concerned have not moved since beginning of game.
#
# - Game can be saved at beginning of every turn. If so, exit the game. Player chooses to
#   load a game or create a new one at beginning of game.

require './lib/game.rb'

game = Game.new
game.start