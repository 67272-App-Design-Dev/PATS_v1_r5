require 'test_helper'

class DosagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @medicine        = FactoryBot.create(:medicine)
    @animal          = FactoryBot.create(:animal)
    @animal_medicine = FactoryBot.create(:animal_medicine, animal: @animal, medicine: @medicine)
    @owner           = FactoryBot.create(:owner)
    @pet             = FactoryBot.create(:pet, owner: @owner, animal: @animal)
    @visit           = FactoryBot.create(:visit, pet: @pet)
  end

  test "should get new" do
    get new_dosage_path(visit_id: @visit.id)
    assert_response :success
  end

  test "should create dosage" do
    assert_difference('Dosage.count') do
      post dosages_path, params: { dosage: { visit_id: @visit.id, medicine_id: @medicine.id, units_given: 42 } }
    end
    assert_redirected_to visit_path(Dosage.last.visit)

    post dosages_path, params: { dosage: { visit_id: @visit.id, medicine_id: @medicine.id, units_given: nil } }
    assert_template :new
  end


  test "should destroy dosage" do
    @dosage = FactoryBot.create(:dosage, visit: @visit, medicine: @medicine)
    assert_difference('Dosage.count', -1) do
      delete dosage_path(@dosage)
    end

    assert_redirected_to visit_path(@dosage.visit)
  end
end
