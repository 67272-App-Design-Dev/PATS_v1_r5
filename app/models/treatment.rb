class Treatment < ApplicationRecord
  # Relationships
  belongs_to :visit
  belongs_to :procedure
  has_one :pet, :through => :visit

  # Scopes
  scope :for_procedure, ->(procedure_id) { where("procedure_id = ?", procedure_id) }
  scope :for_visit,     ->(visit_id) { where("visit_id = ?", visit_id) }
  scope :alphabetical,  -> { joins(:procedure).order("procedures.name") }
  
  # Validations
  validates_numericality_of :discount, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 1

  # Callbacks
  before_create :update_total_cost_of_visit
  before_destroy :refund_amount_in_cost_of_visit

  private
  def update_total_cost_of_visit
    visit = self.visit
    previous_charge = (visit.total_charge.nil? ? 0 : visit.total_charge)
    previous_costs = ProcedureCost.for_procedure(self.procedure_id).for_date(self.visit.date)
    if previous_costs.empty?  # shouldn't be the case, but...
      cost_of_new_procedure = 0
    else
      cost_of_new_procedure = previous_costs.first.cost
    end
    new_charge = previous_charge + (cost_of_new_procedure * (1 - self.discount))
    visit.update_attribute(:total_charge, new_charge)
  end

  def refund_amount_in_cost_of_visit
    visit = self.visit
    previous_charge = visit.total_charge
    previous_costs = ProcedureCost.for_procedure(self.procedure_id).for_date(self.visit.date)
    if previous_costs.empty?  # shouldn't be the case, but...
      cost_of_old_procedure = 0
    else
      cost_of_old_procedure = previous_costs.first.cost
    end
    revised_charge = previous_charge - (cost_of_old_procedure * (1 - self.discount))
    visit.update_attribute(:total_charge, revised_charge)    
  end
end
