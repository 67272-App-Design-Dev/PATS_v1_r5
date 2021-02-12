class Procedure < ApplicationRecord
  # Relationships
  has_many :procedure_costs
  has_many :treatments
  has_many :visits, through: :treatments

  # Scopes
  scope :alphabetical, -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where.not(active: true) }
  
  # Validations
  validates_presence_of :name
  validates_numericality_of :length_of_time, only_integer: true, greater_than: 0
  
  # Other methods
  # attr_accessor :destroyable

  def current_cost
    curr_cost_of_procedure = self.procedure_costs.current    
    return nil if curr_cost_of_procedure.empty?
    curr_cost_of_procedure.first.cost
  end

  # Callbacks
  # before_destroy :is_destroyable?
  # after_rollback :convert_to_inactive

  # private
  # def is_destroyable?
  #   @destroyable = self.treatments.empty?
  # end

  # def convert_to_inactive
  #   if !destroyable.nil? && destroyable == false
  #     self.update_attribute(:active, false)
  #   end
  #   @destroyable = nil
  # end
end
