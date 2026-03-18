*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/Keywords/elements/checkbox_keywords.robot
Resource    ../../resources/variables/variables.robot

Suite Setup     Open Browser    ${URL_CHECKBOX}    ${BROWSER}
Suite Teardown    Close All Browser

*** Test Cases ***

TC01 -Selecionar Checkbox Raiz Home
    [Documentation]    Seleccionar Home selecciona todos los hijos
    Abrir Pagina Checkbox
    Selecionar Checkbox Por Nombre    Home
    Verificar Item Seleccionado en Output    Home

TC02 - Expandir Arbol y Seleccionar Descktop
    [Documentation]    Expandir el arbol y seleccionar Desktop
    Abrir Pagina Checkbox
    Expandir Todo El Arbol
    Seleccionar Checkbox por Nombre    Desktop
    Verificar Item Seleccionado En Output    desktop

TC-03 - Expandir Arbol y Seleccionar Notes
    [Documentation]    Seleccionar un item hoja dentro de Desktop
    Abrir Pagina Checkbox
    Expandir Todo El Arbol
    Seleccionar Checkbox por Nombre    Documents
    Verificar Item Seleccionado En Output    documents

TC04 - Expandir arbol y seleccionar Documents
    [Documentation]    Seleccionar Documents selecciona todos sus hijos
    Abrir Pagina Checkbox
    Expandir Todo El Arbol
    Seleccionar Checkbox Por Nombre    Documents
    Verificar Item Seleccionado En Output    documents

TC-05 Seleccionar multiple checkboxes individuales
    [Documentation]    Seleccionar React y Angular por separados
     Abrir Pagina Checkbox
    Expandir Todo El Arbol
    Seleccionar Checkbox por Nombre    React
    Seleccionar Checkbox por Nombre    Angular
    Verificar Item Seleccionado En Output    react
    Verificar Item Seleccionado En Output    angular

TC06- Expandir Arbol y Seleccionar Downloads
    [Documentation]    Seleccionar Downloads con sus Archivos
    Abrir Pagina Checkbox
    Expandior Todo El Arbol
    Seleccionar Checkbox Por Nombre    Downloads
    Verificar Item Seleccionado En Output    downloads