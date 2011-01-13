class Station
  
  def self.manage_rovers(data)
    output = []
    planet_coords = data.shift
    data.each_slice(2).each do |rover_data|
      output << Rover.new(planet_coords, rover_data[0]).coordinates_by_path(rover_data[1])
    end
    output
  end
end