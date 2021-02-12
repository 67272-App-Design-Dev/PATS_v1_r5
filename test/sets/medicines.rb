module Contexts
  module Medicines

    def create_medicines
      @rabies      = FactoryBot.create(:medicine)
      @carprofen   = FactoryBot.create(:medicine, name: 'Carprofen', description: 'Used to relieve pain and inflammation in dogs. Annedotal reports of severe GI effects in cats.', stock_amount: 50, vaccine: false)
      @amoxicillin = FactoryBot.create(:medicine, name: 'Amoxicillin', description: 'Antibiotic indicated for susceptible gram positive and gram negative infections. Ineffective against species that produce beta-lactamase.', vaccine: false)
    end
    
    def destroy_medicines
      @rabies.delete  
      @carprofen.delete
      @amoxicillin.delete
    end

  end
end