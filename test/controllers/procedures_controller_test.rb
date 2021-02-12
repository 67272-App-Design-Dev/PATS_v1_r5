require 'test_helper'

class ProceduresControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @procedure = FactoryBot.create(:procedure)
    # @procedure_cost = FactoryBot.create(:procedure_cost, procedure: @procedure)
  end

  test "should get index" do
    get procedures_path
    assert_response :success
  end

  test "should get new" do
    get new_procedure_path
    assert_response :success
  end

  test "should create procedure" do
    assert_difference('Procedure.count') do
      post procedures_path, params: { procedure: { name: "Prime Checkup", description: @procedure.description, length_of_time: @procedure.length_of_time, active: true } }
    end

    assert_redirected_to procedure_path(Procedure.last)

    post procedures_path, params: { procedure: { name: nil, description: @procedure.description, length_of_time: @procedure.length_of_time, active: true } }
    assert_template :new
  end

  test "should show procedure" do
    get procedure_path(@procedure)
    assert_response :success
  end

  test "should get edit" do
    get edit_procedure_path(@procedure)
    assert_response :success
  end

  test "should update procedure" do
    patch procedure_path(@procedure), params: { procedure: { name: "Prime Checkup", description: @procedure.description, length_of_time: @procedure.length_of_time, active: true } }
    assert_redirected_to procedure_path(@procedure)

    patch procedure_path(@procedure), params: { procedure: { name: nil, description: @procedure.description, length_of_time: @procedure.length_of_time, active: true } }
    assert_template :edit
  end

  test "should destroy procedure" do
    assert_difference('Procedure.count', -1) do
      delete procedure_path(@procedure)
    end

    assert_redirected_to procedures_path
  end
end


