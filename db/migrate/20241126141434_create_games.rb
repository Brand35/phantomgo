class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.jsonb :board_state
      t.references :black_player, index: true, foreign_key: { to_table: :users }
      t.references :white_player, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
