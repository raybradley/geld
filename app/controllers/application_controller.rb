class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_family
    current_user.family
  end
end
