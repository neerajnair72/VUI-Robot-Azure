*** Settings ***
Documentation    Test suite to verify Look and Feel
Resource    ../rf-keywords/Functional.robot
Resource    ../rf-keywords/Visual.robot
Suite Setup     Launch Application Using    chrome
Test Setup    Navigate To Home Page
Suite Teardown    Run Keywords    Close Application    Eyes Get All Test Results

*** Test Cases ***
Dealer Search Screens Should Visually Match
    [Tags]    Dealer Search    Visual    Regression
    [Documentation]    Test Case to verify Look and Feel of Dealer Search
    Start Visual Test    Dealer Search
    Page Should Visually Match    Home Page
    Navigate To Dealer Search
    Page Should Visually Match    Dealer Search
    Search For A Dealer    USA    60007
    Dealer Count Should Be    4
    Page Should Visually Match    Dealer Search Results
    Stop Visual Test