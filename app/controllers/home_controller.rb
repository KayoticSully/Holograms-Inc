class HomeController < ApplicationController
  
#  layout "employee", :only => [:employee]
  
  def index
    #redirect_to "/keywords/promoted"
  end
  
  def about
    
  end
  
  def employee
    if(!@current_user || @current_user.user_type.purchase)
      redirect_to root_url
      return
    end
  end
end
