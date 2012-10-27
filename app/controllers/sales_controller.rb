class SalesController < ApplicationController
  
  layout "employee"
  
  # GET /sales
  # GET /sales.json
  def index
    #if not logged in OR user doesnt have permission to edit sales, redirect home
    if(!@current_user || !@current_user.user_type.sales_edit)
      redirect_to root_url
      return
    end
    
    @sales = Sale.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sales }
    end
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
    #if not logged in OR user doesnt have permission to edit sales, redirect home
    if(!@current_user || !@current_user.user_type.sales_edit)
      redirect_to root_url
      return
    end
    
    @sale = Sale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sale }
    end
  end

  # GET /sales/new
  # GET /sales/new.json
  def new
    #if not logged in OR user doesnt have permission to edit sales, redirect home
    if(!@current_user || !@current_user.user_type.sales_edit)
      redirect_to root_url
      return
    end
    
    @sale = Sale.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sale }
    end
  end

  # GET /sales/1/edit
  def edit
    #if not logged in OR user doesnt have permission to edit sales, redirect home
    if(!@current_user || !@current_user.user_type.sales_edit)
      redirect_to root_url
      return
    end
    
    @sale = Sale.find(params[:id])
  end

  # POST /sales
  # POST /sales.json
  def create
    #if not logged in OR user doesnt have permission to edit sales, redirect home
    if(!@current_user || !@current_user.user_type.sales_edit)
      redirect_to root_url
      return
    end
    
    @sale = Sale.new(params[:sale])

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render json: @sale, status: :created, location: @sale }
      else
        format.html { render action: "new" }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sales/1
  # PUT /sales/1.json
  def update
    #if not logged in OR user doesnt have permission to edit sales, redirect home
    if(!@current_user || !@current_user.user_type.sales_edit)
      redirect_to root_url
      return
    end
    
    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    #if not logged in OR user doesnt have permission to edit sales, redirect home
    if(!@current_user || !@current_user.user_type.sales_edit)
      redirect_to root_url
      return
    end
    
    @sale = Sale.find(params[:id])
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to sales_url }
      format.json { head :no_content }
    end
  end
end
