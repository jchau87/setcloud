class HomeController < ApplicationController
  before_filter :log_action
  before_filter :initialize_client, except: :test
  before_filter :require_active_soundcloud_session, only: :app

  def index
    begin 
      if active_soundcloud_session?
        redirect_to "/app/" and return
      end
    rescue Exception => ex
      # TODO: log error
    end

    @authorize_url = @client.authorize_url
  end

  def app
    puts session[:token]["access_token"]
  end

  def test
    
  end

end
