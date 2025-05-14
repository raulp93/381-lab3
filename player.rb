require_relative 'element'
require_relative 'history'

# This Player class is serve as the base superclass for the rest of the player classes
class Player
  attr_reader :name, :history
  def initialize(name, history)
    @name = name
    @history = history
  end

  def play
    fail "This message should be overwritten"
  end
end

# The rest of the file below contains class definitions for each different type
# of player that a user can choose
# Note that $moves is a global array defined in element.rb that contains
# each move-object (rock, paper,scissors, etc...)

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
    selected_move = $moves.sample
    @history.log_play(selected_move)
    return selected_move
    end
end

# Iterative Bot subclass definition
class IterativeBot < Player

  def initialize(name, history)
    super(name, history)
    # used to keep track of which move ($moves[0-4]) is next to play
    @move_index = 0
  end

  def play
    # once move_index surpasses the valid range, it gets reset to 0
    if @move_index  > 4 then @move_index = 0 end
    move = $moves[@move_index]
    @history.log_play(move)
    @move_index += 1
    return move
  end
end


class LastPlayBot < Player
  def play
    # history.opponent_plays is an array that gets updated during each round
    # It will be empty in the first round.
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
      # I used gets.chomp instead of gets.to_i so that I can properly validate the user input.

      # The use of gets.to_i would typecast any letters or decimals to an integer, effectively
      # allowing bad inputs to slip through
      choice = gets.chomp
      # This checks whether the input is a single digit between 1 and 5.
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
    # $moves is the list of objects for each possible move
    move = $moves[choice - 1]
    @history.log_play(move)
    return move
  end
end
