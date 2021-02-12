require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def new_user(attributes = {})
    attributes[:first_name] ||= 'Ed'
    attributes[:last_name] ||= 'Gruberman'
    attributes[:role] ||= 'assistant'
    attributes[:username] ||= 'foo'
    attributes[:password] ||= 'secret'
    attributes[:password_confirmation] ||= attributes[:password]
    user = User.new(attributes)
    user.valid? # run validations
    user
  end

  def setup
    User.delete_all
  end

  def test_valid
    assert new_user.valid?
  end

  def test_require_first_name
    assert_equal ["can't be blank"], new_user(first_name: '').errors[:first_name]
  end

  def test_require_last_name
    assert_equal ["can't be blank"], new_user(last_name: '').errors[:last_name]
  end

  def test_require_username
    assert_equal ["can't be blank"], new_user(username: '').errors[:username]
  end

  def test_require_password
    assert_equal ["can't be blank"], new_user(password: '').errors[:password]
  end

  def test_name_is_set
    assert_equal "Gruberman, Ed", new_user().name
  end

  def test_proper_name_is_set
    assert_equal "Ed Gruberman", new_user().proper_name
  end

  def test_validate_uniqueness_of_username
    new_user(username: 'uniquename').save!
    assert_equal ["has already been taken"], new_user(username: 'uniquename').errors[:username]
  end

  def test_validate_role_types
    assert new_user(role: 'vet').valid?
    assert new_user(role: 'assistant').valid?
    deny new_user(role: 'nurse').valid?
  end

  def test_role_boolean_method
    assert new_user().role?(:assistant)
    deny new_user().role?(:vet)
  end

  def test_validate_password_length
    deny new_user(password: 'bad').valid?
  end

  def test_require_matching_password_confirmation
    deny new_user(password_confirmation: 'nonmatching').valid?
  end

  def test_authenticate_by_username
    User.delete_all
    user = new_user(username: 'foobar', password: 'secret')
    user.save!
    assert_equal user, User.authenticate('foobar', 'secret')
  end

  def test_authenticate_bad_username
    assert_nil User.authenticate('nonexisting', 'secret')
  end

  def test_authenticate_bad_password
    User.delete_all
    new_user(username: 'foobar', password: 'secret').save!
    deny User.authenticate('foobar', 'badpassword')
  end
end
