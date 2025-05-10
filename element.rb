
class Element
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def compare_to(element)
    fail "This message should be overwritten"
  end

end


class Rock < Element

  def compare_to(element)
    case element.name
    when @name
      return "Rock equals Rock", "Tie"

    when "Paper"
      return "Paper covers Rock", "Lose"

    when "Scissors"
      return "Rock crushes Scissors", "Win"

    when "Lizard"
      return "Rock crushes Lizard", "Win"

    when "Spock"
      return "Spock vaporizes Rock", "Lose"

    else
      return "Error: #{element.name} is not recognized."
    end
  end
end


class Paper < Element

  def compare_to(element)
    case element.name
    when @name
      return "Paper equals Paper", "Tie"

    when "Rock"
      return "Paper covers Rock", "Win"

    when "Scissors"
      return "Scissors cut Paper", "Lose"

    when "Lizard"
      return "Lizard eats Paper", "Lose"

    when "Spock"
      return "Paper disproves Spock", "Win"

    else
      return "Error: #{element.name} is not recognized."
    end
  end
end


class Scissors < Element

  def compare_to(element)
    case element.name
    when @name
      return "Scissors equals Scissors", "Tie"

    when "Paper"
      return "Scissors cut Paper", "Win"

    when "Rock"
      return "Rock crushes Scissors", "Lose"

    when "Lizard"
      return "Scissors decapitate Lizard", "Win"

    when "Spock"
      return "Spock smashes scissors", "Lose"

    else
      return "Error: #{element.name} is not recognized."
    end
  end
end


class Lizard < Element

  def compare_to(element)
    case element.name
    when @name
      return "Lizard equals Lizard", "Tie"

    when "Paper"
      return "Lizard eats Paper", "Win"

    when "Rock"
      return "Rock crushes Lizard", "Lose"

    when "Scissors"
      return "Scissors decapitate Lizard", "Lose"

    when "Spock"
      return "Lizard poisons Spock", "Win"

    else
      return "Error: #{element.name} is not recognized."
    end
  end
end


class Spock < Element

  def compare_to(element)
    case element.name
    when @name
      return "Spock equals Spock", "Tie"

    when "Paper"
      return "Paper disproves Spock", "Lose"

    when "Rock"
      return "Spock vaporizes Rock", "Win"

    when "Scissors"
      return "Spock smashes Scissors", "Win"

    when "Lizard"
      return "Lizard poisons Spock", "Lose"

    else
      return "Error: #{element.name} is not recognized."
    end
  end
end

rock = Rock.new("Rock")
paper = Paper.new("Paper")
scissors = Scissors.new("Scissors")
lizard = Lizard.new("Lizard")
spock = Spock.new("Spock")
$moves = [rock, paper, scissors, lizard, spock]