class User < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :user_type
  has_many :orders
  attr_accessible :address, :city, :credit_card, :email_address, :first_name, :hashed_password, :password_salt, :password, :password_confirmation, :last_name, :phone_number, :user_type_id, :zipcode
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password 
  validates :password, :presence => true, :length => { :within => 6..40}, :on => :create
  validates :password, :length => { :within => 6..40}, :on => :update
  
  validates_presence_of :first_name, :last_name, :zipcode, :city, :address, :email_address
  validates_uniqueness_of :email_address
  
  validates :email_address, :email => true
  validates :zipcode, :zipcode => true
  validates :phone_number, :phone_number => true
  
  def self.authenticate(email, password)
    user = find_by_email_address(email)
    if user && user.hashed_password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.hashed_password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
end
