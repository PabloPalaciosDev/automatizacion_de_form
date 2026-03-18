*** Settings ***
Library       AppiumLibrary
Resource    ../../resources/keywords/forms/forms_android_keywords.robot
Resource    ../../resources/variables/appium_variables.robot

Suite Setup    Abrir Chrome En Android
Suite Teardown    Close All Applications

*** Test Cases ***
TC01 - Llenar formulario completo Practice Form en Android
    [Documentation]    Completar todos los campos del Student Registration Form
    Abrir Pagina Practice Form
    Llenar Nombre Y Apellido    Maria    Garcia
    Llenar Email    maria@test.com
    Seleccionar Genero    Female
    Llenar Telefono    1234567891
    Llenar Fecha Nacimiento    17    Mar    2000
    Llenar Subjects    Maths
    Seleccionar Hobbies    Sports
    Seleccionar Hobbies    Reading
    Subir Foto    ${FOTO_PATH}
    Llenar Direccion Actual    Ciudad de Panama, Panama
    Seleccionar Estado    NCR
    Seleccionar Ciudad    Delhi
    Enviar Formulario
    Verificar Envio Exitoso
    Cerrar Modal

TC02 - Verificar campos obligatorios vacios
    [Documentation]    Intentar enviar el formulario sin llenar campos obligatorios
    Abrir Pagina Practice Form
    Enviar Formulario
    Wait Until Element Is Visible    xpath=//*[contains(@class,'was-validated')]    timeout=${TIMEOUT}
