class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    if(!@current_user || !@current_user.user_type_id.orders_list)
      redirect_to root_url
      return
    end
    
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if(!@current_user || !@current_user.user_type_id.orders_list || !@current_user.orders.select{|n| n == params[:id]})
      redirect_to root_url
      return
    end
    
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    if(!@current_user || !@current_user.orders.select{|n| n == params[:id]})
      redirect_to root_url
      return
    end
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add
    if(!@current_user)
      redirect_to root_url
      return
    end
    if(@current_user)
      # get the product based on the id passed in
      product = Product.find(params[:id])
      # get the users current cart
      cart = @current_user.cart
      
      # see if item is in cart already
      order_items = cart.order_items.select { |item| item.product_id == product.id }
      order_item = order_items[0]
      
      if(order_item) # if it is
        #increment it by one
        order_item.quantity += 1
        order_item.save
      else
        #add product
        order_item = OrderItem.new do |item|
          item.product_id = product.id
          item.quantity = 1
        end
        
        cart.order_items.push(order_item)
      end
      
      redirect_to :action =>"edit", :id => cart.id
    end
  end
  
  #POST /orders/purchase/1
  def purchase
    if(!@current_user || !@current_user.orders.select{|n| n == params[:id]})
      redirect_to root_url
      return
    end
    
    # get order
    order = Order.find(params[:id])
    
    # mark as purchased
    order.purchased = true
    
    #save changes
    order.save
    
    #redirect to view order
    redirect_to order
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    if(!@current_user || !@current_user.orders.select{|n| n == params[:id]})
      redirect_to root_url
      return
    end
    
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if(!@current_user || !@current_user.orders.select{|n| n == params[:id]})
      redirect_to root_url
      return
    end
    
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end
