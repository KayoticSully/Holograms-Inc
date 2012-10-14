class HelpItemsController < ApplicationController
  # GET /help_items
  # GET /help_items.json
  def index
    @help_items = HelpItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @help_items }
    end
  end

  # GET /help_items/1
  # GET /help_items/1.json
  def show
    @help_item = HelpItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @help_item }
    end
  end

  # GET /help_items/new
  # GET /help_items/new.json
  def new
    if(!@current_user || !@current_user.user_type_id.help_edit)
      redirect_to root_url
      return
    end
    
    @help_item = HelpItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @help_item }
    end
  end

  # GET /help_items/1/edit
  def edit
    if(!@current_user || !@current_user.user_type_id.help_edit)
      redirect_to root_url
      return
    end
    
    @help_item = HelpItem.find(params[:id])
  end

  # POST /help_items
  # POST /help_items.json
  def create
    if(!@current_user || !@current_user.user_type_id.help_edit)
      redirect_to root_url
      return
    end
    
    @help_item = HelpItem.new(params[:help_item])

    respond_to do |format|
      if @help_item.save
        format.html { redirect_to @help_item, notice: 'Help item was successfully created.' }
        format.json { render json: @help_item, status: :created, location: @help_item }
      else
        format.html { render action: "new" }
        format.json { render json: @help_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /help_items/1
  # PUT /help_items/1.json
  def update
    if(!@current_user || !@current_user.user_type_id.help_edit)
      redirect_to root_url
      return
    end
    
    @help_item = HelpItem.find(params[:id])

    respond_to do |format|
      if @help_item.update_attributes(params[:help_item])
        format.html { redirect_to @help_item, notice: 'Help item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @help_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /help_items/1
  # DELETE /help_items/1.json
  def destroy
    if(!@current_user || !@current_user.user_type_id.help_edit)
      redirect_to root_url
      return
    end
    
    @help_item = HelpItem.find(params[:id])
    @help_item.destroy

    respond_to do |format|
      format.html { redirect_to help_items_url }
      format.json { head :no_content }
    end
  end
end
