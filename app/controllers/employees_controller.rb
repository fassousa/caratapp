class EmployeesController < ApplicationController
  require 'csv'

  def dashboard #this is our index page
    @user = current_user
    @employees = @user.employees
    @employee = Employee.new

    @markers = markers
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.user = current_user

    if @employee.save
      @markers = markers
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
      @markers = markers
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
    @markers = markers
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def parse
    @csv_file = params[:csv_file]
    csv_text = File.read(@csv_file.tempfile)
    @employees = []
    CSV.parse(csv_text, {col_sep: ';'}) do |csv|
      @employee = Employee.new(name: csv[0], address: csv[1])
      @employee.user = current_user
      @employee.save
      @employees << @employee
    end
    @markers = markers

    respond_to do |format|
      format.html { redirect_to root_path(current_user) }
      format.js  # <-- will render `app/views/reviews/create.js.erb`
    end
  end



  private

  def employee_params
    params.require(:employee).permit(:name, :address)
  end

  def markers
    employees = Employee.where.not(latitude: nil, longitude: nil)

    markers = employees.map do |employee|
      {
        lat: employee.latitude,
        lng: employee.longitude
      }
    end
  end
end
