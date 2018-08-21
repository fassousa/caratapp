class EmployeesController < ApplicationController
  def dashboard
    @user = current_user
    @employees = @user.employees
  end
end
