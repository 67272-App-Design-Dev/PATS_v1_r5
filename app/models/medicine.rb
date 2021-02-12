class Medicine < ApplicationRecord
  
  # Relationships
  has_many :animal_medicines
  has_many :animals, :through => :animal_medicines
  has_many :medicine_costs
  has_many :dosages
  has_many :visits, :through => :dosages

  # Scopes
  scope :alphabetical, -> { order('name') }
  scope :active,       -> { where(active: true) }
  scope :depleted,     -> { where('stock_amount < ?', 100) }
  scope :vaccines,     -> { where(vaccine: true) }
  scope :nonvaccines,  -> { where(vaccine: false) }
  scope :for_animal,   ->(animal_id) { joins(:animal_medicines).where('animal_medicines.animal_id = ?', animal_id) }
  scope :for_visit,    ->(visit_id) { joins(:dosages).where('dosages.visit_id = ?', visit_id) }
  
  # Validations
  validates_presence_of :name
  validates_numericality_of :stock_amount, :only_integer => true, :greater_than_or_equal_to => 0
  
  # Other methods
  # attr_accessor :destroyable

  def is_vaccine?
    vaccine
  end
  
  def current_cost_per_unit
    curr_cost_of_medicine = self.medicine_costs.current
    return nil if curr_cost_of_medicine.empty?
    curr_cost_of_medicine.first.cost_per_unit
  end

  # Callbacks
  # before_destroy :is_destroyable?
  # after_rollback :convert_to_inactive

  # private
  # def is_destroyable?
  #   @destroyable = self.dosages.empty?
  # end

  # def convert_to_inactive
  #   if !destroyable.nil? && destroyable == false
  #     self.update_attribute(:active, false)
  #   end
  #   @destroyable = nil
  # end
end
