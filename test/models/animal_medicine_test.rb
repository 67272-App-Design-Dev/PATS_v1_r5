require 'test_helper'

class AnimalMedicineTest < ActiveSupport::TestCase
  # Relationship matchers...
  should belong_to(:animal)
  should belong_to(:medicine)
  
  # Validation matchers...
  should validate_numericality_of(:recommended_num_of_units).only_integer.is_greater_than_or_equal_to(0)
  should allow_value(nil).for(:recommended_num_of_units)

  context "Creating context" do
    setup do 
      create_animals
      create_medicines
      create_animal_medicines
    end
    
    teardown do
      destroy_animal_medicines
      destroy_animals
      destroy_medicines
    end
  
    # test the scope 'for_animal'
    should "have a scope for_animal" do
      assert_equal [@dog_carprofen, @dog_rabies], AnimalMedicine.for_animal(@dog).sort_by{|o| o.medicine.name}
    end
    
    # test the scope 'for_medicine'
    should "have a scope for_medicine" do
      assert_equal [@dog_carprofen], AnimalMedicine.for_medicine(@carprofen)
    end
  end
end
