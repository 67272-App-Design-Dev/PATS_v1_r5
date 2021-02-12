module Contexts
  module Visits

    def create_visits
      @visit1 = FactoryBot.create(:visit, pet: @dusty)
      @visit2 = FactoryBot.create(:visit, pet: @polo, date: 5.months.ago.to_date)
      @visit3 = FactoryBot.create(:visit, pet: @polo, date: 2.months.ago.to_date)    
    end
    
    def destroy_visits
      @visit1.delete
      @visit2.delete
      @visit3.delete
    end

  end
end