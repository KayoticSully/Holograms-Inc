class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  before_filter :get_keywords, :current_user

  private
  
  def get_keywords
	@keywords = Keyword.all
	@keywords.sort! { |a, b| a.name <=> b.name }
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
