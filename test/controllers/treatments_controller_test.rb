require 'test_helper'

class TreatmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @procedure = FactoryBot.create(:procedure)
    @animal    = FactoryBot.create(:animal)
    @owner     = FactoryBot.create(:owner)
    @pet       = FactoryBot.create(:pet, owner: @owner, animal: @animal)
    @visit     = FactoryBot.create(:visit, pet: @pet)
    @treatment = FactoryBot.create(:treatment, visit: @visit, procedure: @procedure)
  end

  test "should get new" do
    get new_treatment_path(visit_id: @visit.id)
    assert_response :success
  end

  test "should create treatment" do
    assert_difference('Treatment.count') do
      post treatments_path, params: { treatment: { visit_id: @visit.id, procedure_id: @procedure.id } }
    end
    assert_redirected_to visit_path(Treatment.last.visit)

    post treatments_path, params: { treatment: { visit_id: @visit.id, procedure_id: nil } }
    assert_template :new
  end


  test "should destroy treatment" do
    assert_difference('Treatment.count', -1) do
      delete treatment_path(@treatment)
    end

    assert_redirected_to visit_path(@treatment.visit)
  end
end
