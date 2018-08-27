class EmployeesController < ApplicationController

  def dashboard #this is our index page
    @user = current_user
    @employees = @user.employees
    @employee = Employee.new

    @employees = Employee.where.not(latitude: nil, longitude: nil)

    @markers = @employees.map do |employee|
      {
        lat: employee.latitude,
        lng: employee.longitude#,
        # infoWindow: { content: render_to_string(partial: "/employees/map_box", locals: { flat: flat }) }
      }
    end
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.user = current_user

    if @employee.save
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'employees/dashboard' }
        format.js  # <-- idem
      end
    end
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update(employee_params)

    if @employee.save
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'employees/dashboard' }
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def parse
    @csv_file = employee_params[:csv_file]

    raise
  end


  private

  def employee_params
    params.require(:employee).permit(:name, :address, :csv_file)
  end

end
