class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(nomhumain)
    @human_player = HumanPlayer.new(nomhumain) # Crée un joueur humain avec le nom donné
    @enemies_in_sight = []
    @players_left = 10
  end

  def start_game
    user = @human_player

    while user.life_points > 0 && @enemies_in_sight.any? { |enemy| enemy.life_points > 0 }
      show_players(user) # Affiche les points de vie
      puts "Quelle action veux-tu effectuer ?"
      puts "a - chercher une meilleure arme"
      puts "s - chercher à se soigner"
      puts "Attaquer un joueur en vue :"
      @enemies_in_sight.each_with_index do |enemi, index|
        puts "#{index} - #{enemi.name} a #{enemi.life_points} points de vie"
      end
      print "> "
      reponse = gets.chomp
      puts " "

      if reponse == "a" 
        puts "vous avez choisi chercher une meilleure arme"
        user.search_weapon
      elsif reponse == "s" 
        puts "vous avez choisi chercher à se soigner"
        user.search_health_pack
      elsif reponse.to_i >= 0 && reponse.to_i < @enemies_in_sight.length # Validation de l'index
        enemy = @enemies_in_sight[reponse.to_i] # Récupère l'ennemi sélectionné par l'utilisateur
        if enemy && enemy.life_points > 0
          puts "vous avez choisi d'attaquer #{enemy.name}"
          puts " "
          user.attacks(enemy) # Attaque l'ennemi
          kill_player(enemy) # Vérifie et supprime l'ennemi si nécessaire
        else
          puts "Cet ennemi est déjà mort!"
        end
      else
        puts "Choix invalide. Veuillez entrer un nombre valide."
      end

      # Appelle la méthode enemies_attack pour gérer les attaques des ennemis
      enemies_attack(user)
      # Appelle la méthode pour generer des enemies
      new_players_in_sight
    end

    # Affiche le résultat de la partie
    if user.life_points > 0
      puts "BRAVO ! TU AS GAGNE !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end

  def show_players(user)
    puts "#{user.name} a #{user.life_points} points de vie" #Affiche vie user

    @enemies_in_sight.each do |enemi| #parcours tableau pour afficher les point de vie des bot
      puts "#{enemi.name} a #{enemi.life_points} points de vie"
    end
  end

  def enemies_attack(user)
    puts "Les autres joueurs t'attaquent !"
    @enemies_in_sight.each do |enemiesplayer| #parcours tableau pour faire attaquer chaque enemi le user
      if enemiesplayer.life_points > 0
        enemiesplayer.attacks(user)
      end
    end
  end

  def kill_player(player) 
    if player.life_points <= 0 #verifie si player(bot) na plus de vie 
      @enemies_in_sight.delete(player) #si cest le cas il est supprimer du tableau
      puts "#{player.name} a été éliminé !"
    end
  end

  def is_still_ongoing?(user)
    user.life_points > 0
  end

  def new_players_in_sight
    if @enemies_in_sight.length < @players_left && @human_player.life_points > 0
      dee = rand(1..6)
      if dee == 1
        puts "aucun nouveau joueur adverse n'arrive"
      elsif dee >= 2 && dee <= 4
         new_enemie = Player.new("bot_#{rand(1..1000)}")
         @enemies_in_sight << new_enemie
         puts "Un enemie Arrive ATTENTION !!!"
      elsif dee == 5 || dee == 6
        2.times do 
          new_enemie = Player.new("bot_#{rand(1..1000)}")
          @enemies_in_sight << new_enemie
        end
        puts "2 enemie Arrive ATTENTION !!!"
      end
    else
      puts "Tous les joueurs sont déjà en vue"
    end
  end
end
