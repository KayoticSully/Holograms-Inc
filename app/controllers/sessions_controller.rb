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
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
