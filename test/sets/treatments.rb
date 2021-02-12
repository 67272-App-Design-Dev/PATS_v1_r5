module Contexts
  module Treatments

    def create_treatments
      @visit2_t1 = FactoryBot.create(:treatment, visit: @visit2, procedure: @checkup)
      @visit2_t2 = FactoryBot.create(:treatment, visit: @visit2, procedure: @xray, discount: 0.10)    
      @visit1_t1 = FactoryBot.create(:treatment, visit: @visit1, procedure: @checkup)
    end
    
    def destroy_treatments
      @visit1_t1.delete
      @visit2_t1.delete
      @visit2_t2.delete
    end

  end
end