require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'



puts "------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !     |"
puts "|Le but du jeu est d'être le dernier survivant!|"
puts "------------------------------------------------"
puts " "
puts "Votre nom Jeune Humain :"
print ">"
nomhumain = gets.chomp

user = HumanPlayer.new(nomhumain)
# Création des joueurs
player1 = Player.new("Josiane")
player2 = Player.new("José")

# Stockage des joueurs dans un tableau
enemies = [player1, player2]

while user.life_points >0 && (player1.life_points > 0 || player2.life_points >0)

puts "#{user.name} a #{user.life_points} points de vie"
puts "#{player1.name} a #{player1.life_points} points de vie"
puts "#{player2.name} a #{player2.life_points} points de vie"
puts " "
puts "Quelle action veux-tu effectuer ?"
puts "a - chercher une meilleure arme"
puts "s - chercher à se soigner"
puts "Attaquer un joueur en vue :"
puts "0 - #{player1.name} a #{player1.life_points} points de vie"
puts "1 - #{player2.name} a #{player2.life_points} points de vie"
print "> "
reponse = gets.chomp
puts " "

if reponse == "a" 
  puts "vous avez choisi chercher une meilleure arme "
  puts " "
  user.search_weapon
elsif reponse == "s" 
  puts "vous avez choisi chercher à se soigner"
  puts " "
  user.search_health_pack
elsif reponse == "0"
  puts "vous avez choisi d'attaquer #{player1.name}"
  puts " "
  user.attacks(player1)
elsif reponse == "1"
  puts "vous avez choisi d'attaquer #{player2.name}"
  puts " "
  user.attacks(player2)
end

if player1.life_points > 0 || player2.life_points > 0
  puts "Les autres joueurs t'attaquent !"
else
  puts "La partie est finie"
end


enemies.map do |enemiesplayer|
  if enemiesplayer.life_points > 0
    enemiesplayer.attacks(user)
  end
 
end





end



if user.life_points != 0
  puts "BRAVO ! TU AS GAGNE !"
else
  puts "Loser ! Tu as perdu !"
end





