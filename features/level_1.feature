Feature: Manage owners
  As an veterinarian
  I want to be able to create, read and update owners in the system
  So make sure the core of my veterinarian business runs correctly

  Background:
    Given an initial setup
    Given a logged in user
  
  # READ METHODS
  Scenario: No owners yet
    Given no setup yet
    When I go to the owners page
    Then I should see "There are no owners in the system at this time"
    And I should not see "Phone"
    And I should not see "Email"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View all owners
    When I go to the owners page
    Then show me the page
    Then I should see "Active Owners in PATS"
    And I should see "Owner"
    And I should see "Phone"
    And I should see "Email"
    And I should not see "Street"
    And I should not see "City"
    And I should see "Heimann, Mark"
    And I should see "412-268-8211"
    And I should see "mark.heimann@example.com"
    And I should not see "Sudberry"
    And I should not see "Wexford"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View owner details
    When I go to the details on Mark Heimann
    And I should see "Mark Heimann"
    And I should see "Home Address:"
    And I should see "10152 Sudberry Drive"
    And I should see "Wexford, PA 15090"
    And I should see "412-268-8211"
    And I should see "Active with PATS?"
    And I should see "Mark's Pets"
    And I should see "Pork Chop"
    And I should see "Dog"
    And I should not see "Alex"
    And I should not see "Dusty"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"
  
  Scenario: The owner name is a link to owner details
    When I go to the owners page
    And I click on the link "Heimann, Mark"
    And I should see "Mark Heimann"
    And I should see "Wexford, PA 15090"
    And I should see "Pork Chop"

  Scenario: The pet name on owner page is a link to pet details
    When I go to the owners page
    And I click on the link "Heimann, Mark"
    And I click on the link "Pork Chop"
    And I should see "Pet Information for Pork Chop"
    And I should see "Recent Visits"

  
  # CREATE METHODS
  Scenario: Creating a new owner is successful
    When I go to the new owner page
    And I fill in "owner_first_name" with "Ed"
    And I fill in "owner_last_name" with "Gruberman"
    And I fill in "owner_street" with "5001 Forbes Avenue"
    And I fill in "owner_city" with "Pittsburgh"
    And I select "Pennsylvania" from "owner_state"
    And I fill in "owner_zip" with "15213"
    And I fill in "owner_phone" with "(412) 268-2323"
    And I fill in "owner_email" with "egruberman@example.com"
    And I press "Create Owner"
    Then I should see "Successfully created Ed Gruberman"
    And I should see "Home Address:"
    And I should see "5001 Forbes Avenue"
    And I should see "Pittsburgh, PA 15213"
    And I should see "412-268-2323"
    And I should see "No pets at this time"

  
  Scenario: Creating a new owner fails without last name
    When I go to the new owner page
    And I fill in "owner_first_name" with "Ed"
    And I fill in "owner_street" with "5001 Forbes Avenue"
    And I fill in "owner_city" with "Pittsburgh"
    And I select "Pennsylvania" from "owner_state"
    And I fill in "owner_zip" with "15213"
    And I fill in "owner_phone" with "(412) 268-2323"
    And I fill in "owner_email" with "egruberman@example.com"
    And I press "Create Owner"
    Then I should see "can't be blank"
    Then I should not see "Successfully created Ed Gruberman"
    And I should not see "412-268-2323"


  # UPDATE METHODS
  Scenario: Editing an existing owner is successful
    When I go to the edit Alex page
    Then I should see "Editing Owner"
    And I fill in "owner_phone" with "412.268.3259"
    And I press "Update Owner"
    Then I should see "Successfully updated Alex Heimann"
    And I should see "412-268-3259"