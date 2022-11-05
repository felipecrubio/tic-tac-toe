def valid_move?(board, spot)
  board[spot] != 'X' && board[spot] != 'O'
end

def game_over(board)
  [board[0], board[1], board[2]].uniq.length == 1 ||
  [board[3], board[4], board[5]].uniq.length == 1 ||
  [board[6], board[7], board[8]].uniq.length == 1 ||
  [board[0], board[3], board[6]].uniq.length == 1 ||
  [board[1], board[4], board[7]].uniq.length == 1 ||
  [board[2], board[5], board[8]].uniq.length == 1 ||
  [board[0], board[4], board[8]].uniq.length == 1 ||
  [board[2], board[4], board[6]].uniq.length == 1
end

def tie(board)
  board.all? { |s| s == 'X' || s == 'O' }
end
