require 'test_helper'

class ProcedureTest < ActiveSupport::TestCase
  # Relationship matchers...
  should have_many(:procedure_costs)
  should have_many(:treatments)
  should have_many(:visits).through(:treatments)
  
  # Validation matchers...
  should validate_presence_of(:name)
  should validate_numericality_of(:length_of_time).only_integer.is_greater_than(0)

  context "Creating procedures context" do
    # create the objects I want with factories
    setup do 
      create_procedures
    end
    
    # and provide a teardown method as well
    teardown do
      destroy_procedures
    end
  
    # now run the tests:
    # test the scope 'alphabetical'
    should "shows that procedures are listed in alphabetical order" do
      assert_equal ["Check-up", "Dental Work", "X-ray"], Procedure.alphabetical.map{|a| a.name}
    end
    
    # test the scope 'active'
    should "shows that there are two active procedures" do
      assert_equal 2, Procedure.active.size
      # assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
      assert_equal ["Check-up", "X-ray"], Procedure.active.map{|p| p.name}.sort
    end

    # test the scope 'inactive'
    should "shows that there is one inactive procedure" do
      assert_equal 1, Procedure.inactive.size
      # assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
      assert_equal ["Dental Work"], Procedure.inactive.map{|p| p.name}.sort
    end

    # test the method current_cost
    should "have a method to find the current cost of procedure" do
      create_procedure_costs
      assert_equal 4000, @xray.current_cost
      assert_equal 3000, @checkup.current_cost
      destroy_procedure_costs
      # test the nil case by creating a new procedure without a cost
      @ghost_proc   = FactoryBot.create(:procedure, name: 'Ghost Procedure')
      assert_nil @ghost_proc.current_cost
    end
  end
end
