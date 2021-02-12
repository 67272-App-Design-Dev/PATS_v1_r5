Feature: Manage visits
  As an veterinarian
  I want to be able to create, read and update visits in the system
  So make sure the core of my veterinarian business runs correctly

  Background:
    Given an initial setup
    Given a logged in user
  

  # CREATE METHODS
  # Really just trying to show access via datepicker in materializecss...
  
  Scenario: Creating a new visit is successful
    When I go to the new visit page
    # Then show me the page
    And I fill in "visit_date" with "18 February, 2018"
    And I fill in "visit_weight" with "1"
    And I select "Dusty (Cat) : Heimann, Alex" from "visit_pet_id"
    And I press "Create Visit"
    Then I should see "Successfully added visit"

