class KeywordsController < ApplicationController
  # GET /keywords
  # GET /keywords.json
  def index
    #if not logged in or cannot edit keywords, redirect home
    if(!@current_user || !@current_user.user_type.keywords_edit)
      redirect_to root_url
      return
    end
    
    @keywords = Keyword.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keywords }
    end
  end

  # GET /keywords/1
  # GET /keywords/1.json
  def show
    save_location
    
    #The search logic
    #currently only searches keywords and returns those categories
    #still needs to have the results returned to a page and the products of each dumped
    if(params[:query])
      # will move search logic to helper
      # it is just here for now
      query = "%#{params[:query]}%"
      keywordArr = Keyword.where("name LIKE ?", query)
      @keyword = keywordArr[0]
      
      # if no results go home
      if(@keyword == nil)
        # this does not work?? why?
        flash[:notice] = 'No search results were found'
        redirect_to root_url
      end
    else
      keywordArr = Keyword.find(:all, :conditions => ["lower(name) =?", params[:id].gsub("_", " ").downcase])
      @keyword = keywordArr[0]
      @products = @keyword.products.select{|product| product.public}
      end
    end
  end

  # GET /keywords/new
  # GET /keywords/new.json
  def new
    #if not logged in or cannot edit keywords, redirect home
    if(!@current_user || !@current_user.user_type.keywords_edit)
      redirect_to root_url
      return
    end
    
    @keyword = Keyword.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @keyword }
    end
  end

  # GET /keywords/1/edit
  def edit
    #if not logged in or cannot edit keywords, redirect home
    if(!@current_user || !@current_user.user_type.keywords_edit)
      redirect_to root_url
      return
    end
    
    @keyword = Keyword.find(params[:id])
  end

  # POST /keywords
  # POST /keywords.json
  def create
    #if not logged in or cannot edit keywords, redirect home
    if(!@current_user || !@current_user.user_type.keywords_edit)
      redirect_to root_url
      return
    end
    
    @keyword = Keyword.new(params[:keyword])

    respond_to do |format|
      if @keyword.save
        format.html { redirect_to @keyword, notice: 'Keyword was successfully created.' }
        format.json { render json: @keyword, status: :created, location: @keyword }
      else
        format.html { render action: "new" }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /keywords/1
  # PUT /keywords/1.json
  def update
    #if not logged in or cannot edit keywords, redirect home
    if(!@current_user || !@current_user.user_type.keywords_edit)
      redirect_to root_url
      return
    end
    
    @keyword = Keyword.find(params[:id])

    respond_to do |format|
      if @keyword.update_attributes(params[:keyword])
        format.html { redirect_to @keyword, notice: 'Keyword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
    #if not logged in or cannot edit keywords, redirect home
    if(!@current_user || !@current_user.user_type.keywords_edit)
      redirect_to root_url
      return
    end
    
    @keyword = Keyword.find(params[:id])
    @keyword.destroy

    respond_to do |format|
      format.html { redirect_to keywords_url }
      format.json { head :no_content }
    end
  end
end
