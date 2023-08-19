class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items
  has_many :orders
  has_many :addresses

  def full_name
    "#{last_name} #{first_name}"
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
end
