require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Créer une nouvelle partie
puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !     |"
puts "|Le but du jeu est d'être le dernier survivant!|"
puts "------------------------------------------------"
puts " "
puts "Votre nom Jeune Humain :"
print ">"
nomhumain = gets.chomp

# Création d'un nouvel objet Game
my_game = Game.new(nomhumain)

my_game.new_players_in_sight

my_game.start_game
