class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  before_filter :get_keywords, :current_user

  private
  #set the keywords variable for the categories list
  def get_keywords
	@keywords = Keyword.all
	@keywords.sort! { |a, b| a.name <=> b.name }
  end
  
  #set the variable @current_user based on the session.
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def save_location
    if session.present?
      session[:last_location] = request.url
    end
  end
end
