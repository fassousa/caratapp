class EmployeesController < ApplicationController

  def dashboard #this is our index page
    @user = current_user
    @employees = @user.employees

    @employees = Employee.where.not(latitude: nil, longitude: nil)

    @markers = @employees.map do |employee|
      {
        lat: employee.latitude,
        lng: employee.longitude#,
        # infoWindow: { content: render_to_string(partial: "/employees/map_box", locals: { flat: flat }) }
      }
    end
  end

  def edit
    @employee = Employee.new
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update(employee_params)

    redirect_to dashboard_path
  end

  def destroy

  end


  private



end
