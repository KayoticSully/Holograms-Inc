class User < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :user_type
  has_many :orders
  attr_accessible :address, :city, :credit_card, :email_address, :first_name, :hashed_password,:password_salt, :password, :password_confirmation,
                   :last_name, :phone_number, :user_type_id, :zipcode, :state, :country, :disabled
  
  attr_accessor :password
  before_validation :clean_data
  before_save :encrypt_password, :downcase_email, :check_type
  validates_confirmation_of :password
  validates :password, :presence => true, :length => { :within => 6..40}, :on => :create 
  validates :password, :length => { :within => 6..40}, :if => Proc.new{|f| !f.password.blank? }
  
  validates_presence_of :first_name, :last_name, :zipcode, :city, :address, :email_address, :state, :country
  validates_uniqueness_of :email_address
  
  validates :email_address, :email => true
  validates :zipcode, :zipcode => true
  validates :phone_number, :phone_number => true
  
  validates :credit_card, :creditcard  => true
  
  def clean_data
    # trim whitespace from beginning and end of string attributes
    attribute_names.each do |name|
      if send(name).respond_to?(:strip)
        send("#{name}=", send(name).strip)
      end
    end
  end
  
  def self.authenticate(email, password)
    user = find_by_email_address(email.downcase)
    if user && user.hashed_password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def downcase_email
    self.email_address = self.email_address.downcase
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.hashed_password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def cart
    @cart = orders.last
    
    if(!@cart || @cart.purchased == true)
      @cart = Order.new
      orders.push(@cart)
    end
    
    @cart
  end
  
  def check_type
    if !user_type.present?
      self.user_type_id = 1
    end
    
  end
  
end