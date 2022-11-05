require_relative 'game_rules'

class Player
  attr_reader :marker

  def initialize(marker = 'O')
    @marker = marker
  end

  def move(board)
    spot = nil
    until spot
      spot = gets.chomp.to_i
      valid_move?(board, spot) ? board[spot] = @marker : spot = nil
    end
    spot
  end
end
