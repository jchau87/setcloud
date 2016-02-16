class HomeController < ApplicationController
  before_filter :log_action
  before_filter :initialize_client, except: :test
  before_filter :require_active_soundcloud_session, only: :app

  def index 
    if active_soundcloud_session?
      redirect_to "/app/" and return
    else
      session[:token] = nil
      initialize_client
    end

    @authorize_url = @client.authorize_url
  end

  def app
  end

  def test    
  end

end
