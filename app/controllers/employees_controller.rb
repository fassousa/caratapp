class EmployeesController < ApplicationController
  def dashboard
    @company = current_user
    @employees = @company.employees
  end
end
