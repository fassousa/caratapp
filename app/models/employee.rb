class Employee < ApplicationRecord
  belongs_to :user

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def location
    {lat: latitude, lng: longitude}.to_json
  end

  def distance_to_work
    user.distance_to(self)
  end
end
