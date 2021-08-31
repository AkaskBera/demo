*** Settings ***
Library    SeleniumLibrary
Resource    ../Utilities/commonUtil.robot
Resource    ../Utilities/locators.robot

Suite Setup  User is allowed to Open India Bookstore
Suite Teardown  Close my Browser

#Robot -d report -i demo  demo.robot
*** Test Cases ***
Verify Book selected from fiction
    [Tags]    demo
    #[Setup]
    #Given User is allowed to Open India Bookstore
    When Search for Fiction book
    And User Navigate to Fiction category and clicks on expected book
    #[Teardown]

*** Keywords ***
User is allowed to Open India Bookstore
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Search for Fiction book
    #Wait Until Element Contains  xpath=//div[@class='books-category']/ul/li[12]
    Wait Until Page Contains  ${fic_text}  timeout=20s
    Click Element  ${fic_elem}

User Navigate to Fiction category and clicks on expected book
    ${count} =  Get Element Count  ${elm_count}
    Log to Console  ${count}

    FOR  ${j}  IN RANGE  1  ${count}
        ${bk_text} =  Get Text  xpath=//div[@id='listSearchResult']/div[${j}]/div[3]/div[1]/a
        Log to Console  ${bk_text}
        Scroll Element Into View  xpath=//div[@id='listSearchResult']/div[${j}]/div[3]/div[1]/a
        Exit For Loop If  "${bk_text}" == "Batman: Gotham Knights: Contested"
    END
    Set Suite Variable  ${expected_book}   xpath=//div[@id='listSearchResult']/div[${j}]/div[3]/div[1]/a
    Click Element  ${expected_book}
    Log to Console     expected book matches with the required book

Close my Browser
    Close Browser


