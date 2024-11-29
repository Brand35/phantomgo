class GamesController < ApplicationController
  def play
    @game = Game.find(params[:id])
    # SI la case recherchée est vide alors ok, on joue:
    if @game.board_state[params[:coordinates]].empty?
      puts "1"
      @game.board_state[params[:coordinates]] = params[:color]
      @game.save!
    elsif @game.board_state[params[:coordinates]] == params[:color]
      puts "2"
      # SINON SI la case recherchée est de la couleur du joueur "Tu as déjà une pierre ici"
      flash[:alert] = "Tu as déjà une pierre ici"
    else
      puts "3"
      flash[:alert] = "COUP IMPOSSIBLE. Pierre de la couleur opposée présente"
      # SINON (il y a une pierre de la couleur opposée): "COUP IMPOSSIBLE. Pierre de la couleur opposée présente"
    end
    # render json: { value: params[:color] }
    redirect_to game_path(@game)
  end

  def show
    # @item = Item.find(params[:id])
    @game = Game.find(params[:id])
  end
end
#  2 mettre une  data-value a mon controller stimulus (params id )
#  3 je recupere l' id dans ma methode
#
# plateau =
#        A   B   C   D   E   F
#  6 # ["", "", "", "", "", ""]
#  5 # ["", "", "", "", "", ""]
#  4 # ["", "", "", "", "", ""]
#  3 # ["", "", "", "", "", ""]
#  2 # ["", "", "", "", "", ""]
#  1 # ["", "", "", "", "", ""]
#        A   B   C   D   E   F
