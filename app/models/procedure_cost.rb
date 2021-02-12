class ProcedureCost < ApplicationRecord
  # Relationships
  belongs_to :procedure

  # Scopes
  scope :chronological, -> { order('start_date') }
  scope :current,       -> { where(end_date: nil) }
  scope :for_date,      ->(date) { where("start_date <= ? AND (end_date > ? OR end_date IS NULL)", date, date) }
  scope :for_procedure,  ->(procedure_id) { where(procedure_id: procedure_id) }

  
  # Validations
  validates_numericality_of :cost, :only_integer => true, :greater_than_or_equal_to => 0
  validates_date :start_date

  # Callback (to handle in sqlite what we would have done in a postrges trigger)
  before_create :set_end_date_of_old_cost

  private
  def set_end_date_of_old_cost
    previous = ProcedureCost.current.for_procedure(self.procedure_id).take
    previous.update_attribute(:end_date, self.start_date) unless previous.nil?
  end
end
