class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items

  def self.by_merchant_items(id)

    merchandise = Product.where(user_id: id)
    # finding products that belong to the logged-in user

    selected_items = []
    merchandise.each do |merch|
      selected_items << OrderItem.where(product_id: merch.id)
    end
    # loop through the products that are owned by logged in user and see if they match any of the products in any of the orders

    selected_orders = []
    selected_items.each do |join_item|
      selected_orders << Order.where(order_id: join_item.orders)
    end
    # loop through orderitems that belong to logged in user to find orders that have those items in them.

    return selected_orders

  end


 def get_total
   total = 0
   self.order_items.each do |item|
     product = Product.find(item.product_id)
     sub_total = product.price * item.quantity
     total += sub_total
   end

   return total
 end


end
