require 'test_helper'

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_vet
    @owner = FactoryBot.create(:owner)
  end

  test "should get index" do
    get owners_path
    assert_response :success
  end

  test "should get new" do
    get new_owner_path
    assert_response :success
  end

  test "should create owner" do
    assert_difference('Owner.count') do
      post owners_path, params: { owner: { active: @owner.active, city: @owner.city, email: "eheimann@example.com", first_name: "Eric", last_name: @owner.last_name, phone: @owner.phone, state: @owner.state, street: @owner.street, zip: @owner.zip } }
    end

    assert_redirected_to owner_path(Owner.last)

    post owners_path, params: { owner: { active: @owner.active, city: @owner.city, email: @owner.email, first_name: nil, last_name: @owner.last_name, phone: @owner.phone, state: @owner.state, street: @owner.street, zip: @owner.zip } }
    assert_template :new
  end

  test "should show owner" do
    get owner_path(@owner)
    assert_response :success
  end

  test "should get edit" do
    get edit_owner_path(@owner)
    assert_response :success
  end

  test "should update owner" do
    patch owner_path(@owner), params: { owner: { active: @owner.active, city: @owner.city, email: @owner.email, first_name: "Alexander", last_name: @owner.last_name, phone: @owner.phone, state: @owner.state, street: @owner.street, zip: @owner.zip } }
    assert_redirected_to owner_path(@owner)

    patch owner_path(@owner), params: { owner: { active: @owner.active, city: @owner.city, email: @owner.email, first_name: nil, last_name: @owner.last_name, phone: @owner.phone, state: @owner.state, street: @owner.street, zip: @owner.zip } }
    assert_template :edit
  end

  test "should destroy owner" do
    assert_difference('Owner.count', -1) do
      delete owner_path(@owner)
    end

    assert_redirected_to owners_path
  end
end
