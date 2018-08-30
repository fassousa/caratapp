class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :employees, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def most_distant_employee
    employees.where.not(latitude: nil).sort_by do |employee|
      distance_to(employee)
    end.last
  end

  def location
    {lat: latitude.to_f, lng: longitude.to_f}
  end
end
