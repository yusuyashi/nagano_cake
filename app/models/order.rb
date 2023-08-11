class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  belongs_to :customer
  has_many :order_details
  
  before_validation :set_default_payment_method

  private

  def set_default_payment_method
    self.payment_method ||= 'credit_card'
  end
end
