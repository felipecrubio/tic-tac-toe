# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'
require_relative 'game_rules'

# Class Game is the main class of the game
class Game
  def initialize
    @board = %w[0 1 2 3 4 5 6 7 8]
    # @computer_marker = 'X' # the computer's marker
    @player = Player.new
    @computer = Computer.new('O')
  end

  def start_game
    # start by printing the board
    display_board

    # loop through until the game was won or tied
    until game_over(@board) || tie(@board)
      player_turn
      computer_turn
      display_board
    end
    puts 'Game over'
  end

  def display_board
    puts "
 #{@board[0]} | #{@board[1]} | #{@board[2]}
===+===+===
 #{@board[3]} | #{@board[4]} | #{@board[5]}
===+===+===
 #{@board[6]} | #{@board[7]} | #{@board[8]}
    "
    puts 'Enter [0-8]:'
  end

  private

  def player_turn
    spot = @player.move(@board)
    @board[spot] = @player.marker unless spot.nil?
  end

  def computer_turn
    spot = @computer.move(@board) if !game_over(@board) && !tie(@board)
    @board[spot] = @computer.marker unless spot.nil?
  end

  # def human_turn
  #   spot = nil
  #   until spot
  #     spot = gets.chomp.to_i
  #     valid_move?(@board, spot) ? @board[spot] = @human_marker : spot = nil
  #   end
  # end

  # def computer_turn
  #   spot = nil
  #   until spot
  #     if @board[4] == '4'
  #       spot = 4
  #       @board[spot] = @computer_marker
  #     else
  #       spot = best_move(@board, @computer_marker)
  #       valid_move?(spot) ? @board[spot] = @computer_marker : spot = nil
  #     end
  #   end
  # end

  # def best_move(board, next_player, depth = 0, best_score = {})
  #   available_spaces = []
  #   best_move = nil
  #   board.each do |spot|
  #     available_spaces << spot if spot != @computer_marker && spot != @human_marker
  #   end
  #   available_spaces.each do |space|
  #     board[space.to_i] = @computer_marker
  #     if game_over(board)
  #       best_move = space.to_i
  #       board[space.to_i] = space
  #       return best_move
  #     else
  #       board[space.to_i] = @human_marker
  #       if game_over(board)
  #         best_move = space.to_i
  #         board[space.to_i] = space
  #         return best_move
  #       else
  #         board[space.to_i] = space
  #       end
  #     end
  #   end

  #   return best_move if best_move

  #   n = rand(0..available_spaces.count)
  #   available_spaces[n].to_i
  # end

  # def game_over(board)
  #   [board[0], board[1], board[2]].uniq.length == 1 ||
  #   [board[3], board[4], board[5]].uniq.length == 1 ||
  #   [board[6], board[7], board[8]].uniq.length == 1 ||
  #   [board[0], board[3], board[6]].uniq.length == 1 ||
  #   [board[1], board[4], board[7]].uniq.length == 1 ||
  #   [board[2], board[5], board[8]].uniq.length == 1 ||
  #   [board[0], board[4], board[8]].uniq.length == 1 ||
  #   [board[2], board[4], board[6]].uniq.length == 1
  # end

  # def tie(board)
  #   board.all? { |s| s == @computer_marker || s == @human_marker }
  # end

  # private

  # def valid_move?(spot)
  #   @board[spot] != @computer_marker && @board[spot] != @human_marker
  # end

  # def mark_spot(marker)

  # end
end

game = Game.new
game.start_game
