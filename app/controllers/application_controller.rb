class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def initialize_client
    options = { access_token: params[:access_token] } if params[:access_token]

    options ||= {
      client_id: SC_CLIENT_ID,
      client_secret: SC_SECRET,
      redirect_uri: 'http://#{host_with_port}/soundcloud/callback'
    }

    @client = Soundcloud.new options
  end
end
