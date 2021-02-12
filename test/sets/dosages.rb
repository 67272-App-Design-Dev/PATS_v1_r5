module Contexts
  module Dosages

    def create_dosages
      @visit1_d1 = FactoryBot.create(:dosage, visit: @visit1, medicine: @rabies)
      @visit2_d1 = FactoryBot.create(:dosage, visit: @visit2, medicine: @rabies)
      @visit2_d2 = FactoryBot.create(:dosage, visit: @visit2, medicine: @amoxicillin, discount: 0.10)    
    end
    
    def destroy_dosages
      @visit1_d1.delete
      @visit2_d1.delete
      @visit2_d2.delete
    end

  end
end