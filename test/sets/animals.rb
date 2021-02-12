module Contexts
  module Animals

    def create_animals
      @cat    = FactoryBot.create(:animal)
      @dog    = FactoryBot.create(:animal, name: 'Dog')
      @bird   = FactoryBot.create(:animal, name: 'Bird')
      @ferret = FactoryBot.create(:animal, name: 'Ferret')
      @rabbit = FactoryBot.create(:animal, name: 'Rabbit')
      @turtle = FactoryBot.create(:animal, name: 'Turtle', active: false)
    end
    
    def destroy_animals
      @cat.delete  
      @dog.delete
      @bird.delete
      @ferret.delete
      @rabbit.delete
      @turtle.delete
    end

  end
end