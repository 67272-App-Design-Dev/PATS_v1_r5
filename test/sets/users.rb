module Contexts
  module Users
    # Context for both vet and assistant users
    def create_vet_users
      @jordan = FactoryBot.create(:user, first_name: "Jordan", last_name: "Stapinski", username: "jordan", role: "vet")
      @becca  = FactoryBot.create(:user, first_name: "Becca", last_name: "Kern", username: "becca", role: "vet")
      @connor = FactoryBot.create(:user, first_name: "Connor", last_name: "Hanley", username: "connor", role: "vet")
    end
    
    def destroy_vet_users
      @jordan.delete
      @becca.delete
      @connor.delete
    end

    def create_assistant_users
      @egruberman = FactoryBot.create(:user)
      @tgruberman = FactoryBot.create(:user, first_name: "Ted", username: "ted")
    end

    def destroy_assistant_users
      @egruberman.delete
      @tgruberman.delete
    end

    def create_owner_users
      @alex_user = FactoryBot.create(:user, first_name: "Alex", last_name: "Heimann", username: "alex", role: "owner")
      @rachel_user = FactoryBot.create(:user, first_name: "Rachel", last_name: "Heimann", username: "rachel", role: "owner", active: false)
      @mark_user = FactoryBot.create(:user, first_name: "Mark", last_name: "Heimann", username: "mark", role: "owner")      
    end

    def destroy_owner_users
      @alex_user.delete 
      @rachel_user.delete 
      @mark_user.delete
    end

  end
end