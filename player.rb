
class Player
  require_relative 'element'
  require_relative 'history'
  attr_reader :name, :history
  def initialize(name, history)
    @name = name
    @history = history
  end

  def play
    fail "This message should be overwritten"
  end
end

# Stupid Bot subclass definition

class StupidBot < Player
  def play
    move = Rock.new("Rock")
    @history.log_play(move)
    return move
  end
end

# Random Bot subclass definition
class RandomBot < Player
  def play
    possible_moves = [Rock.new("Rock"),
                      Paper.new("Paper"),
                      Scissors.new("Scissors"),
                      Lizard.new("Lizard"),
                      Spock.new("Spock")
                      ]
    selected_move = possible_moves.shuffle[0]
    @history.log_play(selected_move)
    return selected_move
    end
end

# Iterative Bot subclass definition
class IterativeBot < Player

  def initialize(name, history)
    super(name, history)
    @move_index = 0
  end

  def play
    possible_moves = [Rock.new("Rock"),
                      Paper.new("Paper"),
                      Scissors.new("Scissors"),
                      Lizard.new("Lizard"),
                      Spock.new("Spock")
                      ]
    if @move_index  > 4 then @move_index = 0 end
    current_move = possible_moves[@move_index]
    @history.log_play(current_move)
    @move_index += 1
    return current_move
  end
end


class LastPlayBot < Player
  def play
    if @history.opponent_plays.length == 0
      move = Rock.new("Rock")
    else
      move = @history.opponent_plays.last
    end

    @history.log_play(move)
    return move
  end
end


class Human < Player

  def get_input
    @valid_move = false
    while @valid_move === false
      puts "(1) Rock"
      puts "(2) Paper"
      puts "(3) Scissors"
      puts "(4) Lizard"
      puts "(5) Spock"
      print "Enter your move: "
      choice = gets.chomp
      if choice =~ /^\d$/ && choice.to_i.between?(1, 5)
        @valid_move = true
        break
      else
        puts "Invalid move - try again"
      end
    end
    return choice.to_i
  end

  def play
    choice = get_input
    possible_moves = [Rock.new("Rock"),
                      Paper.new("Paper"),
                      Scissors.new("Scissors"),
                      Lizard.new("Lizard"),
                      Spock.new("Spock")
    ]
    move = possible_moves[choice - 1]
    @history.log_play(move)
    return move
  end
end

#####################################################################################################################
# Local tests
#
# bot1 = RandomBot.new('RandomBot', History.new)
# bot2 = Human.new('Raul', History.new)
#
#
# (1..5).each { |i|
#   bot1move = bot1.play
#   bot2move = bot2.play
#   bot1.history.log_opponent_play(bot2move)
#   bot2.history.log_opponent_play(bot1move)
#   puts "RandomBot played #{bot1move.name}, Raul played #{bot2move.name}"
#   puts bot2move.compare_to(bot1move)
# }
