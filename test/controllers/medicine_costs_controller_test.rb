require 'test_helper'

class MedicineCostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @medicine      = FactoryBot.create(:medicine)
    @medicine_cost = FactoryBot.create(:medicine_cost, medicine: @medicine)
  end

  test "should get new" do
    get new_medicine_cost_path(medicine_id: @medicine.id)
    assert_response :success
  end

  test "should create medicine cost" do
    assert_difference('MedicineCost.count') do
      post medicine_costs_path, params: { medicine_cost: { medicine_id: @medicine.id, cost_per_unit: 42 } }
    end
    assert_redirected_to medicine_path(MedicineCost.last.medicine)

    post medicine_costs_path, params: { medicine_cost: { medicine_id: @medicine.id, cost_per_unit: nil } }
    assert_template :new
  end

end
