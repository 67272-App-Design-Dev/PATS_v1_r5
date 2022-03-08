class Ability
  include CanCan::Ability

  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    # the notation is simple here: 
    # If the current_user is set, it is fine, otherwise, we create a new user as a guest. 

    
    # set authorizations for different user roles
    if user.role? :vet
      # they get to do it all
      can :manage, :all
      
    elsif user.role? :assistant
      # can manage owners, pets, and visits
      # an assistant can do anything for owner, pets, and visits. 
      # For instance, any action available in OwnersController, they can do it same for Pets and Visits.

      can :manage, Owner # this user can perform all actions (:manage) on the Owner model
      can :manage, Pet # this user can perform all actions on (:manage) the Pet model
      can :manage, Visit # this user can perform all actions on (:manage) the Visit model
      
      # can create and destroy dosages and treatments
      can :manage, Dosage
      can :manage, Treatment

      # can only read (costs for) medicines and procedures
      # They cannot manipulate medicines and procedures: so they got read privileges but not write 
      can :read, Medicine#Cost
      can :read, Procedure#Cost

      # An assistant can read his own profile
      # Basically, an assistant can show a particular user,
      # but only if his ID matches the current user which means himself!
      can :show, User do |u|  
        u.id == user.id
      end

      # Difference between :read and :show -- :read includes show and index together.
      # In this particular case, we are only giving show priviliges

      # An assistant can update his own profile
      can :update, User do |u|  
        u.id == user.id
      end

    elsif user.role? :owner
      # they can read their own data
      can :show, Owner do |this_owner|  
        user.owner == this_owner
      end

      # they can see lists of pets and visits (controller filters automatically)
      can :index, Pet
      can :index, Visit

      # they can read their own pets' data
      can :show, Pet do |this_pet|  
        my_pets = user.owner.pets.map(&:id)
        my_pets.include? this_pet.id 
      end

      # they can read their own visits' data
      can :show, Visit do |this_visit|  
        my_visits = user.owner.visits.map(&:id)
        my_visits.include? this_visit.id 
      end

      
    else
      # guests can only read animals covered (plus home pages)
      # can :read, Animal
    end
  end
end
