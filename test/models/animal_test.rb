require 'test_helper'

class AnimalTest < ActiveSupport::TestCase
  # Not much for testing Animal as it is a simple model
  # Relationship matchers...
  should have_many(:pets)
  should have_many(:medicines)
  
  # Validation matchers...
  should validate_presence_of(:name)

    context "Creating animals context" do
    # create the objects I want with factories
    setup do 
      create_animals
    end
    
    # and provide a teardown method as well
    teardown do
      destroy_animals
    end
  
    # now run the tests:
    # test the scope 'alphabetical'
    should "shows that animals are listed in alphabetical order" do
      assert_equal ["Bird", "Cat", "Dog", "Ferret", "Rabbit", "Turtle"], Animal.alphabetical.map{|a| a.name}
    end
    
    # test the scope 'active'
    should "shows that there are five active animals" do
      assert_equal 5, Animal.active.size
      # assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
      assert_equal ["Bird", "Cat", "Dog", "Ferret", "Rabbit"], Animal.active.map{|a| a.name}.sort
    end

    # test the scope 'inactive'
    should "shows that there is one inactive animal" do
      assert_equal 1, Animal.inactive.size
      # assert_equal ["Alex", "Mark"], Owner.active.alphabetical. map{|o| o.first_name}
      assert_equal ["Turtle"], Animal.inactive.map{|a| a.name}.sort
    end
  end
end
