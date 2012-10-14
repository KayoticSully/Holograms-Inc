class ProductsController < ApplicationController
  
  layout "employee", :only => :index
  
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
#	I think this is bad…. don't hate me shane if i mess this up 
#	@keyword = Keyword.find(2)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    if(!@current_user || !@current_user.user_type_id.products_edit)
      redirect_to root_url
      return
    end
    
    @product = Product.new
    #@keywords = Keyword.

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    if(!@current_user || !@current_user.user_type_id.products_edit)
      redirect_to root_url
      return
    end
    
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    if(!@current_user || !@current_user.user_type_id.products_edit)
      redirect_to root_url
      return
    end
    
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    if(!@current_user || !@current_user.user_type_id.products_edit)
      redirect_to root_url
      return
    end
    
    @product = Product.find(params[:id])
    
    # set keywords selected
    @product.keywords = Keyword.find(params[:keyword_ids])
    
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if(!@current_user || !@current_user.user_type_id.products_edit)
      redirect_to root_url
      return
    end
    
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
