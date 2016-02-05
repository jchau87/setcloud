class HomeController < ApplicationController
  before_filter :initialize_client

  def index
    begin 
      if active_soundcloud_session?
        redirect_to "/app" and return
      end
    rescue Exception => ex
      # TODO: log error
    end

    @authorize_url = @client.authorize_url
  end

  def app
    
  end

  protected

  def active_soundcloud_session?
    session[:token] && Soundcloud.new(:access_token => session[:token]["access_token"]).get("/me")
  end

end
