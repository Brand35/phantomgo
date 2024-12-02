class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    # @item = Item.find(params[:id])
  end

  def play
    @game = Game.find(params[:id])
    # SI la case recherchée est vide alors ok, on joue:
    if @game.current_player == current_user
      if @game.board_state[params[:coordinates]].empty?
        puts "1"
        @game.board_state[params[:coordinates]] = params[:color]
        # et change vers le prochain joueur
        @game.toggle_player
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
    end
    # render json: { value: params[:color] }
    gid = "#{@game.to_gid_param}:#{@game.current_player.to_gid_param}"
    GameChannel.broadcast_to(gid, message: "A toi de jouer!")

    render json: { message: "ok, à l'autre de jouer" }
  end

  def pass
    @game = Game.find(params[:id])
    if @game.current_player == @game.black_player
      @game.update(current_player: @game.white_player)
    else
      @game.update(current_player: @game.black_player)
    end
    gid = "#{@game.to_gid_param}:#{@game.current_player.to_gid_param}"
    GameChannel.broadcast_to(gid, message: "A toi de jouer!")
   
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
