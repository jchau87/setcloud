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

    @playlists.insert(0, Hashie::Mash.new(likes))

    @playlists.each do |playlist|
      playlist.tracks.each do |track|
        track.artwork_url = track.artwork_url.gsub(/large/, "t500x500")
      end
    end

    @playlists_json_api = {
      data: @playlists.map do |pl|
        {
          type: "playlist",
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

    @playlist.tracks.each do |track|
      track.artwork_url = track.artwork_url.gsub(/large/, "t500x500")
    end

    @playlist_json_api = {
      data: {
        type: "playlist",
        id: @playlist.id,
        attributes: @playlist.as_json
      }
    }

    respond_with @playlist_json_api
  end

  def update_playlist
    id = params[:id]    
    
    tracks = params[:data][:attributes][:tracks]
    if tracks.select{|t| t[:id] == tracks.last[:id]}.length < 2
      @playlist = @client.put("/playlists/#{id}", { playlist: { tracks: tracks } })
    else
      @playlist = @client.get("/playlists/#{id}")
    end

    @playlist.tracks.each do |track|
      track.artwork_url = track.artwork_url.gsub(/large/, "t500x500")
    end

    @playlist_json_api = {
      data: {
        type: "playlist",
        id: @playlist.id,
        attributes: @playlist.as_json
      }
    }

    render json: @playlist_json_api
  end

  def likes
    @likes = @client.get("/me/favorites")

    @likes.each do |like|
      like.artwork_url = like.artwork_url.gsub(/large/, "t500x500")
    end

    @likes_json_api = {
      data: {
        type: "playlist",
        id: "likes",
        attributes: @likes.as_json
      }
    }  
    respond_with @likes_json_api
  end

end
