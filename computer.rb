# frozen_string_literal: true

# Class Computer is the NPC of the game.
class Computer
  attr_reader :marker

  include GameRules

  def initialize(attributes = {})
    @marker = attributes[:marker] || 'X'
    @player_marker = attributes[:player_marker] || 'O'
    @sleep_time = attributes[:sleep_time] || 0
    @difficulty = attributes[:difficulty] || 3
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
    puts "Computer #{@marker} is making it's move!" if @sleep_time.positive?
    puts "\nComputer #{@marker} made it's move!" if @sleep_time.zero?
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
      return evaluate(board, spot) if game_over(board) && @difficulty > 2

      board[spot.to_i] = @player_marker
      return evaluate(board, spot) if game_over(board) && @difficulty > 1

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
