require 'spec_helper'

describe Item do
  describe "validate intervals" do
    before(:each) do
      @start = Time.zone.local(2010, 1, 1, 12, 0)
    end
    it "end and start should not be nil" do
      i = Item.new
      i.valid?.should be_false
    end

    it "should NOT valid if start > end" do
      i = Item.new(:start => @start, :end => @start - 1.minutes)
      i.valid?.should be_false
    end

    it "should valid if start < end" do
      i = Item.new(:start => @start, :end => @start + 1.minutes)
      i.valid?.should be_true
    end
    
    it "should valid if start = end" do
      i = Item.new(:start => @start, :end => @start )
      i.valid?.should be_true
    end
    
    context "intervals intersection" do
      it "should NOT valid if start is in existent interval" do
        Item.create(:start => @start, :end => @start + 10.minutes)
        Item.new(:start => @start + 1.minutes, :end => @start + 12.minutes).valid?.should be_false
      end
      
      it "should NOT valid if end is in existent interval" do
        Item.create(:start => @start, :end => @start + 10.minutes)
        Item.new(:start => @start - 1.minutes, :end => @start + 2.minutes).valid?.should be_false
      end
      
      it "should NOT valid if interval includes other existent intervals" do
        Item.create(:start => @start, :end => @start + 10.minutes)
        Item.new(:start => @start - 1.minutes, :end => @start + 12.minutes).valid?.should be_false
      end
      
      it "should NOT valid if interval includes other existent intervals" do
        Item.create(:start => @start, :end => @start + 2.minutes)
        Item.create(:start => @start + 3.minutes, :end => @start + 4.minutes)
        Item.new(:start => @start - 1.minutes, :end => @start + 12.minutes).valid?.should be_false
      end
      
      it "should NOT valid if interval is in existent intervals" do
        Item.create(:start => @start, :end => @start + 12.minutes)
        Item.new(:start => @start + 1.minutes, :end => @start + 2.minutes).valid?.should be_false
      end
      
      it "should valid if interval between existent intervals" do
        Item.create(:start => @start, :end => @start + 2.minutes)
        Item.create(:start => @start + 6.minutes, :end => @start + 8.minutes)
        Item.new(:start => @start + 3.minutes, :end => @start + 4.minutes).valid?.should be_true
      end
      
      it "should valid if interval start == existent interval end" do
        Item.create(:start => @start, :end => @start + 2.minutes)
        Item.new(:start => @start + 2.minutes, :end => @start + 4.minutes).valid?.should be_true
      end
      
      it "should valid if interval end == existent interval start" do
        Item.create(:start => @start, :end => @start + 2.minutes)
        Item.new(:start => @start - 2.minutes, :end => @start).valid?.should be_true
      end
      
      context "on update" do
        it "should valid " do
          Item.create(:start => @start, :end => @start + 2.minutes)
          i = Item.create(:start => @start + 2.minutes , :end => @start + 4.minutes)
          i.update_attributes :start => @start + 3.minutes
          i.should be_valid
        end
        
        it "should NOT valid " do
          Item.create(:start => @start, :end => @start + 2.minutes)
          i = Item.create(:start => @start + 2.minutes , :end => @start + 4.minutes)
          i.update_attributes :start => @start + 1.minutes
          i.should_not be_valid
        end
        
        
      end      
    end
  end

end
