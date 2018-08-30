class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def rewards
    @annual_cost = Money.new(430920, "BRL")
    @total_employees = current_user.employees.count
    @total_cost = @annual_cost * @total_employees
    @total_individual_distance = 0
    current_user.employees.each do |e|
      @total_individual_distance += e.distance_to_work
    end
  end
end
