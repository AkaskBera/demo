*** Keywords ***

Wait Text
    [Arguments]  ${text}
    Wait Until Page Contains  ${text}  timeout=20s