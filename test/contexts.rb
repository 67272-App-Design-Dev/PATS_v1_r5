# require needed files
require './test/sets/animals'
require './test/sets/owners'
require './test/sets/pets'
require './test/sets/medicines'
require './test/sets/medicine_costs'
require './test/sets/animal_medicines'
require './test/sets/procedures'
require './test/sets/procedure_costs'
require './test/sets/visits'
require './test/sets/dosages'
require './test/sets/treatments'
require './test/sets/users'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Animals
  include Contexts::Owners
  include Contexts::Pets
  include Contexts::Medicines
  include Contexts::MedicineCosts
  include Contexts::AnimalMedicines
  include Contexts::Procedures
  include Contexts::ProcedureCosts
  include Contexts::Visits
  include Contexts::Dosages
  include Contexts::Treatments
  include Contexts::Users
  
  def create_all
    puts "Building context..."
    create_vet_users
    puts "Built users"
    create_animals
    puts "Built animals"
    create_medicines
    puts "Built medicines"
    create_medicine_costs
    puts "Built medicine costs"
    create_animal_medicines
    puts "Linked medicines to animals"
    create_procedures
    puts "Built procedures"
    create_procedure_costs
    puts "Built procedure costs"
    create_owners
    puts "Built owners"
    create_pets
    puts "Built pets"
    create_visits
    puts "Built visits"
    create_dosages
    puts "Built dosages"
    create_treatments
    puts "Built treatments"
  end
  
end