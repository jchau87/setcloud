class SoundcloudController < ApplicationController
  before_filter :initialize_client
  respond_to :html, :json

  def callback
    code = params[:code]

    access_token = @client.exchange_token(code: code)
    session[:token] = access_token.as_json

    redirect_to "/app"
  end

  def playlists
    @playlists = @client.get("/me/playlists")
    respond_with @playlists
  end

  def likes
    @likes = @client.get("/me/favorites")
    respond_with @likes
  end

end
