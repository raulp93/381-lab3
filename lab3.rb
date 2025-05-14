require_relative "element"   # uncomment to load element.rb
require_relative "player"    # uncomment to load player.rb
require_relative "history"   # uncomment to load history.rb

#####################################
#     CS 381 - Programming Lab #3		#
#																		#
#  Raul Preciado                    #
#  preciadr@oregonstate.edu         #
#										                #
#####################################



def choose_players
	puts "Please choose two players:"
	puts "(1) StupidBot"
	puts "(2) RandomBot"
	puts "(3) IterativeBot"
	puts "(4) LastPlayBot"
	puts "(5) Human"

	choices = %w[StupidBot RandomBot IterativeBot LastPlayBot Human]
	while true
		print "Select player 1: "
		choice1 = gets.chomp
		print "Select player 2: "
		choice2 = gets.chomp
		# Here we validate the inputs.
		if (choice1 =~ /^\d$/ && choice1.to_i.between?(1, 5)) &&
			(choice2 =~ /^\d$/ && choice2.to_i.between?(1, 5))
			break
		else
			puts "Invalid choice(s) - start over\n\n"
		end

	end
	name_1 = choices[choice1.to_i - 1]
	name_2 = choices[choice2.to_i - 1]
	# Here we use strings that are the class names for the type of player chosen
	# to create new objects of each and assign them to player_1 and player_2 respectively
	player1 = Object.const_get(name_1).new(name_1, History.new)
	player2 = Object.const_get(name_2).new(name_2, History.new)
	puts "#{player1.name} vs. #{player2.name}"
	return player1, player2
end

def decide_round(player_1, player_2, round_results)
	puts round_results[0]

	case round_results[1]
		when "Tie"
			puts "Round was a tie"

		when "Win"
		puts "Player 1 won the round"
		player_1.history.add_score

		when "Lose"
		puts "Player 2 won the round"
		player_2.history.add_score
		else
			puts "Error: something went wrong"
	end
end


def decide_winner(player_1, player_2)
	player_1_score = player_1.history.score
	player_2_score = player_2.history.score
	puts "\nFinal score is #{player_1_score} to #{player_2_score}"

	if player_1_score > player_2_score
		puts "Player 1 wins"
	elsif player_2_score > player_1_score
		puts "Player 2 wins"
	else
		puts "Game was a draw"
	end
end


def game(rounds)
	puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!\n\n"
	player_1, player_2 = choose_players
	@count = 1
	rounds.times do
		puts "\nRound #{@count}:"
		# The .play method will create an object of a move so that we may
		# call .compare_to in order to see who wins the round.
		player_1_move = player_1.play
		player_2_move = player_2.play
		player_1.history.log_opponent_play(player_2_move)
		player_2.history.log_opponent_play(player_1_move)
		puts "Player 1 chose #{player_1_move.name}"
		puts "Player 2 chose #{player_2_move.name}"
		result = player_1_move.compare_to(player_2_move)
		decide_round(player_1, player_2, result)
		@count += 1
	end
	decide_winner(player_1, player_2)
end


# Main Program (should be last)
n_rounds = 5
# call to kick off the game
game(n_rounds)
