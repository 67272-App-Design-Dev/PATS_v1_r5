require 'test_helper'

class ProcedureCostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @procedure      = FactoryBot.create(:procedure)
    @procedure_cost = FactoryBot.create(:procedure_cost, procedure: @procedure)
  end

  test "should get new" do
    get new_procedure_cost_path(procedure_id: @procedure.id)
    assert_response :success
  end

  test "should create medicine cost" do
    assert_difference('ProcedureCost.count') do
      post procedure_costs_path, params: { procedure_cost: { procedure_id: @procedure.id, cost: 42 } }
    end
    assert_redirected_to procedure_path(ProcedureCost.last.procedure)

    post procedure_costs_path, params: { procedure_cost: { procedure_id: @procedure.id, cost: nil } }
    assert_template :new
  end

end