module Contexts
  module AnimalMedicines

    def create_animal_medicines
      @cat_rabies         = FactoryBot.create(:animal_medicine, animal: @cat, medicine: @rabies)
      @dog_rabies         = FactoryBot.create(:animal_medicine, animal: @dog, medicine: @rabies)
      @dog_carprofen      = FactoryBot.create(:animal_medicine, animal: @dog, medicine: @carprofen)
      @cat_amoxicillin    = FactoryBot.create(:animal_medicine, animal: @cat, medicine: @amoxicillin)
      @ferret_amoxicillin = FactoryBot.create(:animal_medicine, animal: @ferret, medicine: @amoxicillin)
    end
    
    def destroy_animal_medicines
      @cat_rabies.delete
      @dog_rabies.delete
      @dog_carprofen.delete
      @cat_amoxicillin.delete
      @ferret_amoxicillin.delete
    end

  end
end