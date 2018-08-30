class Route
  attr_accessor :user, :iframe_base_url, :json_base_url, :json
  def initialize(user)
    @user = user
    @iframe_base_url = 'https://www.google.com/maps/embed/v1/directions'
    @json_base_url   = 'https://maps.googleapis.com/maps/api/directions/json'
    @json = HTTParty.get(json_url)

    @employee_yearly_cost = Money.new(4309.20, "BRL")
    @km_cost = 70 # ???
  end

  def carat_yearly_cost
    @employee_yearly_cost * total_distance
  end

  def non_carat_yearly_cost
    @employee_yearly_cost * total_distance
  end

  def origin
    @user.most_distant_employee.address
  end

  def destination
    @user.address
  end

  def waypoints
    user.employees.where.not(latitude: nil).map do |employee|
      {location: employee.location, stopover: true}
    end
  end

  def iframe_url
    "#{@iframe_base_url}?#{query_params}"
  end

  def json_url
    "#{json_base_url}?#{query_params(optimize: true)}"
  end

  def total_time_in_hours
    json['routes'][0]['legs'].pluck('duration').pluck('value').sum / 3600
  end

  def total_distance(option = {})
    distance = json['routes'][0]['legs'].pluck('distance').pluck('value').sum
    return distance / 1000 if option[:in].eql?(:kilometers)
    distance
  end

  def carat_cost
    total_distance(in: :kilometers) * @km_cost
  end

  private

  def query_params(options = {})
    if @user.most_distant_employee
    {
      origin: origin,
      destination: destination,
      waypoints: "#{options[:optimize] ? 'optimize:true|' : ''}#{@waypoints}",
      key: ENV['GOOGLE_API_BROWSER_KEY']
    }.to_query
    end
  end
end
