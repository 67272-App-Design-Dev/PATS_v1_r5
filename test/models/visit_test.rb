require 'test_helper'

class VisitTest < ActiveSupport::TestCase
  # Relationship macros...
  should belong_to(:pet)
  should have_many(:dosages)
  should have_many(:treatments)
  should have_one(:animal).through(:pet)
  should have_one(:owner).through(:pet)
  
  # Validation macros...
  should validate_presence_of(:pet_id)
  should validate_presence_of(:weight)
  
  # Validating weight...
  should allow_value(1).for(:weight)
  should allow_value(10).for(:weight)
  should allow_value(50).for(:weight)
  should allow_value(42.5).for(:weight)
  should_not allow_value("bad").for(:weight)
  should_not allow_value(0).for(:weight)
  should_not allow_value(-10).for(:weight)
  should_not allow_value(101).for(:weight)

  # Validating date...
  should allow_value(Date.current).for(:date)
  should allow_value(1.day.ago.to_date).for(:date)
  should allow_value(1.day.from_now.to_date).for(:date)
  should_not allow_value("bad").for(:date)
  should_not allow_value(2).for(:date)
  should_not allow_value(3.14159).for(:date) 
  should_not allow_value(nil).for(:date) 

  # ---------------------------------
  # Testing other methods with a context
  context "Given context" do
    # create the objects I want with factories
    setup do 
      create_animals
      create_owners
      create_pets
      create_visits
    end
    
    # and provide a teardown method as well
    teardown do
      destroy_visits
      destroy_pets
      destroy_animals
      destroy_owners
    end
    
    # test the named scope 'chronological'
    should "have all the visits are listed here in desc order" do
      assert_equal 3, Visit.chronological.size # quick check of size
      dates = Array.new
      # get array of visit dates in order
      [2,5,6].sort.each {|n| dates << n.months.ago.to_date}
      assert_equal dates, Visit.chronological.map{|v| v.date}
    end
    
    # test the named scope 'for_pet'
    should "have named scope for_pet that works" do
      assert_equal 1, Visit.for_pet(@dusty.id).size
      assert_equal 2, Visit.for_pet(@polo.id).size
    end
    
    # test the named scope 'last_x'
    should "have named scope last_x that works" do
      assert_equal 2, Visit.for_pet(@polo.id).last_x(5).size
      assert_equal 2, Visit.for_pet(@polo.id).last_x(2).size
      assert_equal 1, Visit.for_pet(@polo.id).last_x(1).size
    end
  end
end
