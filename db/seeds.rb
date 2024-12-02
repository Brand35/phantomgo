Game.destroy_all
# User.destroy_all

# noir = User.create!(email: "noir@gmail.com", password: "123456")

# blanc = User.create!(email: "blanc@gmail.com", password: "123456")

# Game.create!(
#   black_player: noir,
#   white_player: blanc,
#   current_player: noir)
#
Game.create!(
  black_player: User.first,
  white_player: User.last,
  current_player: User.first)
