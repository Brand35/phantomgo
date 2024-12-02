class Game < ApplicationRecord
  belongs_to :black_player, class_name: "User"
  belongs_to :white_player, class_name: "User"
  belongs_to :current_player, class_name: "User"

  after_create :initialize_board_state
  def toggle_player
    if current_player == white_player
      self.current_player = black_player
    else
      self.current_player = white_player
    end
  end

  private

  def initialize_board_state
    self.board_state = {}
    ("A".."F").to_a.each do |col|
      (1..6).to_a.each do |row|
        board_state["#{col}#{row}"] = ""
      end
    end
    save
  end
end
