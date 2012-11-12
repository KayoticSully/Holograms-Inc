# This file contains all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed.  The command is part of project:update so the
# database gets repopulated when the server is refreshed.  
#
# This file populates the following records:
#   Keywords
#   Products
#   Groups (Product->keyword pairs)
#   Help Items (FAQs)
#
# Coming soon:
#   Default user accounts (1 customer account per team member)
#   Default manager accounts (1 per role)


puts "Seeding database"
# Clear out the Keywords table in the database
Keyword.delete_all
puts " Adding keywords"
# Open the csv file containing the seeds.  CSV file has but one keyword per line
# In the future once sub-categories are worked out, the file will have a keyword
# name and an optional super-category per line.  
open("#{Rails.root}/db/keyword_seed.csv") do |keywords|
  # For each keyword, chomp the data and create a new entry in the Keywords table
  keywords.read.each_line do |keyword|  
   # name = keyword.chomp.split("|")
    @name = keyword.chomp
    Keyword.create!(:name => @name)
  # puts "  Added #@name"
  end  
end

# Clear out the Products table in the database
Product.delete_all
puts " Adding products"
# Open the csv file containing the seeds. CSV file has one record per line.
# Fields in the record are split by vertical bars |
# Chomp the record in to fields (CSV has fields in the same order as they are
# being used here)
# Create a new entry in the Products table for each record
open("#{Rails.root}/db/prod_seed.csv") do |products|  
  products.read.each_line do |product|  
    @name, description, price, image, stock, public, weight, height, length, width = product.chomp.split("|")
    Product.create!(:name => @name, :description => description, :price => price,
                    :image => File.open(image), :stock => stock, :public => public,
                    :weight => weight, :height => height, :length => length,
                    :width => width)
  #puts "  Added #@name"
  end  
end

# Clear out the Groups table in the database
 Group.delete_all
 puts " Adding groups"
# Open the csv file containing the seeds. CSV file has one record per line.
# Each line contains a keyword name and a product name, split by a vertical bar.
# Look up the id of the keyword and product being linked, then create a new
# entry in the Groups table for each connection
# Note: This assumes that the id for keyword and product will be found!
 open("#{Rails.root}/db/group_seed.csv") do |groups|  
   groups.read.each_line do |group|
     @keyword_name, @product_name = group.chomp.split("|")
     @keyword_name = @keyword_name.downcase
     @keyword_id = Keyword.find(:first, :conditions => "name='#@keyword_name'").id
    @product_id = Product.find(:first, :conditions => "name='#@product_name'").id
     Group.create!(:keyword_id => @keyword_id, :product_id => @product_id)  
    # puts "  Added #@keyword_name -> #@product_name"                
   end  
 end

# Clear out the HelpItems table in the database
HelpItem.delete_all
puts " Adding help items"
# Open the csv file containing the seeds. CSV file has one record per line.
# Each line contains a question and an answer, split by a vertical bar.
# Create a new entry in the HelpItems table for each line
open("#{Rails.root}/db/faq_seed.csv") do |helpitems|  
  helpitems.read.each_line do |helpitem|  
    @title,text = helpitem.chomp.split("|")
    HelpItem.create!(:title => @title, :text => text)  
    #puts "  Added #@title"                
  end  
end
 
# Clear out UserTypes table in the database
UserType.delete_all
puts " Adding user types"
# Open the csv file containing the seeds. CSV file has one record per line.
# Each line contains the user type's name and boolean values for each authority, all split by vertical bars
# Create a new entry in the UserTypes table for each line
open("#{Rails.root}/db/usertype_seed.csv") do |usertypes|  
  usertypes.read.each_line do |usertype|
    products,purchase,products_edit,products_quantity,help_edit,@name,users_list,orders_list,user_types_edit,keywords_edit,sales_edit = usertype.chomp.split("|")
    UserType.create!(:products => products, :purchase => purchase, :products_edit => products_edit,
                     :products_quantity => products_quantity, :help_edit => help_edit, :name => @name,
                     :users_list => users_list, :orders_list => orders_list, :user_types_edit => user_types_edit,
                     :keywords_edit => keywords_edit, :sales_edit =>sales_edit)  
#   puts "  Added #@name"                
  end  
end

# Clear out Users table in the database 
User.delete_all
puts " Adding default users and manager ids"
# Open the csv file containing the seeds. CSV file has one record per line.
# Each line contains the user's information and the plaintext password, all split by vertical bars.
# Create a new entry in the Users table for each line
open("#{Rails.root}/db/user_seed.csv") do |users|  
  users.read.each_line do |user|  
    first_name,last_name,address,city,zipcode,@email_address,password,@usertype_name,state,country,disabled = user.chomp.split("|")
    usertype_id = UserType.find(:first, :conditions => "name='#@usertype_name'").id
    User.create!(:first_name => first_name, :last_name => last_name, :address => address,
                 :city => city, :zipcode => zipcode, :email_address => @email_address, 
                 :user_type_id => usertype_id, :state => state, :country => country, :password => password,
                 :phone_number => "",:credit_card => "", :disabled => disabled)
   # puts "  Added #@email_address - usertype #@usertype_name"                
  end  
end






