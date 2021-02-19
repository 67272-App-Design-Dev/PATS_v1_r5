class Pet < ApplicationRecord
  # Relationships
  # -----------------------------
  belongs_to :animal
  belongs_to :owner
  has_many :visits
  has_many :dosages, through: :visits
  has_many :treatments, through: :visits
  # has_many :notes, as: :notable


  # Scopes
  # -----------------------------
  # order pets by their name
  scope :alphabetical, -> { order('name') }
  # get all the pets we treat (not moved away or dead)
  scope :active, -> { where(active: true) }
  # get all the pets we heave treated that moved away or died
  scope :inactive, -> { where.not(active: true) }
  # alternative ways of doing the inactive scope:
  # scope :inactive, -> { where(active: false) }
  # scope :inactive, -> { where('active = ?', true) }
  # get all the female pets
  scope :females, -> { where(female: true) }
  # get all the male pets
  scope :males, -> { where(female: false) }

  # get all the pets for a particular owner
  scope :for_owner, ->(owner_id) { where("owner_id = ?", owner_id) }
  # get all the pets who are a particular animal type
  scope :by_animal, ->(animal_id) { where("animal_id = ?", animal_id) }
  # get all the pets born before a certain date
  scope :born_before, ->(dob) { where('date_of_birth < ?', dob) }
  # find all pets that have a name like some term or are and animal like some term
  scope :search, ->(term) { where('pets.name LIKE ?', "#{term}%").order("pets.name") }


  # Validations
  # -----------------------------
  # System note:   not requiring DOB because may not be known (e.g., adopted pet)
  # Teaching note: could have done validates_presence_of :name, but using a different
  #                method discussed in class to show alternative
  #
  # First, make sure a name exists
  validates :name, presence: true
  # Second, make sure the animal is one of the types PATS treats
  validate :animal_type_treated_by_PATS
  # Third, make sure the owner_id is in the PATS system 
  validate :owner_is_active_in_PATS_system
  

  # Misc Methods and Constants
  # -----------------------------
  # a method to get owner name in last, first format
  def gender
    return "Female" if self.female
    "Male"
    # self.female ? "Female" : "Male"
    # if self.female 
    #   return "Female"
    # else
    #   return "Male"
    # end
  end  
  
  
  # Use private methods to execute the custom validations
  # -----------------------------
  private
  def animal_type_treated_by_PATS
    # get an array of all animal ids PATS treats
    treated_animal_ids = Animal.all.map{|a| a.id}
    # add error unless the animal id of the pet is in the array of possible animal ids
    unless treated_animal_ids.include?(self.animal_id)
      errors.add(:animal, "is an animal type not treated by PATS")
    end
  end
  
  def owner_is_active_in_PATS_system
    # get an array of all active owners in the PATS system
    all_owner_ids = Owner.active.all.map{|o| o.id}
    # add error unless the owner id of the pet is in the array of active owners
    unless all_owner_ids.include?(self.owner_id)
      errors.add(:owner, "is not an active owner in PATS")
    end
  end
end
