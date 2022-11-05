require_relative 'game_rules'

class Computer
  attr_reader :marker

  def initialize(marker = 'X', player_marker)
    @marker = marker
    @player_marker = player_marker
  end

  def move(board)
    spot = nil
    until spot
      if board[4] == '4'
        spot = 4
      else
        spot = best_move(board, @marker)
        valid_move?(board, spot) ? spot : spot = nil
      end
    end
    spot
  end

  private

  def best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |spot|
      available_spaces << spot if spot != @marker && spot != @player_marker
    end
    available_spaces.each do |space|
      board[space.to_i] = @marker
      if game_over(board)
        best_move = space.to_i
        board[space.to_i] = space
        return best_move
      else
        board[space.to_i] = @player_marker
        if game_over(board)
          best_move = space.to_i
          board[space.to_i] = space
          return best_move
        else
          board[space.to_i] = space
        end
      end
    end

    return best_move if best_move

    n = rand(0..available_spaces.count)
    available_spaces[n].to_i
  end
end
