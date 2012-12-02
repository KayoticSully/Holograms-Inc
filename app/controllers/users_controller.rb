class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    #if not logged in OR user doesnt have permission to see user list redirect home
    if(!@current_user || !@current_user.user_type.users_list)
      redirect_to root_url
      return
    end
    
    @users = User.where('disabled != ?', true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #if not logged in OR user doesn't have user's list perm OR user id is not = to the param redirect home
    if(!@current_user || !@current_user.user_type.users_list || @current_user.id != Integer(params[:id]))
      redirect_to root_url
      return
    end
    
    @user = User.find(params[:id])
    #@user = User.where('disabled != true')
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    #if logged in, redirect home.
    if(@current_user)
      redirect_to root_url
      return
    end
    
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    #if not logged in OR user id does not match param redirect home
    if(!@current_user || (!@current_user.user_type.user_types_edit && @current_user.id != Integer(params[:id])))
      redirect_to root_url
      return
    end
    
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    #if logged in, redirect home.
    if(@current_user)
      redirect_to root_url
      return
    end
    
    @user = User.new(params[:user])

    respond_to do |format|
      #if user creation succeeds, redirect to login
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    #if not logged in or user id doesnt match param, redirect home
    if(!@current_user || !@current_user.user_type.user_types_edit)
      if(@current_user.id != Integer(params[:id]))
        redirect_to root_url
        return
      end
    end
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if @current_user.user_type.purchase
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to '/users', notice: 'User was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    #if not logged in or id doesnt match param, redirect home
    if(!@current_user || (!@current_user.user_type.user_types_edit && @current_user.id != Integer(params[:id])))
      redirect_to root_url
      return
    end
    
    @user = User.find(params[:id])
    #@user.destroy
    if(!@user.user_type.user_types_edit && @current_user.id != @user.id)
      @user.disabled = true
      @user.save
      
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully disabled." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User cannot be disabled." }
        format.json { head :no_content }
      end
    end

    
  end
end
