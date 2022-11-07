# frozen_string_literal: true

# Class Computer is the NPC of the game.
class Computer
  attr_reader :marker

  include GameRules

  def initialize(player_marker, marker = 'X', sleep_time = 0)
    @marker = marker
    @player_marker = player_marker
    @sleep_time = sleep_time
  end

  def move(board)
    sleep(@sleep_time)
    spot = nil
    until spot
      spot = 4 if board[4] == '4'

      spot = best_move(board)
      valid_move?(board, spot) ? spot : spot = nil
    end
    spot
  end

  def announce_turn
    puts "Computer #{@marker} is making it's move!"
  end

  def wins
    puts "Computer #{@marker} wins!"
  end

  private

  def best_move(board, _depth = 0, _best_score = {})
    available_spots = map_available_spots(board)
    best_move = calculate_best_move(board, available_spots)

    return best_move if best_move

    random_move(available_spots)
  end

  def calculate_best_move(board, available_spots)
    available_spots.each do |spot|
      board[spot.to_i] = @marker
      return evaluate(board, spot) if game_over(board)

      board[spot.to_i] = @player_marker
      return evaluate(board, spot) if game_over(board)

      board[spot.to_i] = spot
    end
    nil
  end

  def map_available_spots(board)
    available_spots = []
    board.each do |spot|
      available_spots << spot if available?(spot)
    end
    available_spots
  end

  def available?(spot)
    spot != @marker && spot != @player_marker
  end

  def evaluate(board, spot)
    best_move = spot.to_i
    board[spot.to_i] = spot
    best_move
  end

  def random_move(available_spots)
    number = rand(0..available_spots.count)
    available_spots[number].to_i
  end
end
