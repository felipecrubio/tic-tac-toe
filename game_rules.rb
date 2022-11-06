# frozen_string_literal: true

# Class GameRules defines the rules of the games
module GameRules
  def valid_move?(board, spot)
    board[spot] != 'X' && board[spot] != 'O'
  end

  def invalid_move
    puts "That's not a valid move. Try again."
    nil
  end

  def game_over(board)
    horizontal_rows(board) || vertical_rows(board) || diagonal_rows(board)
  end

  def horizontal_rows(board)
    board[0..2].uniq.length == 1 ||
      board[3..5].uniq.length == 1 ||
      board[6..8].uniq.length == 1
  end

  def vertical_rows(board)
    [board[0], board[3], board[6]].uniq.length == 1 ||
      [board[1], board[4], board[7]].uniq.length == 1 ||
      [board[2], board[5], board[8]].uniq.length == 1
  end

  def diagonal_rows(board)
    [board[0], board[4], board[8]].uniq.length == 1 ||
      [board[2], board[4], board[6]].uniq.length == 1
  end

  def tie(board)
    board.all? { |spot| spot == 'X' || spot == 'O' }
  end
end
