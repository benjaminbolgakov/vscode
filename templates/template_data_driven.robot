# robocop: disable=missing-doc-suite
*** Settings ***
Resource            ../../Common/EVC/RigSetup.robot
Resource            ../../Common/EVC/CalculateRPMValues.robot
Library             ../../Common/EVC/ODM.py
Test Template       Data-Driven Template    # Applies template to all test-cases in suite.

Suite Setup         Suite Setup
Suite Teardown      Suite Teardown

Test Setup          Setup Rig
Test Teardown       Run Keyword If Test Failed    Log    Test failed..
Test Tags           TestTag1    TestTag2


*** Variables ***
${STRING_VAR}    Some string value
${INT_VAR}    ${1}
@{LIST_VAR}    @{EMPTY}
&{DICT_VAR}    &{EMPTY}


*** Test Cases ***            USERNAME        PASSWORD
Invalid Username              invalid         ${VALID_PWD}
Invalid Password              ${VALID_USR}    invalid
Correct Login                 ${VALID_USR}    ${VALID_PWD}


*** Keywords ***
Data-Driven Template
    [Documentation]    Data-driven test template ...
    [Arguments]    ${USRNAME}    ${PWD}
    Preparation
    Precondition
    @{L1} =  Create List    item1    item2
    @{L2} =  Create List    @{EMPTY}
    Append To List    ${L2}    item1    item2
    &{D1} =  Create Dictionary    k1=value1    k2=value2
    &{D2} =  Copy Dictionary    ${D1}
    Set To Dictionary    ${DICT_VAR}    k1=value1    k2=value2
    Log    Doing testing with: ${USRNAME} - ${PWD}

Preparation
    [Documentation]    Setting up the test ...
    Calculate RPM Values
    Set Test Variable    @{FUNCTIONS}    Normal  SLC  DCK
    Set Test Variable    @{GEARS}    Forward    Reverse
    Set HCU1 PT Lever To IDLE
    Set HCU1 SB Lever To IDLE

Precondition
    [Documentation]    Precondition the test ...
    Log    Precondition the test ...

Suite Setup
    [Documentation]    Setting up test suite ...
    Setup Rig

Suite Teardown
    [Documentation]    Teardown of test suite ...
    Log    Teardown of test suite
