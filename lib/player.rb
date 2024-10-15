class Player 
  attr_accessor :name
  attr_accessor :life_points

  def initialize(name, life = 10)
    @name = name
    @life_points = life
  end

  def show_state
    "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(dommage)
    @life_points -= dommage
    if @life_points > 0
      nil
    else
      @life_points = 0
      puts "Le joueur #{@name} a été tué !"
    end
  end

  def attacks(player)
    puts "#{@name} attaque #{player.name}"
    damage = compute_damage
    puts "il lui inflige #{damage} points de dommages"
    puts " "
    player.gets_damage(damage)
  end

  def to_s
    @name
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(nom)
    super(nom, 100)
    @weapon_level = 1
  end

  def show_state
    "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6) #lancer aleatoire entre 1 et 6
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
    if new_weapon_level > @weapon_level
      puts "Youhou ! elle est meilleure que ton arme actuelle, tu la prends !"
        @weapon_level = new_weapon_level
    elsif new_weapon_level <= @weapon_level
        puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    dee = rand(1..6) #lancer aleatoire entre 1 et 6
    if dee == 1
      puts "Tu n'as rien trouvé..."
    elsif dee >= 2 && dee <= 5
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      @life_points = [@life_points + 50, 100].min #ne depasse pas 100 points de vie
    elsif dee == 6
      puts "Waow, tu as trouvé un pack de +80 points de vie !"   
      @life_points = [@life_points + 80, 100].min #ne dépasse pas 100 points de vie
    end
  end
  


end