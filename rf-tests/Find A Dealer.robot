*** Settings ***
Documentation    Test Case to validate UI on Find a Dealer page
Resource    ../rf-keywords/Functional.robot
Suite Setup     Launch Application Using
Test Teardown    Close Application

*** Test Cases ***
Validate UI on Find a Dealer page
    [Tags]    Dealer Search    Functional   Smoke
    [Documentation]    Test Case to Validate UI on Find a Dealer page 
    Navigate To Dealer Search
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   #   TRY
   #      Dealer Count Should Be    20 
   #   EXCEPT    AS    ${error_message}
   #      ${e}    Set Variable    ${error_message}        
	#     Log To Console    ${e}
	# 	@{exceptions}=    Create List   
	# 	Append To List    ${exceptions}    ${e}    
	# 	Log To Console    ${exceptions}
	# 	Execute Javascript    lambda-exceptions    ARGUMENTS    ${exceptions}
	# 	Log To Console    ${TEST_STATUS}
         
   #   END
     #Dealer Count Should Be    20

# Dealer Search Should Be Successful
#     [Tags]    Dealer Search    Functional    Regression
#     [Documentation]    Test Case to verify successful dealer search by Zip Code
#      Navigate To Dealer Search
     