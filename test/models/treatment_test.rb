require 'test_helper'

class TreatmentTest < ActiveSupport::TestCase
  # Relationship macros
  should belong_to :visit
  should belong_to :procedure
  should have_one(:pet).through(:visit)

  # Validation macros
  should validate_numericality_of(:discount).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(1)

  context "Creating context" do
    setup do 
      create_animals
      create_owners
      create_pets
      create_visits
      create_procedures
      create_procedure_costs
      create_treatments
    end
    
    teardown do
      destroy_treatments
      destroy_procedure_costs
      destroy_procedures
      destroy_visits
      destroy_pets
      destroy_animals
      destroy_owners
    end
  
    # test the scope 'for_procedure'
    should "have a scope for_procedure" do
      assert_equal [@visit2_t2], Treatment.for_procedure(@xray)
    end
    
    # test the scope 'for_visit'
    should "have a scope for_visit" do
      assert_equal [@visit1_t1], Treatment.for_visit(@visit1)
    end

    # test the scope 'alphabetical'
    should "arrange treatments alphabetically by procedure name" do
      assert_equal @visit2_t2, Treatment.alphabetical.last
    end

    # test callback 'update_total_cost_of_visit'
    should "raise the total cost of visit for each treatment given" do
      old_charge = @visit1.total_charge
      visit1_t2 = FactoryBot.create(:treatment, visit: @visit1, procedure: @xray, discount: 0.10)    
      costs_for_t2 = ProcedureCost.for_procedure(@xray.id).for_date(@visit1.date).first.cost
      additional_charge = (1-visit1_t2.discount) * costs_for_t2
      assert_equal (old_charge + additional_charge), @visit1.total_charge
    end

    # test callback 'refund_amount_in_cost_of_visit'
    should "reduce the total cost of visit for each treatment destroyed" do
      old_charge = @visit2.total_charge
      costs_for_v2t2 = ProcedureCost.for_procedure(@xray.id).for_date(@visit2.date).first.cost
      refund_amount = (1-@visit2_t2.discount) * costs_for_v2t2
      @visit2_t2.destroy
      assert_equal (old_charge - refund_amount), @visit2.total_charge
    end
  end
end
