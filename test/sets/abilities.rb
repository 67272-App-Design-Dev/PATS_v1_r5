module Contexts
    module Abilities
      def create_vet_abilities
        @vet_user = FactoryBot.create(:user, username: "vet", role: "vet")
        @vet_ability = Ability.new(@vet_user)
      end
  
      def delete_vet_abilities
        @vet_user.delete
      end
  
      def create_assistant_abilities
        create_assistant_users
        @egruberman_ability = Ability.new(@egruberman)
        # created related objects for testing
        create_animals
        create_owners
        create_pets
        create_visits
        create_procedures
        create_procedure_costs
        create_treatments
        create_medicines
        create_medicine_costs
        create_animal_medicines
        create_dosages
      end
  
      def delete_assistant_abilities
        destroy_dosages
        destroy_animal_medicines
        destroy_medicine_costs
        destroy_medicines
        destroy_treatments
        destroy_procedure_costs
        destroy_procedures
        destroy_visits
        destroy_pets
        destroy_animals
        destroy_owners
        destroy_assistant_users
      end
  
      def create_owner_abilities
        create_owners
        @alex_ability = Ability.new(@alex_user)
        @mark_ability = Ability.new(@mark_user)
        
        # created related objects for testing
        create_animals
        create_pets
        create_visits
        create_procedures
        create_procedure_costs
        create_treatments
        create_medicines
        create_medicine_costs
        create_animal_medicines
        create_dosages
      end
  
      def delete_owner_abilities
        destroy_dosages
        destroy_animal_medicines
        destroy_medicine_costs
        destroy_medicines
        destroy_treatments
        destroy_procedure_costs
        destroy_procedures
        destroy_visits
        destroy_pets
        destroy_animals
        destroy_owners
      end
  
      def create_guest_abilities
        @guest_user = User.new
        @guest_ability = Ability.new(@guest_user)
      end
  
      def delete_guest_abilities
        # nothing to delete, b/c nothing saved to db
      end
  
    end
  end