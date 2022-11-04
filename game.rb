# frozen_string_literal: true

# Class Game is the main class of the game
class Game
  def initialize
    @board = %w[0 1 2 3 4 5 6 7 8]
    @com = 'X' # the computer's marker
    @hum = 'O' # the user's marker
  end

  def start_game
    # start by printing the board
    show_board

    # loop through until the game was won or tied
    until game_over(@board) || tie(@board)
      human_spot

      eval_board if !game_over(@board) && !tie(@board)

      show_board
    end
    puts 'Game over'
  end

  def show_board
    puts "
 #{@board[0]} | #{@board[1]} | #{@board[2]}
===+===+===
 #{@board[3]} | #{@board[4]} | #{@board[5]}
===+===+===
 #{@board[6]} | #{@board[7]} | #{@board[8]}
    "
    puts 'Enter [0-8]:'
  end

  def human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if @board[spot] != 'X' && @board[spot] != 'O'
        @board[spot] = @hum
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == '4'
        spot = 4
        @board[spot] = @com
      else
        spot = best_move(@board, @com)
        if @board[spot] != 'X' && @board[spot] != 'O'
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @com
      if game_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end

    return best_move if best_move

    n = rand(0..available_spaces.count)
    available_spaces[n].to_i
  end

  def game_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == 'X' || s == 'O' }
  end
end

game = Game.new
game.start_game
