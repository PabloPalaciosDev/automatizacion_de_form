*** Settings ***
Library       AppiumLibrary
Resource      ../../resources/keywords/elements/textbox_android_keywords.robot
Resource      ../../resources/variables/appium_variables.robot

Suite Setup       Abrir Chrome En Android
Suite Teardown    Close All Applications

*** Test Cases ***
TC01 - Llenar formulario Text Box en Android
    [Documentation]    Abrir demoqa en Chrome Android y llenar el formulario
    Abrir Pagina Text Box Android
    Llenar Formulario Text Box Android    Juan Perez    juan@email.com    Calle 1    Calle 2
    Enviar Formulario Text Box Android
    Verificar Salida Text Box Android    Juan Perez    juan@email.com