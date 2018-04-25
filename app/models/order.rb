class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items

  def self.by_merchant_items(id)

    merchandise = Product.where(user_id: id)

    selected_items = []
    merchandise.each do |merch|
      selected_items = OrderItem.where(product_id: merch.id)
    end

    selected_orders = []
    selected_items.each do |join_item|
      selected_orders = Order.where(order_id: join_item.order_id)
    end

    return selected_orders

  end

end
