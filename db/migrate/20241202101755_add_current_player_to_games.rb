class AddCurrentPlayerToGames < ActiveRecord::Migration[7.2]
  def change
    add_reference :games, :current_player, null: false, foreign_key: { to_table: :users }
  end
end
