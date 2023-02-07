*** Settings ***
Documentation    Test automation of landboats.com
Library        SeleniumLibrary
Library    Collections
Library    String
Library    EyesLibrary    web    ../rf-resources/applitools.yaml

*** Keywords ***
Start Visual Test
    [Documentation]    Keyword to start Visual Automation Test
    [Arguments]    ${Test Name}
    Eyes Open    ${Test Name}

Page Should Visually Match
    [Documentation]    Keyword to Check current window Visually
    [Arguments]    ${Page}
    Sleep    5s    Allow Page to Refresh
    Eyes Check Window

Stop Visual Test
    [Documentation]    Keyword to stop Visual Automation Test
    Eyes Close Async    False