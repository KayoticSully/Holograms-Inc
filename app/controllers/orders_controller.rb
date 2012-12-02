class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    #if not logged in OR user doesnt have permission to list orders, redirect home
    if(!@current_user || !@current_user.user_type.orders_list)
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
    #if not logged in OR current order history doesnt include param, redirect home
    if(!@current_user || @current_user.orders.select{|n| n.id == Integer(params[:id])}.length == 0)
      redirect_to root_url
      return
    end
    
    @order = Order.find(params[:id])
    @shipping_price = params[:shipping].to_i / 100.0

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end
  
  def updateShipping
    order = Order.find(params[:id])
    order.shipping_method = params[:method]
    order.shipping_cost = params[:price].to_i / 100.0
    order.save
    @ship_choice = true
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    #only logged in customers can add to cart.
    if(!@current_user || !@current_user.user_type.purchase)
      redirect_to "/log_in"
      return
    end
    
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    #if not logged in OR current users cart != param, redirect home
    if(!@current_user || @current_user.cart.id != Integer(params[:id]))
      redirect_to root_url
      return
    end
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    #only logged in customers can add to cart.
    if(!@current_user || !@current_user.user_type.purchase)
      redirect_to "/log_in"
      return
    end
    
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
    if(!@current_user || !@current_user.user_type.purchase)
      redirect_to "/log_in"
      return
    else
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
  
  # Remove an item from the cart (if more than one quantity, remove all)
  def removeall
    # Assume user is logged in to be viewing cart
    # get the product based on the id passed in
    product = Product.find(params[:id])
    # get the users current cart
    cart = @current_user.cart
      
    # Find order item in cart
    order_items = cart.order_items.select { |item| item.product_id == product.id }
    order_item = order_items[0]
      
    if(order_item) # if it is found
     OrderItem.destroy(order_item)
    end
      
      # Redirect back to the cart
      redirect_to :action =>"edit", :id => cart.id
  end
  
  # Remove one quantity of an item from the cart
  def remove
    # Assume user is logged in to be viewing cart
    # get the product based on the id passed in
    product = Product.find(params[:id])
    # get the users current cart
    cart = @current_user.cart
      
    # Find order item in cart
    order_items = cart.order_items.select { |item| item.product_id == product.id }
    order_item = order_items[0]
      
    if(order_item) # if it is found
      #set quantity to zero
      if (order_item.quantity > 0 && order_item.quantity != 1) 
       order_item.quantity -= 1
       order_item.save
      else
        if order_item.quantity == 1
           order_item.quantity = 0
        end 
       OrderItem.destroy(order_item)
      end 
    end
      
    # Refresh the cart   
    cart.order_items.push(order_item)
      
      # Redirect back to the cart
      redirect_to :action =>"edit", :id => cart.id
  end
  
    # Update the quantity of an item from the cart
  def updateqty
    # Assume user is logged in to be viewing cart
    # get the product based on the id passed in
    product = Product.find(params[:id])
    newquantity = params[:newqty].to_i
    # get the users current cart
    cart = @current_user.cart
      
    # Find order item in cart
    order_items = cart.order_items.select { |item| item.product_id == product.id }
    order_item = order_items[0]
      
    if(order_item) # if it is found
      if newquantity > 0
       order_item.quantity = newquantity
       order_item.save
      else
       OrderItem.destroy(order_item)
      end 
    end
      
    # Refresh the cart   
    cart.order_items.push(order_item)
      
      # Redirect back to the cart
      redirect_to :action =>"edit", :id => cart.id
  end
  
  def updateTotalPrice
    order_item.total_price = order_item.price * order_item.quantity
  end
  
  def cancelOrder
     cart.order_items.each do |item| 
      removeall
       #redirect_to promoted
    end
    
  end
  
  #POST /orders/purchase/1
  def purchase
    #if not logged in OR current users cart != param, redirect home
    if(!@current_user || @current_user.cart.id != Integer(params[:id]))
      redirect_to root_url
      return
    end
    
    # get order
    order = Order.find(params[:id])
    
    invalids = Array.new
    
    #check if user has a credit card
    if(!@current_user.credit_card || @current_user.credit_card == nil || @current_user.credit_card == "")
      invalids.push("Cannot make a purchase without a credit card. Please update your credit card information.")
    else
      #check that inventory can support purchase
      order.order_items.each do |order_item|
        if(order_item.quantity > order_item.product.stock)
          invalids.push("Cannot purchase #{order_item.quantity} of product: #{order_item.product.name}. Only #{order_item.product.stock} available.")
        end
      end
    end
    
    #check for errors
    if(invalids.length == 0)
      #deduct from stock
      order.order_items.each do |order_item|
        if(order_item.quantity <= order_item.product.stock)
          Product.update(order_item.product.id, "stock" => order_item.product.stock - order_item.quantity)
        end
      end
      
      # mark as purchased
      order.purchased = true
      
      #save changes
      order.save
      
      #redirect to view purchased order via updated "show"
        redirect_to :action =>"show"
       #redirect_to order
    else
      #fill the flash with the errors
      invalids.each do |error|
        flash[:notice] = error
      end
      
      #redirect back with errors
      redirect_to :action =>"show"
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    #if not logged in OR current users cart != param, redirect home
    if(!@current_user || @current_user.cart.id != Integer(params[:id]))
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
    #if not logged in OR current users cart != param, redirect home
    if(!@current_user || @current_user.cart.id != Integer(params[:id]))
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
