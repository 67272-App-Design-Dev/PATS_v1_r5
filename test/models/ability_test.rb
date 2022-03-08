require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of vet users to do everything" do
      create_vet_abilities
      assert @vet_ability.can? :manage, :all
      delete_vet_abilities
    end

    should "verify the abilities of assistant users in PATS" do
      create_assistant_abilities
    # #   # no global privileges
      deny @egruberman_ability.can? :manage, :all
    # #   # testing particular abilities
      assert @egruberman_ability.can? :manage, Owner
      assert @egruberman_ability.can? :manage, Pet
      assert @egruberman_ability.can? :manage, Visit
      assert @egruberman_ability.can? :manage, Dosage
      assert @egruberman_ability.can? :manage, Treatment
      assert @egruberman_ability.can? :read, Medicine
      assert @egruberman_ability.can? :read, Procedure
      assert @egruberman_ability.can? :show, @egruberman
      assert @egruberman_ability.can? :update, @egruberman
      deny @egruberman_ability.can? :show, @vet_user
      deny @egruberman_ability.can? :update, @vet_user
      delete_assistant_abilities
    end

    should "verify the abilities of owner users in PATS" do
      create_owner_abilities
      # no global privileges
      deny @alex_ability.can? :manage, :all
      # testing particular abilities
      deny @alex_ability.can? :show, @alex_user # double check this later
      assert @alex_ability.can? :index, Pet
      assert @alex_ability.can? :index, Visit
      assert @alex_ability.can? :show, @dusty
      deny @alex_ability.can? :show, @pork_chop
      assert @alex_ability.can? :show, @visit1
      visit_pc = FactoryBot.create(:visit, pet: @pork_chop)
      deny @alex_ability.can? :show, visit_pc
      visit_pc.delete
      delete_owner_abilities
    end

    should "verify the abilities of guest users to read crimes" do
      create_guest_abilities
      deny @guest_ability.can? :manage, :all
      deny @guest_ability.can? :read, Animal
      delete_guest_abilities
    end
  end
end