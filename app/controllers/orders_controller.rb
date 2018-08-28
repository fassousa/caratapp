class OrdersController < ApplicationController
  # Added with Order model
  def create
  route = Route.find(params[:route_id])
  order  = Order.create!(route_sku: route.sku, amount: route.price, state: 'pending', user: current_user)

  redirect_to new_order_payment_path(order)
  end
end
