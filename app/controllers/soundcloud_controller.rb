class SoundcloudController < ApplicationController
  before_filter :initialize_client

  def callback
    code = params[:code]

    access_token = @client.exchange_token(code: code)
    session[:token] = access_token.as_json

    redirect_to "/app"
  end
end
