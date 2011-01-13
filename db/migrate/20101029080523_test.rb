class Test < ActiveRecord::Migration
  def self.up
    p self
    p self.class
  end

  def self.down
  end
end
