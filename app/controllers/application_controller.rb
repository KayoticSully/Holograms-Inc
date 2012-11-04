class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  before_filter :get_keywords, :current_user

  #The search logic
  #currently only searches keywords and returns those categories
  #still needs to have the results returned to a page and the products of each dumped.
  def search
    @categories = search_keywords
  end

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
  
  #search keywords method for the search logic
  def search_keywords
    query = "%#{params[:query]}%"
    @result = Keyword.where("name LIKE ?",q).to_sql
  end
end
