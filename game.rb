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

    return if game_over(@board)

    puts "\nIt's a tie!" if tie(@board)
  end

  private

  def play
    cycle_turns(@player_one)
    display_board unless @player_one.instance_of?(Player) && @player_two.instance_of?(Computer)
    @player_one.wins if game_over(@board)

    return display_board if game_over(@board) || tie(@board)

    cycle_turns(@player_two)
    display_board
    @player_two.wins if game_over(@board)
  end

  def cycle_turns(player)
    player.instance_of?(Player) ? player_turn(player) : computer_turn(player)
  end

  def player_turn(player)
    player.announce_turn
    spot = player.move(@board)
    @board[spot] = player.marker unless spot.nil? && spot != ''
  end

  def computer_turn(computer)
    computer.announce_turn
    spot = computer.move(@board) if !game_over(@board) && !tie(@board)
    @board[spot] = computer.marker unless spot.nil?
  end

  def game_mode(message = "\n")
    mode = display_options(message)

    return Computer.new({ difficulty: choose_difficulty }) if mode == '1'

    return Player.new({ name: 'Player Two', marker: 'X' }) if mode == '2'

    @player_one = Computer.new({ sleep_time: 1 }) if mode == '3'
    return Computer.new({ marker: 'O', player_marker: 'X', sleep_time: 1 }) if mode == '3'

    game_mode("\nInvalid option. ")
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

  def display_options(message)
    puts "#{message}Select the game mode:\n
1 - Player vs Computer
2 - Player vs Player
3 - Computer vs Computer"
    print '> '
    option = gets.chomp
    print `clear`
    option
  end

  def choose_difficulty(message = "\n")
    puts "#{message}Select the difficulty:\n
1 - Easy
2 - Normal
3 - Hard"
    print '> '
    difficulty = gets.chomp.to_i
    print `clear`
    [1, 2, 3].include?(difficulty) ? difficulty : choose_difficulty("\nInvalid option. ")
  end
end

game = Game.new
game.start_game
