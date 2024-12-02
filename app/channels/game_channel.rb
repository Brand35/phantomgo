class GameChannel < ApplicationCable::Channel
  def subscribed
    game = Game.find(params[:game_id])
    user = User.find(params[:user_id])
    stream_from "game:#{game.to_gid_param}:#{user.to_gid_param}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
