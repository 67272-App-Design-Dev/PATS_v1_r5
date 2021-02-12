module Contexts
  module ProcedureCosts

    def create_procedure_costs
      @checkup_c1 = FactoryBot.create(:procedure_cost, procedure: @checkup, start_date: 12.months.ago.to_date)
      @checkup_c2 = FactoryBot.create(:procedure_cost, procedure: @checkup, start_date: 6.months.ago.to_date, cost: 3000)
      @xray_c1    = FactoryBot.create(:procedure_cost, procedure: @xray, start_date: 11.months.ago.to_date, cost: 4000)
      @dental_c1  = FactoryBot.create(:procedure_cost, procedure: @dental, start_date: 10.months.ago.to_date,  cost: 2000)

      @checkup_c1.end_date = 6.months.ago.to_date
      @checkup_c1.save
    end
    
    def destroy_procedure_costs
      @checkup_c1.delete  
      @checkup_c2.delete
      @xray_c1.delete
      @dental_c1.delete
    end

  end
end