module Contexts
  module MedicineCosts

    def create_medicine_costs
      @rabies_c1      = FactoryBot.create(:medicine_cost, medicine: @rabies, start_date: 12.months.ago.to_date)
      @rabies_c2      = FactoryBot.create(:medicine_cost, medicine: @rabies, start_date: 6.months.ago.to_date, cost_per_unit: 30)
      @carprofen_c1   = FactoryBot.create(:medicine_cost, medicine: @carprofen, start_date: 11.months.ago.to_date, cost_per_unit: 50)
      @amoxicillin_c1 = FactoryBot.create(:medicine_cost, medicine: @amoxicillin, start_date: 10.months.ago.to_date, cost_per_unit: 40)

      @rabies_c1.end_date = 6.months.ago.to_date
      @rabies_c1.save
    end
    
    def destroy_medicine_costs
      @rabies_c1.delete     
      @rabies_c2.delete    
      @carprofen_c1.delete 
      @amoxicillin_c1.delete 
    end

  end
end