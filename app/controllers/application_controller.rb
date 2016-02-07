class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def initialize_client
    access_token = params[:access_token] || session[:token].try(:[], "access_token")
    options = { access_token: access_token } if access_token

    options ||= {
      client_id: SC_CLIENT_ID,
      client_secret: SC_SECRET,
      redirect_uri: "http://#{request.host_with_port}/soundcloud/callback"
    }

    @client = Soundcloud.new options
  end

  def active_soundcloud_session?
    return false unless session[:token]

    client = @client || Soundcloud.new(:access_token => session[:token].try(:[],"access_token"))
    client.get("/me") rescue false
  end

  def require_active_soundcloud_session
    unless active_soundcloud_session?
      session[:token] = nil
      redirect_to "/" and return
    end
  end
end
