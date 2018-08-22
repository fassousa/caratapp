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
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update(employee_params)
    if @employee.save
      redirect_to dashboard_path
    else
      render 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    redirect_to dashboard_path
  end


  private

  def employee_params
    params.require(:employee).permit(:name, :address)
  end

end
