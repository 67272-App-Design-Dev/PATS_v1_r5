require 'test_helper'

class DosageTest < ActiveSupport::TestCase
  # Relationship macros
  should belong_to :visit
  should belong_to :medicine
  should have_one(:pet).through(:visit)

  # Validation macros
  should validate_numericality_of(:discount).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(1)
  should validate_numericality_of(:units_given).only_integer.is_greater_than(0)

  context "Creating context" do
    setup do 
      create_animals
      create_owners
      create_pets
      create_visits
      create_medicines
      create_medicine_costs
      create_animal_medicines
      create_dosages
    end
    
    teardown do
      destroy_dosages
      destroy_animal_medicines
      destroy_visits
      destroy_pets
      destroy_animals
      destroy_owners
      destroy_medicine_costs
      destroy_medicines
    end
  
    # test the scope 'for_medicine'
    should "have a scope for_medicine" do
      assert_equal [@visit2_d2], Dosage.for_medicine(@amoxicillin.id)
    end
    
    # test the scope 'for_visit'
    should "have a scope for_visit" do
      assert_equal [@visit1_d1], Dosage.for_visit(@visit1.id)
    end

    # test the custom validation 'medicine_actively_offered_by_PATS'
    should "identify a medicine not offered at PATS as invalid" do
      # using 'build' instead of 'create' so not added to db; vaccine will not be in the system (only in memory)
      catnip = FactoryBot.build(:medicine, name: "Catnippititus", active: false)
      catnip_medicine = FactoryBot.build(:animal_medicine, animal: @cat, medicine: catnip)
      catnip_dosage = FactoryBot.build(:dosage, visit: @visit1, medicine: catnip)
      deny catnip_dosage.valid?
    end
    
    # test the custom validation 'vaccine_matches_animal_type'
    should "not allow vaccines that are inappropriate to the animal" do
      # Testing both parts of the validation this time for demo purposes...
      # create a visit for Dusty (cat)
      @visit_dusty = FactoryBot.create(:visit, pet: @dusty)
      
      # make sure a cat medicine (rabies) is okay (valid)
      good_dosage = FactoryBot.build(:dosage, visit: @visit_dusty, medicine: @rabies)
      assert good_dosage.valid?
      
      # make sure a cat getting carprofen is invalid
      bad_dosage = FactoryBot.build(:dosage, visit: @visit_dusty, medicine: @carprofen)
      deny bad_dosage.valid?
      
      # destroy the visit by Dusty
      @visit_dusty.destroy    
    end

    # test callback 'update_total_cost_of_visit'
    should "raise the total cost of visit for each dosage given" do
      old_charge = @visit1.total_charge
      visit1_d2 = FactoryBot.create(:dosage, visit: @visit1, medicine: @amoxicillin)
      unit_costs_for_d2 = MedicineCost.for_medicine(@amoxicillin.id).for_date(@visit1.date).first.cost_per_unit
      additional_charge = visit1_d2.units_given.to_f * (1-visit1_d2.discount) * unit_costs_for_d2
      assert_equal (old_charge + additional_charge), @visit1.total_charge
    end

    # test callback 'refund_amount_in_cost_of_visit'
    should "reduce the total cost of visit for each dosage destroyed" do
      old_charge = @visit2.total_charge
      unit_costs_for_v2d2 = MedicineCost.for_medicine(@amoxicillin.id).for_date(@visit2.date).first.cost_per_unit
      refund_amount = @visit2_d2.units_given.to_f * (1-@visit2_d2.discount) * unit_costs_for_v2d2
      @visit2_d2.destroy
      assert_equal (old_charge - refund_amount), @visit2.total_charge
    end

    # test callback 'reduce_stock_amount_of_medicine_used'
    should "reduce stock amount left for each dosage given" do
      original_stock_amount = @amoxicillin.stock_amount
      visit1_d2 = FactoryBot.create(:dosage, visit: @visit1, medicine: @amoxicillin)
      @amoxicillin.reload
      assert_equal (original_stock_amount - visit1_d2.units_given), @amoxicillin.stock_amount
    end

  end
end
