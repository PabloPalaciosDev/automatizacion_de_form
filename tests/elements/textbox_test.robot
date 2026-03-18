*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords/elements/textbox_keywords.robot
Resource    ../../resources/variables/variables.robot

Suite Setup       Open Browser    ${URL_TEXTBOX}    ${BROWSER}
Suite Teardown    Close All Browsers

*** Test Cases ***

TC01 - Llenar y enviar formulario Text BOX
    [Documentation]    Completar todos los campos y verificar el output
    Abrir Pagina Text Box 
    Llenar Formulario Text Box    Juan Perez    juan@email.com    Calle1    Calle2
    Enviar Formulario Text Box
    Verificar Salida Text Box    Juan Perez    juan@email.com