class HomeController < ApplicationController
  def index
    redirect_to "/keywords/promoted"
  end
end
