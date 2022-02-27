class Order < ApplicationRecord
   belongs_to :customer
   has_many :order_details, dependent: :destroy
   
   enum payment_method: { credit_card: 0, transfer: 1 }
   enum status: { wating_for_payment: 0, confirmed_payment: 1, making: 2, ready_to_ship: 3, sent: 4 }
   
  def order_item_payment
    (payment - 800).round
  end

end
