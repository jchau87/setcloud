class HomeController < ApplicationController
  before_filter :initialize_client

  def index
    @authorize_url = @client.authorize_url
  end

end
