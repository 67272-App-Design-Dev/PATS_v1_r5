class AnimalMedicine < ApplicationRecord
  # Relationships
  belongs_to :animal
  belongs_to :medicine

  # Validations
  validates_numericality_of :recommended_num_of_units, :only_integer => true, :greater_than_or_equal_to => 0, :allow_blank => true
  
  # Scopes
  scope :for_animal,   ->(animal_id) { where(animal_id: animal_id) }
  scope :for_medicine, ->(medicine_id) { where(medicine_id: medicine_id) }
end
