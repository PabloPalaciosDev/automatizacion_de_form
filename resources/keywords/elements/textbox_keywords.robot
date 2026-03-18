*** Settings ***
Library    SeleniumLibrary
Resource    ../../variables/variables.robot

*** Keywords ***
Abrir Pagina Text Box
    Go TO    ${URL_TEXTBOX}
    Wait Until Element Is Visible    id:userName    timeout=${TIMEOUT}

Llenar Formulario Text Box
    [Arguments]    ${nombre}    ${email}    ${direccion_actual}    ${direccion_permanente}
    Input Text    id:userName    ${nombre}
    Input Text    id:userEmail    ${email}
    Input Text    id:currentAddress    ${direccion_actual}
    Input Text    id:permanentAddress    ${direccion_permanente}

Enviar Formulario Text Box
    Click Button    id:submit

Verificar Salida Text Box
    [Arguments]    ${nombre}    ${email}
    Wait Until Element Is Visible    id:output    timeout=${TIMEOUT}
    Element Should Contain    id:name     ${nombre}
    Element Should Contain    id:email    ${email}