Feature: Room_Period_Table

Background:
	Given I run loaddata to populate dropdowns
	And I register the user "lucas@gmail.com" with the password "123456" and registration number "140016574"
	And I register the booking "monitoria" with the building "UAC" with the place name "FGA-I1" and start_date "2016-11-21" and end_date "2016-11-30" of user "lucas@gmail.com"

Scenario: Inexistent booking between start date and end date
	When I login in with email "lucas@gmail.com" and password "123456"
	Then I visit site page "/booking/searchbookingg/"
	And I choose "Room x Period"
	And I select "UAC" from "Building"
	And I select "UAC | FGA-I1" from "Place"
	And I fill in "Start Date" with "10/20/2016"
	And I fill in "End Date" with "10/30/2016"
	Then I press "Search"
	Then I should see "Doesnt exist any booking in this period of time"

Scenario: Inexistent booking in the specified room
	When I login in with email "lucas@gmail.com" and password "123456"
	Then I visit site page "/booking/searchbookingg/"
    And I choose "Room x Period"
    And I select "UED" from "Building"
    And I select "UED | FGA-LAB_MATERIAIS" from "Place"
    And I fill in "Start Date" with "11/21/2016"
    And I fill in "End Date" with "11/30/2016"
    Then I press "Search"
    Then I should see "Doesnt exist any booking in this place"

Scenario: Start date lower than actual date
	When I login in with email "lucas@gmail.com" and password "123456"
    Then I visit site page "/booking/searchbookingg/"
    And I choose "Room x Period"
	And I select "UAC" from "Building"
	And I select "UAC | FGA-I1" from "Place"
    And I fill in "Start Date" with "11/10/2015"
    And I fill in "End Date" with "11/30/2016"
    Then I press "Search"
    Then I should see "Start date must be from future date"

Scenario: End date lower than actual date
    When I login in with email "lucas@gmail.com" and password "123456"
    Then I visit site page "/booking/searchbookingg/"
    And I choose "Room x Period"
    And I select "UAC" from "Building"
    And I select "UAC | FGA-I1" from "Place"
    And I fill in "Start Date" with "11/30/2016"
    And I fill in "End Date" with "11/30/2015"
    Then I press "Search"
    Then I should see "End date must be from future date"

Scenario: Start Date greater then End Date
    When I login in with email "lucas@gmail.com" and password "123456"
    Then I visit site page "/booking/searchbookingg/"
    And I choose "Room x Period"
    And I select "UAC" from "Building"
    And I select "UAC | FGA-I1" from "Place"
    And I fill in "Start Date" with "11/31/2016"
    And I fill in "End Date" with "11/30/2016"
    Then I press "Search"
    Then I should see "End date must be equal or greater then Start date"

#   Scenario: All valid inputs
 #   When I login in with email "lucas@gmail.com" and password "123456"
  #  Then I visit site page "/booking/searchbookingg/"
  #  And I choose "Room x Period"
  #  And I select "UAC" from "Building"
  #  And I select "UAC | FGA-I1" from "Place"
 #   And I fill in "Start Date" with "11/21/2016"
 #   And I fill in "End Date" with "11/30/2016"
 #   Then I press "Search"
 #   Then I should see "ROOM X PERIOD"
