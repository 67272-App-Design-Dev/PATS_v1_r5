Feature: Standard Business
  As a user
  I want to be able to view certain information
  So I can have basic confidence in the system
  
  Background:

  Scenario: Do not see the default rails page
    When I go to the home page
    Then I should not see "You're riding Ruby on Rails!"
    And I should not see "About your application's environment"
    And I should not see "Create your database" 

  Scenario: View 'About PATS'
    When I go to the About Us page
    Then I should see "About Pittsburgh Animal Treatment Services"
    And I should see "We know how important your pets are to you."
    And I should not see "Lorem"
    And I should not see "lorem"
    And I should not see "ipsum"

  Scenario: View 'Contact Us'
    When I go to the Contact Us page
    Then I should see "Contacting PATS"
    And I should see "here's the contact information below"
    And I should not see "Lorem"
    And I should not see "lorem"
    And I should not see "ipsum"

  Scenario: View 'Privacy Policy'
    When I go to the Privacy page
    Then I should see "Privacy"
    And I should see "The PATS Privacy Policy"
    And I should see "don't tell us"
    And I should not see "Lorem"
    And I should not see "lorem"
    And I should not see "ipsum"

  Scenario: View webmaster information in footer
    When I go to the home page
    Then I should see "Webmaster" within "#footer"
    And I should not see "Lorem"
    And I should not see "lorem"
    And I should not see "ipsum"
  
  Scenario: Navigation exists to link resources
    Given an initial setup
    Given a logged in user
    When I go to the home page
    # Then show me the page
    And I click on the link "Pets"
    Then I should see "Active Pets at PATS"
    And I should see "Dusty"
    And I should see "Pork Chop"
    And I should see "Inactive Pets"
    And I click on the link "Owners"
    Then I should see "Active Owners in PATS"
    And I should see "Heimann, Mark"
    And I should see "412-268-8211"
    And I should not see "Sudberry"
    And I click on the link "Visits"
    Then I should see "Visits at PATS"
    And I should see "Date"
    And I should see "Pet"
    And I should see "Weight"
    And I should see "Options"
    And I should see "Polo (Cat)"
    And I should see "5.0 lbs"
