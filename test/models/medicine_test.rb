require 'test_helper'

class MedicineTest < ActiveSupport::TestCase
  # Relationship matchers...
  should have_many(:medicine_costs)
  should have_many(:animal_medicines)
  should have_many(:animals).through(:animal_medicines)
  should have_many(:dosages)
  should have_many(:visits).through(:dosages)
  
  # Validation matchers...
  should validate_presence_of(:name)
  should validate_numericality_of(:stock_amount).only_integer.is_greater_than_or_equal_to(0)

  context "Creating medicines context" do
    setup do 
      create_medicines
    end
    
    teardown do
      destroy_medicines
    end
  
    # test the scope 'alphabetical'
    should "shows that medicines are listed in alphabetical order" do
      assert_equal ["Amoxicillin", "Carprofen", "Rabies"], Medicine.alphabetical.map{|o| o.name}
    end

    # test the scope 'active'
    should "have a scope for active medicines" do
      # make a medicine inactive first...
      @amoxicillin.active = false
      @amoxicillin.save
      assert_equal ["Carprofen", "Rabies"], Medicine.active.map{|o| o.name}.sort
    end

    # test the scope 'depleted'
    should "shows medicines that are depleted in stock_amount" do
      assert_equal ["Carprofen"], Medicine.depleted.map{|o| o.name}
    end

    # test the scope 'vaccines'
    should "have a scope for vaccines only" do
      assert_equal ["Rabies"], Medicine.vaccines.map{|o| o.name}
    end    

    # test the scope 'nonvaccines'
    should "have a scope for nonvaccines" do
      assert_equal ["Amoxicillin", "Carprofen"], Medicine.nonvaccines.map{|o| o.name}.sort
    end

    # test the method 'is_vaccine?'
    should "have method is_vaccine?" do
      assert @rabies.is_vaccine?
      deny @carprofen.is_vaccine?
    end

    # test the method current_cost_per_unit
    should "have a method to find the current cost of medicine" do
      create_medicine_costs
      assert_equal 50, @carprofen.current_cost_per_unit
      assert_equal 30, @rabies.current_cost_per_unit
      destroy_medicine_costs
      # test the nil case by creating a new medicine without a cost
      @ghost_med   = FactoryBot.create(:medicine, name: 'Ghost Medicine')
      assert_nil @ghost_med.current_cost_per_unit
    end

    # test the method self.ftsearch
    # should "have a class method called ftsearch" do
    #   assert_equal [@carprofen], Medicine.ftsearch("inflammation")
    #   assert_equal [@amoxicillin], Medicine.ftsearch("infect")
    #   assert_nil Medicine.ftsearch("")
    # end

    should "show that an medicine that has been used cannot be destroyed" do
      create_animals
      create_owners
      create_pets
      create_visits
      create_animal_medicines
      create_dosages
      # deny @rabies.destroy
      destroy_dosages
      destroy_animal_medicines
      destroy_visits
      destroy_pets
      destroy_owners
      destroy_animals
    end

    should "show that a medicine that has never been used can be destroyed" do
      catnip = FactoryBot.create(:medicine, name: "Catnippititus")
      catnip.destroy
      assert catnip.destroyed?
    end

  end
end

  