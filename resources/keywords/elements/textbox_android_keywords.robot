*** Settings ***
Library    AppiumLibrary
Resource    ../../variables/appium_variables.robot

*** Keywords ***
Abrir Chrome En Android
    Open Application    ${APPIUM_URL}
    ...    platformName=${PLATFORM}
    ...    deviceName=${DEVICE_NAME}
    ...    platformVersion=${PLATFORM_VERSION}
    ...    browserName=${BROWSER_NAME}
    ...    automationName=${AUTOMATION_NAME}
    ...    chromedriverAutodownload=${CHROMEDRIVER_AUTODOWNLOAD}
    ...    uiautomator2ServerInstallTimeout=${SERVER_INSTALL_TIMEOUT}

Abrir Pagina Text Box Android
    Go To Url    ${URL_TEXTBOX}
    Wait Until Element Is Visible    xpath=//*[@id='userName']    timeout=${TIMEOUT}

Llenar Formulario Text Box Android
    [Arguments]    ${nombre}    ${email}    ${direccion_actual}    ${direccion_permanente}
    Input Text    xpath=//*[@id='userName']              ${nombre}
    Input Text    xpath=//*[@id='userEmail']             ${email}
    Input Text    xpath=//*[@id='currentAddress']        ${direccion_actual}
    Input Text    xpath=//*[@id='permanentAddress']      ${direccion_permanente}

Enviar Formulario Text Box Android
    Execute Script    window.scrollTo(0, document.body.scrollHeight);
    Sleep    1s
    Execute Script    document.getElementById('submit').click();
    Sleep    2s

Verificar Salida Text Box Android
    [Arguments]    ${nombre}    ${email}
    Wait Until Element Is Visible    xpath=//*[@id='output']    timeout=20s
    Element Should Contain Text    xpath=//*[@id='name']     ${nombre}
    Element Should Contain Text    xpath=//*[@id='email']    ${email}
