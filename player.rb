# frozen_string_literal: true

require_relative 'game_rules'

# Class Player is the human player of the game.
class Player
  attr_reader :marker

  include GameRules
  # name = 'Player One', marker = 'O'
  def initialize(attributes = {})
    @name = attributes[:name] || 'Player One'
    @marker = attributes[:marker] || 'O'
    ask_name
  end

  def move(board)
    spot = nil
    until spot
      spot = ask_for_move
      valid_move?(board, spot) ? board[spot] = @marker : spot = invalid_move
    end
    spot
  end

  def announce_turn
    puts "#{@name}, it's your turn! Enter [0-8]:"
    print '> '
  end

  def wins
    puts "\n#{@name} wins!"
  end

  private

  def ask_name
    puts "\nYou are playing as #{@marker}.
Type your name or press Enter to go as #{@name}:"
    print '> '
    name = gets.chomp
    @name = name unless name == ''
  end

  def ask_for_move
    spot = gets.chomp
    until spot.match?(/[0-8]/)
      invalid_move
      spot = gets.chomp
    end
    spot.to_i
  end
end
