class SoundcloudController < ApplicationController
  before_filter :initialize_client
  before_filter :require_active_soundcloud_session, except: :callback
  respond_to :html, :json

  def callback
    code = params[:code]

    access_token = @client.exchange_token(code: code)
    session[:token] = access_token.as_json    

    redirect_to "/app/playlists"
  end

  def playlists
    @playlists = @client.get("/me/playlists")

    likes = {
      title: "Likes",
      id: "likes",
      is_likes: true,
      tracks: @client.get("/me/favorites").as_json
    }

    @playlists.push(Hashie::Mash.new likes)

    @playlists_json_api = {
      data: @playlists.map do |pl|
        {
          type: "playlists",
          id: pl.id,
          attributes: pl.as_json
        }
      end
    }

    respond_with @playlists_json_api
  end

  def playlist
    id = params[:id]
    @playlist = @client.get("/playlists/#{id}")

    @playlist_json_api = {
      data: {
        type: "playlists",
        id: @playlist.id,
        attributes: @playlist.as_json
      }
    }

    respond_with @playlist_json_api
  end

  def likes
    @likes = @client.get("/me/favorites")

    @likes_json_api = {
      data: {
        type: "playlists",
        id: "likes",
        attributes: @likes.as_json
      }
    }  
    respond_with @likes_json_api
  end

end
