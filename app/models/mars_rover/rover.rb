class Rover
   attr_accessor :direction, :coord, :planet_coord
   
   DIRECTIONS = ['N', 'E', 'S', 'W']
   def initialize(planet_coord, rover_coord)
     @planet_coord = planet_coord.split(' ').map(&:to_i)
     @coord = rover_coord.split(' ')
     @direction = @coord.pop
     @coord.map!(&:to_i)
     raise Exception.new('Bad planeet coords') unless @planet_coord.all?{|item| item >= 0}
     raise Exception.new('Bad rover coords') unless @coord.all?{|item| item >= 0}
     raise Exception.new('Rover is not on planet') if @coord[0] > @planet_coord[0] || @coord[1] > @planet_coord[1]
     raise Exception.new('Bad rover direction') unless DIRECTIONS.include? @direction
    end
   
   def coordinates_by_path(path)
     path.chars.to_a.each do |item|
       self.move item
     end
     self.coord.join(' ') << " #{@direction}"
   end

   def move(path_item)
    case path_item
    when 'R'
      @direction = DIRECTIONS[(DIRECTIONS.index(@direction) + 1) % 4]
    when 'L'
      @direction = DIRECTIONS[(DIRECTIONS.index(@direction) - 1) % 4]
    when 'M'
      case @direction
      when "N"
        @coord[1] += 1 if @coord[0] + 1 <= @planet_coord[1] 
      when "E"
        @coord[1] += 1 if @coord[1] + 1 <= @planet_coord[0]
      when "S"
        @coord[0] -= 1
      when "W"
        @coord[1] -= 1
      end
    end
   end
   
end