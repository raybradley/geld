class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_family = current_family
  end
end
