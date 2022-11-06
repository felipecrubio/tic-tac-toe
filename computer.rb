class Computer
  attr_reader :marker

  include GameRules

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
    best_move = nil
    available_spots = []
    board.each do |spot|
      available_spots << spot if spot != @marker && spot != @player_marker
    end
    available_spots.each do |spot|
      board[spot.to_i] = @marker
      if game_over(board)
        best_move = spot.to_i
        board[spot.to_i] = spot
        return best_move
      else
        board[spot.to_i] = @player_marker
        if game_over(board)
          best_move = spot.to_i
          board[spot.to_i] = spot
          return best_move
        else
          board[spot.to_i] = spot
        end
      end
    end

    return best_move if best_move

    n = rand(0..available_spots.count)
    available_spots[n].to_i
  end

  def empty?
    self != @marker && self != @player_marker
  end
end
