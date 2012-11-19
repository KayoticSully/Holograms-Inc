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
      keywordArr = Keyword.find(:all, :conditions => ["lower(name) =?", params[:id].gsub("_", " ").downcase])
      @keyword = keywordArr[0]
      @products = @keyword.products.select{|product| product.public}
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
  
  # SEARCH /search?query=xxxx
  #handles 1 word searches on keywords or products
  #handles multi-word search on products ONLY
  def search
    #ship off to the search helper,
    #then decide which keyword to route to, and what limits to impose
    if(params[:query])
      termsArr = params[:query].split
      @keyword = nil
      @product = nil

      if(termsArr.size == 1)
        query = "%#{termsArr[0]}%"
        keywordArr = Keyword.where("name LIKE ?", query)
        @keyword = keywordArr[0]
        productArr = Product.where("name LIKE ?", query)
        @product = productArr[0]
        #check for any results
        #if keyword, render that keyword.
        if(@keyword)
          redirect_to @keyword
        
        elsif(@product)
          #if only one product, show it
          if(productArr.size == 1)
            redirect_to @product
          else
            redirect_to "/products?query=#{termsArr[0]}"
          end
        
        else
          # if no results (that we care about)  
          # this does not work?? why?
          #flash[:notice] = 'No search results were found'
          redirect_to root_url, :notice => "No search results were found"
        end
        
      else
        #log which queries where matches to either
        keyword_matches = Array.new
        product_matches = Array.new
        
        #do a like query on each, log qhich ones are hits
        termsArr.each do |term|
          key = Keyword.where("name LIKE ?", "%#{term}%")
          if(key[0])
            keyword_matches << key[0].name
          end
          
          prod = Product.where("name LIKE ?", "%#{term}%")
          if(prod[0])
            product_matches << term
          end
        end
        
        #if(keyword_matches.size > 0 && product_matches.size > 0)
          #both a keyword and product match exists
          
        if(product_matches.size > 0)
          #only product hits, if only one, send it, otherwise send them all
          if(product_matches.size == 1)
            redirect_to "/products?query=#{product_matches[0]}"
          else
            query = ""
            product_matches.each do |product|
              query += "#{product}+"
            end
            query.chop!
            redirect_to "/products?query=#{query}"
          end
        ####Currently, yet
        #if(keyword_matches.size && product_matches.size == 0)
        #  if(keyword_matches.size == 1)
        #    redirect_to "/keywords?query=#{keyword_matches[0]}"
        #  else
        #    #only keyword matches, if one send it, otherwise, send them all
        #    query = ""
        #    keyword_matches.each do |k|
        #      query += "#{k}+"
        #    end
        #    query.chop!
        #    query.gsub!(" ", "_")
        #    redirect_to "/keywords?query=#{query}"
        #    #render :json => query
        #  end
        else
          #no hits
          #render :json => keyword_matches
          redirect_to root_url
        end
        #render :json => keyword_matches
      end
      
    else
      redirect_to root_url
    end
    
  end
end
