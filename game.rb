# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'

# Class Game is the main class of the game
class Game
  include GameRules

  def initialize
    @board = %w[0 1 2 3 4 5 6 7 8]
    @player_one = Player.new
    @player_two = ask_game_mode
  end

  def start_game
    display_board

    until game_over(@board) || tie(@board)
      play
      display_board
    end

    puts 'Game over'
  end

  private

  def ask_game_mode
    puts 'Enter 1 for single player or 2 for multiplayer:'
    mode = gets.chomp
    mode == '1' ? Computer.new('O') : Player.new('X')
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

  def play
    @player_one.instance_of?(Player) ? player_turn(@player_one) : computer_turn(@player_one)
    display_board if @player_two.instance_of?(Player)
    @player_two.instance_of?(Player) ? player_turn(@player_two) : computer_turn(@player_two)
  end

  def player_turn(player)
    spot = player.move(@board)
    @board[spot] = player.marker unless spot.nil?
  end

  def computer_turn(computer)
    spot = computer.move(@board) if !game_over(@board) && !tie(@board)
    @board[spot] = computer.marker unless spot.nil?
  end
end

game = Game.new
game.start_game
