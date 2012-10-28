class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notice] = "Already logged in as #{current_user.email_address}.  Please logout to login as another user."
      redirect_to root_url
    end
  end
  
  def create
    user = User.authenticate(params[:email_address], params[:password])
    if user
      session[:user_id] = user.id
      
      if !user.user_type.purchase
        redirect_to '/employee', :notice => "Logged in!"
      else
        redirect_to root_url, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    #if not logged in, redirect home.
    if(!@current_user)
      redirect_to root_url
      return
    end
    
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end