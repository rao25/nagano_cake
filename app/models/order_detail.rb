class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  enum making_status: { not_startable: 0,  wating_for_make: 1, making: 2, completed: 3 }
  
  def sum_of_price
    (self.tax_included_price * self.quantity).round
  end
  

end
