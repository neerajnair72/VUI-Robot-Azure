*** Settings ***
Documentation    Test automation of landboats.com
Library    SeleniumLibrary
Library    Collections
Library    String
Library    LambdaTestStatus.py

*** Variables ***
# Configuration
${TIMEOUT}    120 Secs
${URL}    https://stg.aemsites:F93bwU8c9G@stg-www.mercuryracing.com?mboxDisable=1
#${BROWSER}          ${ROBOT_BROWSER}
&{options}          platformName=${platformName}    version=${version}    visual=${visual}    network=${network}    name=RobotFramework LambdaTest    browserName=${browserName}    smartUI.project=Boston Whaler   build=%{LT_BUILD_NAME}
&{CAPABILITIES}     LT:Options=&{options}
${REMOTE_URL}       https://neerajn:0z5UPFS7WDpZutTHEfSZWn3iOZz8Eydmh49evnJuNEqjTaXCd8@hub.lambdatest.com/wd/hub


# Home Page
${HOME PAGE TITLE}    Fishing, Center Console, Cruising & Tender Boats | Boston Whaler®
${HOME PAGE LINK}    xpath=//a[@title="Lund Boats"]

# Dealer Search
${FIND A DELAER BUTTON}    xpath=//span[contains(text(),'FIND A DEALER')]
${DEALER ADDRESS TEXT}    xpath=//input[@id="inputFindDealer"]
${DEALER COUNTRY LIST}    xpath=//select[@id="ln-ctry-code"]
${DEALER SEARCH ICON}    xpath=//span[contains(@class,'js-dealersearch')]
${FILTER BY BOAT TYPE LIST}    xpath=//select[@class="dealerfilter"]//following-sibling::div[1]
${DEALER SEARCH RESULTS}    xpath=//lable[@class='card-lable']
${DELAER SEARCH PAGE TITLE}    Lund Boat Dealers Near Me: Fishing, Bass Jon, Crappie Dealerships

# Build and Price
${BOATS MENU}    xpath=//a[@role="menuitem"]/span[text()="Boats"]
${BUILD PRICE LINK}    xpath=//a[text()="Build & Price"]
${BUILD PAGE TITLE}    Build Your Boat | Lund
${BOAT PRICE LABEL}    xpath=//div[@class="priceHeader"]//p[@class="boatPrice"]
${NEXT BUTTON}    xpath=//div[@id="nxt"]
${VIEW SUMMARY BUTTON}    xpath=//button[text()="View Summary"]
${VIEW SUMMARY ZIP TEXT}    xpath=(//input[@name="Zip"])[3]
${YOUR DEALER LABEL}    xpath=//h3[text()="YOUR DEALER"]
${TOTAL PRICE LABEL}    xpath=//h4[@class="fr_totalPrice"]

*** Keywords ***
Launch Application Using
    [Documentation]    Keyword to Launch Website 
    #[Arguments]    ${Browser}
    Set Selenium Timeout    ${TIMEOUT}
    #Open Browser    ${URL}    ${Browser}    remote_url=${LAMBDA URL}    desired_capabilities=name: ${SUITE_NAME}
    Open browser  ${URL}  browser=${browserName}
    ...  remote_url=${REMOTE_URL}
    ...  desired_capabilities=${CAPABILITIES}
    Set Window Position    0    0
    Set Window Size    1920    1024    

Navigate To Home Page
    [Documentation]    Keyword to Navigate to Homepage by clicking on Logo
    #Click Element    ${HOME PAGE LINK}
    #Title Should Be    ${HOME PAGE TITLE}
    # TRY
    #    Title Should Be    ${HOME PAGE TITLE} 
    # EXCEPT    AS    ${error_message}
    #     ${e}    Set Variable    ${error_message}        
	#     Log To Console    ${e}
	# 	@{exceptions}=    Create List   
	# 	Append To List    ${exceptions}    ${e}    
	# 	Log To Console    ${exceptions}
	# 	Execute Javascript    lambda-exceptions    ARGUMENTS    ${exceptions}
        
    # END
    [Teardown]    Capture Page Screenshot

Navigate To Dealer Search
    [Documentation]    Keyword to Click on Dealer Search on Top Left area
    Click Element    ${FIND A DELAER BUTTON}
    Sleep    5s
    Execute Javascript  smartui.takeScreenshot

Dealer Countries Should Contain
    [Documentation]    Keyword to verify the Dealer country list
    [Arguments]    @{Country List}
    #Execute Javascript    smartui.takeScreenshot   
    ${Actual Country List}    Get List Items     ${DEALER COUNTRY LIST}
    Lists Should Be Equal    ${Country List}    ${Actual Country List}

Search For A Dealer
    [Documentation]    Keyword to Search for a Dealer by Address
    [Arguments]    ${Country}    ${Address}
    Wait Until Element Is Visible    ${DEALER COUNTRY LIST}
    Select From List By Label    ${DEALER COUNTRY LIST}    ${Country}
    Input Text    ${DEALER ADDRESS TEXT}   ${Address}
    #Capture Page Screenshot
    Click Element    ${DEALER SEARCH ICON}

Dealer Count Should Be
    [Documentation]    Keyword to verify the Dealer search result count
    [Arguments]    ${Count}
    Title Should Be    ${DELAER SEARCH PAGE TITLE}
    Wait Until Element Is Visible    ${FILTER BY BOAT TYPE LIST}
    ${Actual Count}    Get Element Count    ${DEALER SEARCH RESULTS}
    Set Selenium Timeout    15s
    Should Be Equal As Integers    ${Count}    ${Actual Count}
    [Teardown]    Capture Page Screenshot

Navigate To Boat Model
    [Documentation]    Keyword to Navigate to a Model by Category and Name
    [Arguments]    ${Category}    ${Model}
    Click Element    ${BOATS MENU}
    Wait Until Element Is Visible    xpath=//a[text()="${Category}"]
    Click Element    xpath=//a[text()="${Category}"]
    Sleep    3    Waiting for Menu to appear
    Wait Until Element Is Visible    xpath=//a[text()="${Category}"]//following::a[text()="${Model}"]
    Click Element    xpath=//a[text()="${Category}"]//following::a[text()="${Model}"]

Model Preview Should Contain Header
    [Documentation]    Keyword to verify Model Preview Popup Header
    [Arguments]    ${Header}
    Wait Until Keyword Succeeds    10    2    Element Should Be Visible    xpath=//div[@class="tab-pane fade active show"]//h3[text()="${Header}"]
    [Teardown]    Capture Page Screenshot

Navigate to Model Overview
    [Documentation]    Keyword to select a Model from Menu
    [Arguments]    ${Model}
    Wait Until Element Is Visible    xpath=//div[@class="tab-pane fade active show"]//a[normalize-space(text())="${Model} Overview"]
    Click Element    xpath=//div[@class="tab-pane fade active show"]//a[normalize-space(text())="${Model} Overview"]

Model Overview Page Should Be Visible
    [Documentation]    Keyword to verify title of Model Overview Page
    [Arguments]    ${Model}
    Title Should Be    Family Fish and Ski Boats, Best Sports Combo | Lund® ${Model}
    [Teardown]    Capture Page Screenshot

Navigate To Build And Price
    [Documentation]    Keyword to Navigate to Build and Price
    Click Element    ${BUILD PRICE LINK}
    Title Should Be    ${BUILD PAGE TITLE}
    [Teardown]    Capture Page Screenshot

Select A Model To Build
    [Documentation]    Keyword to Select a Model by Category and Model Name
    [Arguments]    ${Category}    ${Model}
    Click Element    xpath=//span[text()="${Category}"]
    Click Element    xpath=//div[contains(@class,"active")]//h5[text()="${Model}"]/../following-sibling::div/a[text()="SELECT A MODEL"]
    Wait Until Element Is Visible    xpath=//div[contains(@class,"show")]//h4[text()="SELECT YOUR ${Model} MODEL:"]
    [Teardown]    Capture Page Screenshot

Build The Lund
    [Documentation]    Keyword to click on Build a Model
    [Arguments]    ${Sub Model}
    Click Element    xpath=//div[contains(@class,"show")]//h5[@aria-label="${Sub Model}"]//following::a[1]

Boat Configuration Page Should Be Visible
    [Documentation]    Keyword to verify title of Boat Model Configuration Page
    [Arguments]    ${Boat Model Page Title}
    Title Should Be    ${Boat Model Page Title}
    [Teardown]    Capture Page Screenshot

Get Boat Base Price
    [Documentation]    Keyword to get Base Price of the Model under configuration
    ${Price}    Get Element Attribute    ${BOAT PRICE LABEL}    data-dnprice
    [Return]    ${Price}

Configure A Boat
    [Documentation]    Keyword to select configuration options
    [Arguments]    ${Color}    ${Motor}    ${Options}
    Click Element    ${NEXT BUTTON}
    Click Element    ${NEXT BUTTON}
    Click Element    xpath=//p[text()="${Options}"]/../label
    ${Option Price}    Get Text    xpath=//p[text()="${Options}"]/following-sibling::p
    ${Option Price}    Replace String    ${Option Price}    $    ${EMPTY}
    ${Option Price}    Convert To Number    ${Option Price}
    Click Element    ${NEXT BUTTON}
    [Return]    ${Option Price}
    
View Build Summary For Zip
    [Documentation]    Keyword to view Build Summary for a Zip Code
    [Arguments]    ${ZIP Code}
    Wait Until Element Is Visible    ${VIEW SUMMARY BUTTON}
    Input Text    ${VIEW SUMMARY ZIP TEXT}    ${ZIP Code}
    Click Element    ${VIEW SUMMARY BUTTON}
    Wait Until Element Is Visible    ${YOUR DEALER LABEL}
    [Teardown]    Capture Page Screenshot

Estimated Boat Price Should Be Base Price Plus Options Price
    [Documentation]    Keyword to verify Estimated Price = Base Price + Options
    [Arguments]    ${Base Price}    ${Option Price}
    Wait Until Element Is Visible    ${TOTAL PRICE LABEL}
    ${Total Price}    Get Text    ${TOTAL PRICE LABEL}
    ${Total Price}    Remove String    ${Total Price}    $    *    ,
    ${Total Price}    Convert To Number    ${Total Price}
    ${Expected Price}    Evaluate    ${Base Price}+${Option Price}
    Should Be Equal As Numbers    ${Expected Price}    ${Total Price}
    [Teardown]    Capture Page Screenshot

Close Application
    [Documentation]    Keyword to close all browsers
     Run keyword if  '${REMOTE_URL}' != ''
    ...  Report Lambdatest Status
    ...  ${TEST_NAME} 
    ...  ${TEST_STATUS} 
    #Report Lambdatest Status    ${TEST NAME}    ${TEST STATUS}
    Close All Browsers
    
    
    
