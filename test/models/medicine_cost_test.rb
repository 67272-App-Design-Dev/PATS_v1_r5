require 'test_helper'

class MedicineCostTest < ActiveSupport::TestCase
# Relationship matchers...
  should belong_to(:medicine)
  
  # Validation matchers...
  should validate_numericality_of(:cost_per_unit).only_integer.is_greater_than_or_equal_to(0)
  should allow_value(Date.current).for(:start_date)
  should allow_value(1.day.ago.to_date).for(:start_date)
  should allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date)

  context "Creating context" do
    setup do 
      create_medicines
      create_medicine_costs
    end
    
    teardown do
      destroy_medicine_costs
      destroy_medicines
    end
  
    # test the scope 'chronological'
    should "shows that medicine_costs are listed in chronological order" do
      assert_equal [@rabies_c1, @carprofen_c1, @amoxicillin_c1, @rabies_c2], MedicineCost.chronological.to_a
    end
    
    # test the scope 'current'
    should "shows that there are three medicines with current cost" do
      assert_equal [30, 40, 50], MedicineCost.current.map{|o| o.cost_per_unit}.sort
    end

    # test the scope 'for_medicine'
    should "shows that there are medicine costs filtered by medicine" do
      assert_equal 2, MedicineCost.for_medicine(@rabies.id).count
      assert_equal 1, MedicineCost.for_medicine(@carprofen.id).count
    end

    # test the scope 'for_date'
    should "find the correct costs for a given date" do
      assert_equal [30, 40, 50], MedicineCost.for_date(3.months.ago.to_date).map{|o| o.cost_per_unit}.sort
      assert_equal [25, 50], MedicineCost.for_date(320.days.ago.to_date).map{|o| o.cost_per_unit}.sort
      assert_equal [], MedicineCost.for_date(13.months.ago.to_date)
    end

    # test the callback for setting the old price end date
    should "verify that the old price end_date set to today" do
      assert_nil @carprofen_c1.end_date
      @change_cost = FactoryBot.create(:medicine_cost, medicine: @carprofen, start_date: 1.month.ago.to_date, cost_per_unit: 60)
      @carprofen_c1.reload
      assert_equal 1.month.ago.to_date, @carprofen_c1.end_date
    end

  end
end
