class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
 
  def sum_of_price
   item.tax_included_price * amount
  end 
  
  def tax_included_price
   (item.price * 1.08).round
  end 
  
  
end
