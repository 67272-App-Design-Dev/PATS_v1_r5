module Contexts
  module Owners

    def create_owners
      create_owner_users
      @alex = FactoryBot.create(:owner, user: @alex_user)
      @rachel = FactoryBot.create(:owner, first_name: "Rachel", active: false, user: @rachel_user)
      @mark = FactoryBot.create(:owner, first_name: "Mark", phone: "412-268-8211", user: @mark_user)
    end
    
    def destroy_owners
      @rachel.delete
      @mark.delete
      @alex.delete
    end

  end
end