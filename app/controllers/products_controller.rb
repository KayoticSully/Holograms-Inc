class ProductsController < ApplicationController
  
#  layout "employee", :only => [:index, :edit]
  
 # GET /products
  # GET /products.json
  def index
    if(params[:query])
      terms = params[:query].split
      query = Array.new
      base_query = "name LIKE ?"
      
      if(terms.size == 1)
        query = "%#{terms[0]}%"
        @products = Product.where(base_query, query)
      else
        i = 1
        until(i == terms.size)
          base_query += " OR name LIKE ?"
          i += 1
        end
        
        query = terms.collect!{|t| "'%#{t}%'"}
        terms.each do |term|
          base_query.sub!("?", term)
        end
        @products = Product.where(base_query)
      end
      
      
    else
      @products = Product.all
    end
    
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
    #if not logged in or doesnt have edit permissions, redirect home.
    if(!@current_user || !@current_user.user_type.products_edit)
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
    #if not logged in or doesnt have edit permissions, redirect home.
    if(!@current_user || (!@current_user.user_type.products_edit && !@current_user.user_type.sales_edit))
      redirect_to root_url
      return
    end
    
    @sales = Sale.find(:all)
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    #if not logged in or doesnt have edit permissions, redirect home.
    if(!@current_user || !@current_user.user_type.products_edit)
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
    #if not logged in or doesnt have edit permissions, redirect home.
    if(!@current_user || (!@current_user.user_type.products_edit && !@current_user.user_type.sales_edit && !@current_user.user_type.products_quantity))
      redirect_to root_url
      return
    end
    
    @sales = Sale.find(:all)
    
    @product = Product.find(params[:id])
    
    # set keywords selected
    if (params[:keyword_ids])
      @product.keywords = Keyword.find(params[:keyword_ids])
    end
    
    # set sale selected
    if (params[:sale_id])
     # @product.sale_id = Sale.find(params[:sale_id])
      @product.sale_id = params[:sale_id]
    end
    
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
    if(!@current_user || !@current_user.user_type.products_edit)
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
