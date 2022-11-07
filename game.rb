# frozen_string_literal: true

require_relative 'player'
require_relative 'computer'

# Class Game is the main class of the game
class Game
  include GameRules

  def initialize
    @board = %w[0 1 2 3 4 5 6 7 8]
    @player_one = Player.new
    @player_two = game_mode
  end

  def start_game
    display_board

    play until game_over(@board) || tie(@board)

    puts "It's a tie!" if tie(@board)
  end

  private

  def game_mode(message = "\nSelect the game mode:\n")
    mode = display_options(message)

    return Computer.new('O') if mode == '1'

    return Player.new('Player Two', 'X') if mode == '2'

    @player_one = Computer.new('X', 'O', 1) if mode == '3'
    return Computer.new('O', 'X', 1) if mode == '3'

    game_mode("\nInvalid option. Select the game mode:\n")
  end

  def display_options(message)
    puts "#{message}
1 - Player vs Computer
2 - Player vs Player
3 - Computer vs Computer"
    print '> '
    gets.chomp
  end

  def display_board
    puts "
 #{@board[0]} | #{@board[1]} | #{@board[2]}
===+===+===
 #{@board[3]} | #{@board[4]} | #{@board[5]}
===+===+===
 #{@board[6]} | #{@board[7]} | #{@board[8]}
    "
  end

  def play
    @player_one.instance_of?(Player) ? player_turn(@player_one) : computer_turn(@player_one)
    display_board
    return @player_one.wins if game_over(@board)

    return if game_over(@board) || tie(@board)

    @player_two.instance_of?(Player) ? player_turn(@player_two) : computer_turn(@player_two)
    display_board
    @player_two.wins if game_over(@board)
  end

  def player_turn(player)
    player.announce_turn
    spot = player.move(@board)
    @board[spot] = player.marker unless spot.nil?
  end

  def computer_turn(computer)
    computer.announce_turn
    spot = computer.move(@board) if !game_over(@board) && !tie(@board)
    @board[spot] = computer.marker unless spot.nil?
  end
end

game = Game.new
game.start_game
