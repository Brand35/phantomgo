class Game < ApplicationRecord
  belongs_to :black_player, class_name: "User"
  belongs_to :white_player, class_name: "User"
  after_create :initialize_board_state

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
