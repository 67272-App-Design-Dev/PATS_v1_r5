module Contexts
  module Pets

    def create_pets
      @dusty = FactoryBot.create(:pet, animal: @cat, owner: @alex, female: false)
      @polo = FactoryBot.create(:pet, animal: @cat, owner: @alex, name: "Polo", active: false)
      @pork_chop = FactoryBot.create(:pet, animal: @dog, owner: @mark, name: "Pork Chop")
    end
    
    def destroy_pets
      @dusty.delete
      @polo.delete
      @pork_chop.delete
    end

  end
end