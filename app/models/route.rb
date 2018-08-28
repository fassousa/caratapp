class Route
  attr_accessor :user, :waypoints, :iframe_base_url, :json_base_url, :json
  def initialize(user)
    @user = user
    @waypoints = user.employees.where.not(latitude: nil).map(&:location).join('')
    @iframe_base_url = 'https://www.google.com/maps/embed/v1/directions'
    @json_base_url   = 'https://maps.googleapis.com/maps/api/directions/json'
    @json = HTTParty.get(json_url)
  end

  def origin
    @user.most_distant_employee.address
  end

  def iframe_url
    "#{@iframe_base_url}?#{query_params}"
  end

  def json_url
    "#{json_base_url}?#{query_params(optimize: true)}"
  end

  def total_distance
    json['routes'][0]['legs'].pluck('distance').pluck('value').sum
  end

  private

  def query_params(options = {})
    {
      origin: @user.most_distant_employee.location,
      destination: @user.address,
      waypoints: "#{options[:optimize] ? 'optimize:true|' : ''}#{@waypoints}",
      # key: ENV['GOOGLE_API_BROWSER_KEY']
    }.to_query
  end
end
