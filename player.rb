
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


class StupidBot < Player
  def play
    move = Rock.new("Rock")
    @history.log_play(move)
    return move
  end
end


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


# Local tests
#
bot1 = StupidBot.new('StupidBot', History.new)
bot2 = IterativeBot.new('IterativeBot', History.new)



(1..10).each { |i|
  bot1move = bot1.play
  bot2move = bot2.play
  puts bot2move.compare_to(bot1move)
}
