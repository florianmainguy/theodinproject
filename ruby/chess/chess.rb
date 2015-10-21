# Chess
#
# Player vs Player
# Script to launch a new game
#
# Functionalities implemented:
# - Prints "Check!" when a king is in check
# - Prints "Checmate!" when a king is in checkmate
# - Prints "Draw!" if the game finishes in a draw
# - Prints "Slatemate!" if the game finishes with a slatemate

require './lib/game.rb'

game = Game.new
game.start