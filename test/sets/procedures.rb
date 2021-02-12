module Contexts
  module Procedures

    def create_procedures
      @checkup = FactoryBot.create(:procedure)
      @xray    = FactoryBot.create(:procedure, name: 'X-ray', description: 'X-ray taken of the pet.')
      @dental  = FactoryBot.create(:procedure, name: 'Dental Work', description: 'Dental work for the pet.', active: false)
    end
    
    def destroy_procedures
      @checkup.delete  
      @xray.delete
      @dental.delete
    end

  end
end