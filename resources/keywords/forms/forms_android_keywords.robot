*** Settings ***
Library    AppiumLibrary
Library    Process
Resource    ../../variables/appium_variables.robot
Library    ${CURDIR}/forms_helper.py    WITH NAME    FormsHelper

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

Abrir Pagina Practice Form
    Go To Url    ${URL_FORM}
    Wait Until Element Is Visible    xpath=//*[@id='firstName']    timeout=${TIMEOUT}
    Execute Script    window.scrollTo(0,0);

Llenar Nombre Y Apellido
    [Arguments]    ${nombre}    ${apellido}
    Input Text    xpath=//*[@id='firstName']    ${nombre}
    Input Text    xpath=//*[@id='lastName']     ${apellido}

Llenar Email
    [Arguments]    ${email}
    Input Text    xpath=//*[@id='userEmail']    ${email}

Seleccionar Genero
    [Arguments]    ${genero}
    ${script}=    FormsHelper.Js Click Genero    ${genero}
    Execute Script    ${script}
    Sleep    1s

Llenar Telefono
    [Arguments]    ${telefono}
    Input Text    xpath=//*[@id='userNumber']    ${telefono}

Llenar Fecha Nacimiento
    [Arguments]    ${dia}    ${mes}    ${anio}
    ${js_open}=       FormsHelper.Js Abrir Datepicker
    Execute Script    ${js_open}
    Wait Until Element Is Visible    xpath=//*[contains(@class,'react-datepicker__month-select')]    timeout=${TIMEOUT}
    Sleep    0.5s
    ${mes_idx}=       FormsHelper.Obtener Indice Mes    ${mes}
    ${js_mes}=        FormsHelper.Js Seleccionar Mes    ${mes_idx}
    Execute Script    ${js_mes}
    Sleep    0.8s
    ${js_anio}=       FormsHelper.Js Seleccionar Anio    ${anio}
    Execute Script    ${js_anio}
    Sleep    0.8s
    ${js_dia}=        FormsHelper.Js Seleccionar Dia    ${dia}
    Execute Script    ${js_dia}
    Sleep    0.8s

Llenar Subjects
    [Arguments]    ${subject}
    Input Text    xpath=//*[@id='subjectsInput']    ${subject}
    Sleep    2s
    Wait Until Element Is Visible    xpath=//div[contains(@class,'subjects-auto-complete__option')]    timeout=${TIMEOUT}
    ${js_subject}=    FormsHelper.Js Click Primera Opcion Subject
    Execute Script    ${js_subject}
    Sleep    1s

Seleccionar Hobbies
    [Arguments]    ${hobby}
    ${id}=    Run Keyword If    '${hobby}' == 'Sports'     Set Variable    hobbies-checkbox-1
    ...       ELSE IF           '${hobby}' == 'Reading'    Set Variable    hobbies-checkbox-2
    ...       ELSE IF           '${hobby}' == 'Music'      Set Variable    hobbies-checkbox-3
    ${script}=    FormsHelper.Js Click Hobby    ${id}
    Execute Script    ${script}
    Sleep    2s

Subir Foto
    [Arguments]    ${ruta_archivo}
    Run Process    adb    -s    ${DEVICE_NAME}    push    ${ruta_archivo}    /sdcard/Download/foto.jpg
    Sleep    1s
    ${js_scroll}=    FormsHelper.Js Scroll To Upload
    Execute Script    ${js_scroll}
    Sleep    0.5s
    ${js_upload}=    FormsHelper.Js Simular Upload
    Execute Script    ${js_upload}
    Sleep    2s

Llenar Direccion Actual
    [Arguments]    ${direccion}
    Input Text    xpath=//*[@id='currentAddress']    ${direccion}

Seleccionar Estado
    [Arguments]    ${estado}
    Execute Script    document.getElementById('state').scrollIntoView({block:'center'});
    Sleep    1s
    ${js_state}=    FormsHelper.Js Click Estado
    Execute Script    ${js_state}
    Sleep    2s
    ${js_opcion}=    FormsHelper.Js Click Opcion Dropdown    state    ${estado}
    Execute Script    ${js_opcion}
    Sleep    1.5s
    Wait Until Element Is Visible    xpath=//*[@id='state']//div[contains(@class,'singleValue')]    timeout=${TIMEOUT}
    Element Should Contain Text    xpath=//*[@id='state']//div[contains(@class,'singleValue')]    ${estado}

Seleccionar Ciudad
    [Arguments]    ${ciudad}
    Execute Script    document.getElementById('city').scrollIntoView({block:'center'});
    Sleep    1s
    ${js_city}=    FormsHelper.Js Click Ciudad
    Execute Script    ${js_city}
    Sleep    2s
    ${js_opcion}=    FormsHelper.Js Click Opcion Dropdown    city    ${ciudad}
    Execute Script    ${js_opcion}
    Sleep    1.5s
    Wait Until Element Is Visible    xpath=//*[@id='city']//div[contains(@class,'singleValue')]    timeout=${TIMEOUT}
    Element Should Contain Text    xpath=//*[@id='city']//div[contains(@class,'singleValue')]    ${ciudad}

Enviar Formulario
    ${js_scroll}=    FormsHelper.Js Scroll Bottom
    Execute Script    ${js_scroll}
    Sleep    1s
    ${js_submit}=    FormsHelper.Js Click Submit
    Execute Script    ${js_submit}
    Sleep    2s

Verificar Envio Exitoso
    Wait Until Element Is Visible    xpath=//*[@id='example-modal-sizes-title-lg']    timeout=${TIMEOUT}
    Element Should Contain Text    xpath=//*[@id='example-modal-sizes-title-lg']    Thanks for submitting the form

Cerrar Modal
    Wait Until Element Is Visible    xpath=//*[@id='closeLargeModal']    timeout=${TIMEOUT}
    Execute Script    document.getElementById('closeLargeModal').click();
    Wait Until Keyword Succeeds    10x    500ms    Verificar Modal Cerrado

Verificar Modal Cerrado
    ${modal_abierto}=    Execute Script    return document.querySelector('.modal.show') !== null;
    Should Be Equal    ${modal_abierto}    ${False}
