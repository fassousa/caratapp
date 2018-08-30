class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def rewards
    # @route = Route.new(current_user)

    # # @employees = current_user.employees

    # @route.carat_cost



    # @total_individual_distance = 0
    # current_user.employees.each do |e|
    #   @total_individual_distance += e.distance_to_work
    # end
  end
end
