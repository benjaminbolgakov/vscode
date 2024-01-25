# robocop: disable=missing-doc-suite
*** Settings ***
Resource            ../../Common/EVC/RigSetup.robot
Resource            ../../Common/EVC/CalculateRPMValues.robot
Library             ../../Common/EVC/ODM.py
# Test Template       Data-Driven Template    # Applies template to all test-cases in suite.

Suite Setup         Suite Setup
Suite Teardown      Suite Teardown

Test Setup          Setup Rig
Test Teardown       Run Keyword If Test Failed    Log    Test failed..
Test Tags           TestTag1    TestTag2


*** Variables ***
${STRING_VAR}    Some string value
${PATH_VAR}    C:\\Users\\atm
${FLAG_VAR}    shell\=bash
${INT_VAR}    ${1}
@{LIST_VAR}    @{EMPTY}
&{DICT_VAR}    &{EMPTY}


*** Test Cases ***
Example Test
    [Documentation]     [Version:] ${BASELINE}
    ...                 [Configuration:] ${Configuration}
    ...                 [DrivelineMultiplicity:] ${DrivelineMultiplicity}
    ...                 [EngineType:] ${EngineType}
    ...                 [Requirement reference:] EVC-xxxx/y, EVC-xxxx/y
    ...                 [Purpose:] Descriptive text ...
    [Tags]              Tag1    Tag2    Tag3
    Preparation
    FOR  ${FUNCTION}  ${GEAR}  IN ZIP  ${Functions}  ${Gears}
        Set Test Variable    ${FUNCTION}
        Set Test Variable    ${GEAR}
        @{L1} =  Create List    item1    item2
        @{L2} =  Create List    @{EMPTY}
        Append To List    ${L2}    item1    item2
        &{D1} =  Create Dictionary    k1=value1    k2=value2
        &{D2} =  Copy Dictionary    ${D1}
        Set To Dictionary    ${DICT_VAR}    k1=value1    k2=value2
        Precondition
        Keyword With "Embedded" Arguments
        # Testing ...
    END

Data-Driven Test
    [Documentation]     [Version:] ${BASELINE}
    ...                 [Configuration:] ${Configuration}
    ...                 [DrivelineMultiplicity:] ${DrivelineMultiplicity}
    ...                 [EngineType:] ${EngineType}
    ...                 [Requirement reference:] EVC-xxxx/y, EVC-xxxx/y
    ...                 [Purpose:] Will run 'Data-Driven Template' keyword with each row of args
    [Tags]              Tag4
    [Template]          Data-Driven Template
    ${ARG1} =  input-data-1    ${ARG2} =  ${2}
    ${ARG1} =  input-data-2    ${ARG2} =  ${3}
    ${ARG1} =  input-data-3

Data-Driven Test Embedded Args
    [Documentation]     [Version:] ${BASELINE}
    ...                 [Configuration:] ${Configuration}
    ...                 [DrivelineMultiplicity:] ${DrivelineMultiplicity}
    ...                 [EngineType:] ${EngineType}
    ...                 [Requirement reference:] EVC-xxxx/y, EVC-xxxx/y
    ...                 [Purpose:] ...
    [Tags]              Tag5
    [Template]          Data-Driven Template With ${ARGS_TYPE} Args
    embedded

Data-Driven Test Looped
    [Documentation]     [Version:] ${BASELINE}
    ...                 [Configuration:] ${Configuration}
    ...                 [DrivelineMultiplicity:] ${DrivelineMultiplicity}
    ...                 [EngineType:] ${EngineType}
    ...                 [Requirement reference:] EVC-xxxx/y, EVC-xxxx/y
    ...                 [Purpose:] ...
    [Tags]              Tag6
    [Template]          Data-Driven Template
    FOR  ${ITEM}  IN  @{LIST_VAR}
        ${ITEM}    OPT_ARG
    END


*** Keywords ***
Data-Driven Template
    [Documentation]    Data-driven test template ...
    [Arguments]    ${ARG1}    ${ARG2}=${0}
    Log    Doing testing with: ${ARG1} - ${ARG2}

Data-Driven Template With ${ARGS_TYPE} Args
    [Documentation]    Keyword with embedded args ...
    ${RESULT} =  Convert To Upper Case    ${ARGS_TYPE}
    Should Be Equal    ${RESULT}    EMBEDDED

Keyword With ${TYPE} Arguments
    [Documentation]    Embedded arguments ...
    Log    ${TYPE}

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
