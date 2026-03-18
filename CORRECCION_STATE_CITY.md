# Correccion State/City en DemoQA Practice Form (Appium + Robot + Python)

## Problema observado
- El test marcaba `PASS`, pero los campos `State` y `City` no quedaban seleccionados en `https://demoqa.com/automation-practice-form`.

## Causa raiz
- Los dropdowns `State` y `City` son `React Select`.
- `React Select` abre el menu principalmente con evento `mousedown`, no solo con `click`.
- El helper usaba `click` y una busqueda de opciones demasiado generica (`div[id*="option"]`), por lo que podia no seleccionar la opcion correcta o no seleccionar nada.
- El flujo no validaba explicitamente que `State`/`City` quedaran con valor, entonces el caso podia pasar sin detectar el fallo.

## Correccion implementada

### 1) Apertura robusta del dropdown (React Select)
- Archivo: `resources/keywords/forms/forms_helper.py`
- Se actualizo la apertura de `State` y `City` para disparar `mousedown` + `click` sobre el control visible del componente.

### 2) Seleccion de opcion acotada al contenedor correcto
- Archivo: `resources/keywords/forms/forms_helper.py`
- Se reemplazo la funcion duplicada de seleccion por una sola funcion:
  - `js_click_opcion_dropdown(contenedor_id, texto)`
- Esta funcion:
  - Detecta el input React Select dentro de `state` o `city`.
  - Construye el prefijo real de opciones (`*-option-*`) para ese dropdown.
  - Hace click en la opcion exacta por texto.
  - Lanza error si no encuentra la opcion (ahora falla rapido si algo sale mal).

### 3) Validacion explicita en Robot Framework
- Archivo: `resources/keywords/forms/forms_android_keywords.robot`
- Se modificaron los keywords:
  - `Seleccionar Estado`
  - `Seleccionar Ciudad`
- Cambios:
  - Ahora llaman `FormsHelper.Js Click Opcion Dropdown    state|city    valor`.
  - Se agrego verificacion del valor seleccionado:
    - `Wait Until Element Is Visible ... singleValue`
    - `Element Should Contain Text ... ${estado}/${ciudad}`

## Resultado esperado despues de la correccion
- Si `State` o `City` no se seleccionan, el test ahora debe fallar.
- Si se seleccionan correctamente, el test pasa con evidencia real del valor en UI.

## Recomendaciones para evitar recurrencia
- En componentes React Select, usar siempre apertura por `mousedown` cuando se automatiza por JS.
- Evitar selectores globales para opciones; acotar por contenedor/componente.
- Agregar aserciones de estado final (no solo acciones).
- Evitar funciones duplicadas en helpers (pueden ocultar comportamiento real).

## Nota de validacion local
- Se valido sintaxis de Python con:
  - `python -m py_compile resources/keywords/forms/forms_helper.py`
- No se pudo ejecutar `robot --dryrun` en este entorno porque no esta instalado `robotframework`.
