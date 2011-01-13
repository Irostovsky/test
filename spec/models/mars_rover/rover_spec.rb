require 'spec_helper'

describe Rover do
  describe "new" do
    it "should create new rover with initial data" do
      r = Rover.new("12 4", "2 3 N")
      r.direction.should == 'N'
      r.coord.should == [2,3]
      r.planet_coord.should == [12,4]
    end
    context "should raise error if " do
      it "planet_coord is not valid" do
        lambda{Rover.new("-12 4", "2 3 N")}.should raise_error(Exception)
        lambda{Rover.new("12 -4", "2 3 N")}.should raise_error(Exception)
      end
      
      it "rover_coord is not valid" do
        lambda{Rover.new("12 4", "-2 3 N")}.should raise_error(Exception)
        lambda{Rover.new("12 4", "2 -3 N")}.should raise_error(Exception)
      end
      
      it "rover is not on planet" do
        lambda{Rover.new("12 4", "92 3 N")}.should raise_error(Exception)
        lambda{Rover.new("12 4", "2 43 N")}.should raise_error(Exception)
      end
      
      it "direction is not allowed" do
        lambda{Rover.new("12 4", "2 3 D")}.should raise_error(Exception)
      end
      
    end
    
  end

  describe "coordinates_by_path" do
    it "should return coords for path" do
      r = Rover.new("5 5", "0 0 N")
      r.coordinates_by_path('').should == "0 0 N"
      r.coordinates_by_path('M').should == "1 0 N"
      r.coordinates_by_path('R').should == "1 0 E"
      r.coordinates_by_path('M').should == "1 1 E"
      r.coordinates_by_path('LM').should == "2 1 N"
      
    end
  end
  
  describe "move" do
    it "should do nothing if command is not defined" do
      r = Rover.new("5 5", "0 0 N")
      r.move('D')
      r.coord.should == [0, 0]
      r.direction.should == 'N'
    end
    
    it "should turn right" do
      r = Rover.new("5 5", "0 0 N")
      r.move('R')
      r.coord.should == [0, 0]
      r.direction.should == 'E'
      
      r.move('R')
      r.coord.should == [0, 0]
      r.direction.should == 'S'
      
      r.move('R')
      r.coord.should == [0, 0]
      r.direction.should == 'W'
      
      r.move('R')
      r.coord.should == [0, 0]
      r.direction.should == 'N'
      
    end
    it "should turn left" do
      r = Rover.new("5 5", "0 0 N")
      r.move('L')
      r.coord.should == [0, 0]
      r.direction.should == 'W'
      
      r.move('L')
      r.coord.should == [0, 0]
      r.direction.should == 'S'
      
      r.move('L')
      r.coord.should == [0, 0]
      r.direction.should == 'E'
      
      r.move('L')
      r.coord.should == [0, 0]
      r.direction.should == 'N'
      
    end
    context "move" do
      it "and direction is N" do
        r = Rover.new("5 5", "0 0 N")
        r.move('M')
        r.coord.should == [0, 1]
        r.direction.should == 'N'
      end
      
      it "and direction is E" do
        r = Rover.new("5 5", "1 1 E")
        r.move('M')
        r.coord.should == [1, 2]
        r.direction.should == 'E'
      end
      
      it "and direction is S" do
        r = Rover.new("5 5", "1 1 S")
        r.move('M')
        r.coord.should == [0, 1]
        r.direction.should == 'S'
      end
      
      it "and direction is W" do
        r = Rover.new("5 5", "1 1 W")
        r.move('M')
        r.coord.should == [1, 0]
        r.direction.should == 'W'
      end
    end
    context "should not move if coord out of planet" do
      it "and direction is N" do
        r = Rover.new("5 5", "0 5 N")
        r.move('M')
        r.coord.should == [0, 5]
        r.direction.should == 'N'
      end
      
      it "and direction is E" do
        r = Rover.new("5 5", "5 1 E")
        r.move('M')
        r.coord.should == [5, 1]
        r.direction.should == 'E'
      end
      
      it "and direction is S" do
        r = Rover.new("5 5", "1 1 S")
        r.move('M')
        r.coord.should == [0, 1]
        r.direction.should == 'S'
      end
      
      it "and direction is W" do
        r = Rover.new("5 5", "1 1 W")
        r.move('M')
        r.coord.should == [1, 0]
        r.direction.should == 'W'
      end
    end
  end
end
